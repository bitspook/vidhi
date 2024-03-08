(in-package #:in.bitspook.vidhi)

(defclass nachtrichtenleicht-article ()
  ((title
    :initarg :title
    :accessor nacht-article-title)
   (origin
    :initarg :origin
    :accessor nacht-article-origin)
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

(defparameter *nach-base-url* "https://www.nachrichtenleicht.de")

(defun fetch-nacht-article (url)
  (let* ((resp (dex:get url))
         (page (plump:parse resp))
         (article (aref (clss:select "main article" page) 0))
         (header (aref (clss:select "header" article) 0)))
    (make 'nachtrichtenleicht-article
          :title (plump:text (aref (clss:select "title" page) 0))
          :origin url
          :description (extract-description header)
          :published-on (extract-publish-date header)
          :audio (extract-audio header)
          :featured-image (extract-featured-image article)
          :content (extract-content article)
          :new-words (extract-new-words article))))

(defun fetch-latest-nacht-articles (count)
  "Fetch latest COUNT articles from nachtrichtenleicht.
We pull `COUNT/n' latest articles for each of `n' article types. This strategy means it is possible
that all COUNT articles aren't latest. But that is not a problem because nachrichtenleicht.de
publish new articles weekly, and not in large amount."
  (declare (integer count))
  (labels ((article-listing-api-url (article-type &key (count 10) (offset 0))
             ;; API with pagination support which return listing with articles of a given type
             (format nil "https://www.nachrichtenleicht.de/api/partials/PaginatedArticles_NL?drsearch%3AcurrentItems=~d&drsearch%3AitemsPerLoad=~d&drsearch%3ApartialProps={\"sophoraId\"%3A~s}&drsearch%3A_ajax=1"
                     offset count article-type))
           (listing-links (listing-url)
             (let* ((page (plump:parse (dex:get listing-url)))
                    (article-a-nodes (clss:select "article.b-teaser-wide > a" page)))
               (map 'list (op (plump:get-attribute _ "href")) article-a-nodes))))
    (let* ((base-url *nach-base-url*)
           (home-page (plump:parse (dex:get base-url)))
           ;; article types are obtained from links to 'article type page'
           (article-types (map 'list
                               (op (nsubseq
                                    (str:replace-first
                                     ".html" ""
                                     (nth-value 4 (quri:parse-uri (plump:get-attribute _ "href"))))
                                    1))
                               (clss:select ".navigation-menu-link" home-page)))
           (count-per-type (ceiling (/ count (length article-types))))
           (article-listing-urls
             (mapcar
              (op (article-listing-api-url _ :count count-per-type))
              article-types))
           (article-urls (apply #'concatenate 'list (mapcar #'listing-links article-listing-urls))))
      (mapcar #'fetch-nacht-article article-urls))))

(defun nach-article-word-freq (article)
  "Get word-frequency for all words from ARTICLE.
Returns (lemma . frequency . (WORD))
lemma is a string, frequency is number."
  (declare (nachtrichtenleicht-article article))

  (with-slots (title description featured-image content new-words) article
    (let* ((all-text (str:join
                      #\NewLine
                      (list
                       title
                       description
                       (second featured-image)
                       (str:join #\NewLine content)
                       (str:join #\NewLine (mapcar #'second new-words))))))
      (sort
       (remove-if-not
        (op (some #'word-alpha-p (cddr _)))
        (hash-table-alist (nlp-lemma-freq all-text)))
       (op (> (second _) (second _)))))))


