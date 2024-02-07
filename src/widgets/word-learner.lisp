(in-package #:in.bitspook.vidhi)

(defwidget word-learner-w (title)
    (tagged-lass
     base-lass
     `((.content :margin (var --scale-6) 0
                 :color (var --color-grey-600)
                 :font-size (var --scale-1)
                 :line-height (var --line-md))
       (.title :margin (var --scale-2) 0)))

  (:article.content
   (:header.title
    (:h1 title))

   (:main)))
