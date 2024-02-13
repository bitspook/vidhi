(in-package #:in.bitspook.vidhi)

(defclass assisted-reader-publisher (html-publisher)
  ((asset-pub :initform (error "Missing argument :asset-pub")
              :initarg :asset-pub)
   (word-bank :initform (error "Missing argument :word-bank")
              :initarg :word-bank))
  (:documentation "Publish independent page"))

(defun page-builder (title &key)
  (lambda (&key css-file html)
    (spinneret:with-html
        (:html
         (:head (:title title)
                (:meta :name "viewport" :content "width=device-width, initial-scale=1")
                (when css-file (:link :rel "stylesheet" :href (str:concat "/" css-file)))
                (:script :src "/js/app.js"))
         (:body (:raw html))))))

(defmethod publish ((pub assisted-reader-publisher) &key article title (slug ""))
  (declare (nachtrichtenleicht-article article))

  (let* ((title (if (str:emptyp title) (nacht-article-title article) title))
         (slug (if (str:emptyp slug) (slug:slugify title) slug)))

    (let* ((article-view
             (make 'article-w
                   :title (nlp-words (nacht-article-title article))
                   :description (nlp-words (nacht-article-description article))
                   :content (mapcar #'nlp-words (nacht-article-content article))
                   :word-bank (slot-value pub 'word-bank)
                   :audio (nacht-article-audio article)
                   :featured-image (let ((fig (nacht-article-featured-image article)))
                                     (list (first fig) (nlp-words (second fig))))))
           (learner-view
             (make 'word-learner-w
                   :title "Learn words used in article"
                   :word-freq (nach-article-word-freq article)
                   :word-bank (slot-value pub 'word-bank)))
           (root (make 'reader-page-w
                       :article-w article-view
                       :word-learner-w learner-view))
           (html-path (base-path-join slug "/index.html")))
      (call-next-method
       pub
       :page-builder (page-builder title)
       :root-widget root
       :path html-path))))
