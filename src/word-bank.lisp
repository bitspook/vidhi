(in-package #:in.bitspook.vidhi)

(defclass bank-word ()
  ((text :initarg :text :accessor bank-word-text)
   (type :initarg :type :accessor bank-word-type)
   (translations :initarg :translations :accessor bank-word-translations)
   (frequency :initarg :frequency :accessor bank-word-frequency))
  (:documentation "A BANK-WORD is a word from WORD-BANK. Word-bank is collection of known words which can be used for
translation. Word-bank can also be called a (albeit limited) knowledge-base or dictionary."))

(defmethod print-object ((bw bank-word) out)
  (print-unreadable-object (bw out :type t)
    (format out "~a (~{~a~^, ~})" (bank-word-text bw) (bank-word-translations bw))))

(defun load-word-bank (filepath)
  "Load word bank from a json file at FILEPATH."
  (let ((raw-words (yason:parse (str:from-file filepath))))
    (mapcar
     (lambda (wtable)
       (make 'bank-word
             :text (@ wtable "text")
             :type (@ wtable "type")
             :translations (@ wtable "translations")
             :frequency (@ wtable "frequency")))
     raw-words)))
