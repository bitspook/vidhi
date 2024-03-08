(in-package #:in.bitspook.vidhi)

(defun home-page-builder (title &key)
  (lambda (&key css body-html)
    (declare (css-file-artifact css))
    (spinneret:with-html
      (:html
       (:head (:title title)
              (:meta :name "viewport" :content "width=device-width, initial-scale=1")
              (when css (:link :rel "stylesheet" :href (artifact-location css))))
       (:body (:raw body-html))))))

(defun make-home-page (&key word-bank articles (title ""))
  (let* ((title (if (str:emptyp title) "Vidhi" title))
         (slug "/")
         (html-path (base-path-join slug "/index.html")))

    (let* ((readers (mapcar
                     (op (make-assisted-reader
                          :word-bank word-bank
                          :article _))
                     articles))

           (root (make 'home-page-w :readers readers)))
      (make 'html-page-artifact
            :deps (append1
                   readers
                   (make 'css-file-artifact
                         :location "/css/styles.css"
                         :root-widget root))
            :builder (home-page-builder title)
            :root-widget root
            :location html-path))))
