(defpackage #:in.bitspook.vidhi
  (:use #:cl #:serapeum/bundle)
  (:import-from #:in.bitspook.cl-ownpress
   :defwidget :tagged-lass :lass-of :dom-of :render :*self*
   :artifact-content :artifact-location :artifact-deps :css-file-artifact :add-dep
   :html-page-artifact :make-html-page-artifact :all-deps :link :embed-artifact-as :*base-url*
   :font-artifact :make-font-artifact :font-face
   :publish-static :publish-artifact :file-already-exists :skip-existing)
  (:import-from #:in.bitspook.cl-ownpress/provider :provide-all)
  (:import-from #:spinneret :with-html)
  (:import-from #:in.bitspook.vidhi/nlp
   :nlp-words :nlp-lemma-freq :word-alpha-p :word-lemma :word-text)
  (:import-from #:parenscript :ps)
  (:local-nicknames (:yason :yason)))

(in-package #:in.bitspook.vidhi)

(defparameter *fonts-dir*
  (asdf:system-relative-pathname "in.bitspook.vidhi" "src/fonts/"))
