(in-package #:in.bitspook.vidhi)

(defclass assisted-reader (html-page-artifact)
  ((article :initarg :article)
   (word-bank :initarg :word-bank)))

(defun reader-page-builder (title &key)
  (lambda (&key css body-html)
    (declare (css-file-artifact css))
    (spinneret:with-html
      (:html
       (:head (:title title)
              (:meta :name "viewport" :content "width=device-width, initial-scale=1")
              (when css (:link :rel "stylesheet" :href (embed-artifact-as css 'link))))
       (:body (:raw body-html))))))

(defun make-assisted-reader (&key word-bank article (title ""))
  (declare (nachtrichtenleicht-article article))

  (let* ((title (if (str:emptyp title) (nacht-article-title article) title))
         (slug (slug:slugify title) )
         (html-path (base-path-join slug "/index.html")))

    (let* ((article-view
             (make 'article-w
                   :title (nlp-words (nacht-article-title article))
                   :description (nlp-words (nacht-article-description article))
                   :content (mapcar #'nlp-words (nacht-article-content article))
                   :word-bank word-bank
                   :audio (nacht-article-audio article)
                   :featured-image (let ((fig (nacht-article-featured-image article)))
                                     (list (first fig) (nlp-words (second fig))))))
           (learner-view
             (make 'word-learner-w
                   :title "Learn words used in article"
                   :word-freq (nach-article-word-freq article)
                   :word-bank word-bank))
           (root (make 'reader-page-w
                       :article-w article-view
                       :word-learner-w learner-view)))

      (make 'assisted-reader
            :deps (list (make 'css-file-artifact
                              :location "/css/style.css"
                              :root-widget root))
            :builder (reader-page-builder title)
            :root-widget root
            :location html-path
            :article article
            :word-bank word-bank))))
