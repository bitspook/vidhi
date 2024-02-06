(uiop:define-package #:in.bitspook.vidhi
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
  (:import-from #:spinneret :with-html))

(in-package #:in.bitspook.vidhi)
