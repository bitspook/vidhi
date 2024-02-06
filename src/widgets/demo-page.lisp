(in-package #:in.bitspook.vidhi)

(defwidget demo-page-w ()
    (tagged-lass
     base-lass
     `((.container :max-width (var --width-xl))

       (.exercise-player :padding (var --scale-4))))

  (:div.container
   (:div.exercise-player
    (render 'simple-exercise-w))))
