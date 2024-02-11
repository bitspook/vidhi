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

(defmethod publish ((pub assisted-reader-publisher) &key article title (slug "") (base-url "/"))
  (declare (nachtrichtenleicht-article article))

  (let* ((title (if (str:emptyp title) (nacht-article-title article) title))
         (slug (if (str:emptyp slug) (slug:slugify title) slug))
         (nav-links `(("Read" ,(base-path-join base-url slug))
                      ("Prepare" ,(base-path-join base-url slug "/prepare")))))

    (let* ((article-view
             (make 'article-w
                   :title (nacht-article-title article)
                   :description (nacht-article-description article)
                   :content (nacht-article-content article)
                   :featured-image (nacht-article-featured-image article)))
           (root (make 'reader-page-w
                       :content-w article-view
                       :nav-links nav-links
                       :active-nav-index 0))
           (html-path (base-path-join slug "/index.html")))
      (call-next-method
       pub
       :page-builder (page-builder title)
       :root-widget root
       :path html-path))

    (let* ((learner-view
             (make 'word-learner-w
                   :title "Learn words used in article"
                   :word-freq (nach-article-word-freq article)))
           (root (make 'reader-page-w
                       :content-w learner-view
                       :nav-links nav-links
                       :active-nav-index 1))
           (html-path (base-path-join slug "prepare/index.html")))
      (call-next-method
       pub
       :page-builder (page-builder title)
       :root-widget root
       :path html-path))))
