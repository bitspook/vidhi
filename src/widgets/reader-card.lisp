(in-package #:in.bitspook.vidhi)

(defwidget reader-card-w (reader)
    (tagged-lass
     `((.reader-card
        :border 1px solid (var --color-grey-100)
        :margin (var --scale-1) 0
        :overflow hidden
        :padding 0
        :border-radius (var --size-1)
        :box-shadow 0 0 (var --size-1) 0 (var --color-grey-200)

        (.featured-img
         :width 100% :height 140px
         :background-size cover
         :background-repeat no-repeat
         :background-color (var --color-grey-200))

        (.title
         :margin 0
         :padding (var --scale-1)
         :font-size (var --scale-1)
         :font-weight (var --weight-regular)))))
  (:section.reader-card
   (with-slots (article) reader
     (with-accessors ((featured-img nacht-article-featured-image)) article
       (:a
        :href (embed-artifact-as reader 'link)
        (:div.featured-img :style (format nil "background-image: url(~a)" (car featured-img)))
        (:p.title
         (nacht-article-title article)))))))
