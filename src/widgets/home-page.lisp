(in-package #:in.bitspook.vidhi)

(defwidget home-page-w (readers)
    (tagged-lass
     (base-lass)
     `((.container :max-width (var --width-md)
                   :margin 0 auto
                   :padding 0 (var --size-4))
       (.page-title :text-align center
                    :font-size (var --scale-6)
                    :margin (var --scale-1) 0)

       (.section :margin (var --scale-1) 0)
       (.section-title
        :margin (var --scale-2) 0

        (.title :font-size (var --scale-4)
                :text-align left
                :margin 0)

        (.subtext
         :margin 0
         :font-size (var --scale-00)
         :color (var --color-grey-400)))))

  (:article.container
   (:h1.page-title "Vidhi")

   (:article.section
    (:header.section-title
     (:h2.title "News")
     (:p.subtext "from " (:a :href "https://www.nachrichtenleicht.de/" "Nachrichtenleicht")))
    (:section.readers
     (dolist (reader readers)
       (render 'reader-card-w :reader reader))))))
