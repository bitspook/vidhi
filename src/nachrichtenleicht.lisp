(in-package #:in.bitspook.vidhi)

(defclass nachtrichtenleicht-article ()
  ((title
    :initarg :title
    :accessor nacht-article-title)
   (description
    :initarg :description
    :accessor nacht-article-description)
   (published-on
    :initarg :published-on
    :accessor nacht-article-publishedicle-on)
   (featured-image
    :initarg :featured-image
    :accessor nacht-article-featured-image)
   (audio
    :initarg :audio
    :accessor nacht-article-audio)
   (content
    :initarg :content
    :accessor nacht-article-content)
   (new-words
    :initarg :new-words
    :accessor nacht-article-new-words)))


(defun extract-new-words (article)
  (sequence:map
   nil
   (op (let* ((word (plump:text (aref  (clss:select "h3" _1) 0)))
              (definition (plump:text (aref (clss:select "p" _1) 0))))
         (list word definition)))
   (clss:select ".b-teaser-word" article)))

(defun extract-content (article)
  (remove-if
   #'str:emptyp
   (sequence:map
    nil
    (op (str:trim (plump:text _)))
    (clss:select ".b-article-details div" article))))

(defun extract-audio (header)
  (plump:attribute
   (aref (clss:select "a.download-url-tracking" header) 0)
   "href"))

(defun extract-description (header)
  (plump:text (aref (clss:select "p.article-header-description" header) 0)))

(defun extract-publish-date (header)
  (let* ((date-strs (str:split "." (plump:text (aref (clss:select "p.article-header-author" header) 0)))))
    (local-time:parse-timestring (format nil "~a-~a-~a" (third date-strs) (second date-strs) (first date-strs)))))

(defun extract-featured-image (article)
  (let* ((figure (clss:select "figure.b-image-figure" article))
         (img (plump:attribute (aref (clss:select "img" figure) 0) "src"))
         (caption (plump:text (aref (clss:select "figcaption" figure) 0))))
    (list img caption)))

(defun fetch-nacht-article (url)
  (let* ((resp (dex:get url))
         (page (plump:parse resp))
         (article (aref (clss:select "main article" page) 0))
         (header (aref (clss:select "header" article) 0)))
    (make 'nachtrichtenleicht-article
          :title (plump:text (aref (clss:select "title" page) 0))
          :description (extract-description header)
          :published-on (extract-publish-date header)
          :audio (extract-audio header)
          :featured-image (extract-featured-image article)
          :content (extract-content article)
          :new-words (extract-new-words article))))
