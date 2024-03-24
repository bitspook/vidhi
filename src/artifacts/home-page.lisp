(in-package #:in.bitspook.vidhi)

(defun home-page-builder (title &key)
  (lambda (&key css body-html)
    (declare (css-file-artifact css))
    (spinneret:with-html
      (:html
       (:head (:title title)
              (:meta :name "viewport" :content "width=device-width, initial-scale=1")
              (when css (:link :rel "stylesheet" :href (embed-artifact-as css 'link))))
       (:body (:raw body-html))))))

(defun make-home-page (&key word-bank articles (title ""))
  (let* ((title (if (str:emptyp title) "Vidhi" title))
         (slug "/")
         (html-path (base-path-join slug "/index.html"))
         (readers (mapcar
                   (op (make-assisted-reader
                        :word-bank word-bank
                        :article _))
                   articles))
         (root (make 'home-page-w :readers readers)))

    (make-html-page-artifact html-path (home-page-builder title) root)))
