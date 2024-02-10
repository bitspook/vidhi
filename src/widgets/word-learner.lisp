(in-package #:in.bitspook.vidhi)

(defwidget word-learner-w (title word-freq)
    (tagged-lass
     base-lass
     `((.content :margin (var --scale-6) 0
                 :color (var --color-grey-600)
                 :font-size (var --scale-1)
                 :line-height (var --line-md))
       (.title :margin (var --scale-2) 0)

       (.used-word-btn :border 2px solid (var --color-grey-200)
                       :display flex
                       :flex-direction column
                       :border-radius (var --size-4)
                       :background-color (var --color-grey-100)
                       :padding (var --size-2) (var --scale-2)
                       :margin (var --size-2) 0
                       :text-align center

                       (.word :font-size (var --scale-4)
                              :font-weight (var --weight-bold))

                       (.subtext :font-size (var --size-3)
                                 :color (var --color-grey-500)))))

  (:article.content
   (:header.title
    (:h1 title))

   (:main
    (loop :for (word freq) :in word-freq
          :do (:div.used-word-btn :data-btn word
               (:div.word word)
               (:div.subtext "used" freq "times."))))))
