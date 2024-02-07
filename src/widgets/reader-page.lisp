(in-package #:in.bitspook.vidhi)

(defwidget reader-page-w (content-w active-nav-index nav-links)
    (tagged-lass
     base-lass
     `((.container :max-width (var --width-md)
                   :margin 0 auto
                   :padding 0 (var --size-4))

       (.menu (ul :list-style-type none
                  :margin (var --scale-4) 0
                  :padding 0
                  :border 1px solid (var --color-grey-200)
                  :width fit-content
                  :display flex
                  :border-radius (var --size-1)
                  :overflow hidden)

              (li :padding (var --size-1) (var --scale-1)
                  :border-right 1px solid (var --color-grey-200)
                  :background-color (var --color-grey-100)
                  (a :color (var --color-grey-600)
                     :text-decoration none))

              (.active
               :background-color (var --color-grey-200)

               (a :font-weight (var --weight-bold))))))

  (:div.container
   (:nav.menu
    (:ul
     (loop :for index := (1+ (or index -1))
           :for link :in nav-links
           :do (:li :class (when (eq index active-nav-index) "active")
                    (:a :href (second link) (first link) )))))

   (render content-w)))
