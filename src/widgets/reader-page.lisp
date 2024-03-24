(in-package #:in.bitspook.vidhi)

(defwidget reader-page-w (article-w word-learner-w)
    (tagged-lass
     (base-lass)
     `((.container :max-width (var --width-md)
                   :margin 0 auto
                   :padding 0 (var --size-4))

       (.menu (ul :list-style-type none
                  :margin (var --scale-4) auto
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

               (a :font-weight (var --weight-bold))))
       (.word-learner :height 0 :overflow hidden)))

  (:div.container
   (:script
    (:raw
     (ps
       (defparameter *sections* '("article" "word-learner"))

       (defun show-section (el)
         (ps:chain (ps:chain document (query-selector "li.active"))
                   class-list (remove "active"))
         (ps:chain el class-list (add "active"))

         (labels ((section-el (sec) (ps:chain document (query-selector (+ "." sec)))))
           (let ((section (ps:chain el dataset section)))
             (setf (ps:chain (section-el section) style height) "auto")

             (loop :for sec :in *sections*
                   :unless (= sec section)
                     :do (setf (ps:chain (section-el sec) style height) 0)
                         (setf (ps:chain (section-el sec) style overflow) "hidden"))))))))

   (:nav.menu
    (:ul
     (:li.active
      :data-section "article"
      :onclick "showSection(this)"
      "Read")
     (:li :data-section "word-learner"
          :onclick "showSection(this)"
          "Prepare")))

   (:section.article (render article-w))
   (:section.word-learner (render word-learner-w))))
