(in-package #:in.bitspook.vidhi)

(defwidget reader-page-w (title description content featured-image)
    (tagged-lass
     base-lass
     `((.container :max-width (var --width-md)
                   :margin 0 auto
                   :padding 0 (var --size-4))
       (.content :margin (var --scale-6) 0
                 :color (var --color-grey-600)
                 :font-size (var --scale-1)
                 :line-height (var --line-md))
       (.title :margin (var --scale-2) 0)
       (.description :font-size (var --scale-2)
                     :margin (var --scale-2) 0
                     :color (var --color-grey-800)
                     :font-weight (var --weight-light)
                     :line-height (var --line-md))
       (main :text-align justify)))

  (:div.container
   (:article.content
    (:header.title
     (:h1 title))

    (:main
     (:p.description description)

     (when featured-image
       (:figure (:img :src (first featured-image))
                (:figcaption (second featured-image))))

     (dolist (para content)
       (:p para))))))
