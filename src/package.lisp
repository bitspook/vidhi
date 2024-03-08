(defpackage #:in.bitspook.vidhi
  (:use #:cl #:serapeum/bundle)
  (:import-from #:in.bitspook.cl-ownpress
   :defwidget :tagged-lass :lass-of :dom-of :render

   :artifact-content :artifact-location :artifact-deps :css-file-artifact
   :html-page-artifact :publish-static :publish-artifact :all-deps)
  (:import-from #:in.bitspook.cl-ownpress/provider :provide-all)
  (:import-from #:spinneret :with-html)
  (:import-from #:in.bitspook.vidhi/nlp
   :nlp-words :nlp-lemma-freq :word-alpha-p :word-lemma :word-text)
  (:import-from #:parenscript :ps)
  (:local-nicknames (:yason :yason)))

(in-package #:in.bitspook.vidhi)
