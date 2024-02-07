(uiop:define-package #:in.bitspook.vidhi/nlp
  (:use #:cl #:serapeum/bundle)
  (:import-from #:py4cl :import-module :python-exec :python-call))

(in-package #:in.bitspook.vidhi/nlp)
(python-exec "import vidhi")

(defclass word ()
  ((text
    :initarg :text
    :accessor word-text)
   (lemma
    :initarg :lemma
    :accessor word-lemma)
   (pos
    :initarg :pos
    :accessor word-pos)
   (tag
    :initarg :tag
    :accessor word-tag)
   (dep
    :initarg :dep
    :accessor word-dep)
   (alpha-p
    :initarg :alpha-p
    :accessor word-alpha-p)))

(defmethod print-object ((w word) out)
  (print-unreadable-object (w out :type t)
    (format out "~s" (word-text w))))

(export-always 'nlp-words)
(defun nlp-words (text)
  "Break TEXT into a list of `word's."
  (let ((words (py4cl:python-call "vidhi.words" text)))
    (map
     'list
     (op (make 'word
               :text (@ _1 "text")
               :lemma (@ _1 "lemma")
               :pos (@ _1 "pos")
               :tag (@ _1 "tag")
               :dep (@ _1 "dep")
               :alpha-p (@ _1 "alpha-p")))
     words)))
