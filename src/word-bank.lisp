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
  "Load word bank from a json file at FILEPATH.
A word-bank is a hashtable of shape (text . (BANK_WORD)). Each entry in word-bank represent a single
word. One word can have multiple translations (represented by BANK-WORD), depending on (BANK-WORD-TYPE)."
  (let ((raw-bank (yason:parse (str:from-file filepath)))
        (bank (dict)))
    (do-hash-table (key val raw-bank bank)
      (setf (@ bank key)
            (maphash-return
             (lambda (type val2)
               (make 'bank-word
                     :text key
                     :type type
                     :translations (@ val2 "translations")
                     :frequency (@ val2 "frequency")))
             val)))))
