(defpackage #:in.bitspook.vidhi
  (:use #:cl #:serapeum/bundle)
  (:import-from #:in.bitspook.cl-ownpress/publisher
   :publish :render
   :html-publisher
            :asset-publisher
   :defwidget :tagged-lass :lass-of :dom-of)
  (:import-from #:in.bitspook.cl-ownpress/provider
   :provide-all)
  (:import-from #:in.bitspook.website
   :denote-provider)
  (:import-from #:spinneret :with-html)
  (:import-from #:in.bitspook.vidhi/nlp
   :nlp-words :nlp-lemma-freq :word-alpha-p :word-lemma :word-text)
  (:import-from #:parenscript :ps)
  (:local-nicknames (:yason :yason)))

(in-package #:in.bitspook.vidhi)
