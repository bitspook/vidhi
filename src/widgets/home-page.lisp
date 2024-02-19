(in-package #:in.bitspook.vidhi)

(defwidget home-page-w (article-w word-learner-w)
    (tagged-lass
     base-lass
     `((.container :max-width (var --width-md)
                   :margin 0 auto
                   :padding 0 (var --size-4))))

  (:div.container
   (:h1 "Home")))
