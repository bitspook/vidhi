(in-package #:in.bitspook.vidhi)

(defwidget word-learner-w (title word-freq word-bank)
    (tagged-lass
     `((.used-words
        :display flex
        :flex-wrap wrap)

       (.used-word-btn
        :border 2px solid (var --color-grey-200)
        :width fit-content
        :display flex
        :align-items baseline
        :border-radius (var --size-4)
        :background-color (var --color-grey-100)
        :padding (var --size-2) (var --scale-2)
        :margin (var --size-2)
        :text-align center
        :cursor pointer

        (.word :font-size (var --scale-4)
               :font-weight (var --weight-bold)
               :margin-right (var --size-2))

        (.subtext :font-size (var --size-3)
                  :color (var --color-grey-400)))

       ((:and .used-word-btn :hover) :background (var --color-grey-200))
       ((:and .used-word-btn :active) :background (var --color-grey-300))

       (.labeled-quote
        :margin (var --scale-2) 0

        (label :font-size (var --size-3)
               :padding-left (var --size-3)
               :margin-left (var --size-2))
        (blockquote
         :font-size (var --scale-2)
         :margin-top 0
         :padding 0 (var --size-3)))

       (.icon-close
        :display block
        :position absolute
        :top 0 :right 0
        :width (var --scale-2)
        :height (var --scale-2)
        :background-repeat no-repeat
        :background-size contain
        :cursor pointer
        :background-image (url "/icons/close.svg")
        :margin (var --scale-2))


       (.full-page-modal
        :position fixed
        :top 50% :left 50%
        :box-shadow 0 0 (var --scale-4) (var --scale-4) (var --color-grey-600)
        :transform "translate(-50%, -50%)"
        :height (calc (- 100% (var --scale-4)))
        :width (calc (- 100% (var --scale-4)))
        :border-radius (var --scale-00)
        :display flex  :display none
        :z-index 99
        :flex-direction column
        :overflow hidden
        :background (var --color-grey-100)
        :padding (var --scale-2) (var --scale-4)

        (header
         :margin (var --scale-2) 0
         :text-align center

         (.title :font-size (var --scale-6)
                 :line-height 0.8
                 :margin 0 :margin-bottom (var --size-2)))

        (.subtext :font-size (var --size-4)
                  :color (var --color-grey-400))

        (footer :margin (var --scale-4) 0 (var --scale-2) 0
                ((:and .subtext :last-child) :margin-left (var --size-2))))))

  (:article.content
   (:header.title
    (:h1 title))

   (:main
    (:script
     (:raw
      (ps
        (defun show-word-modal (el)
          (let* ((w-text (ps:chain el dataset lemma))
                 (modal (ps:chain document (query-selector (+ ".full-page-modal[data-lemma=\"" w-text "\"]")))))
            (setf (ps:chain modal style display) "flex")))

        (defun close-modal (el)
          (setf (ps:chain el style display) "none")))))

    (:section.used-words
     (loop :for (w-text freq . nlp-words) :in word-freq
           :for bank-words := (@ word-bank w-text)
           :do (when bank-words
                 (:div.used-word-btn
                  :onclick (:raw (ps (show-word-modal this)))
                  :data-lemma w-text
                  (:div.word w-text)
                  (:div.subtext ("x~a" freq)))

                 (:article.full-page-modal
                  :onclick "closeModal(this)"
                  :data-lemma w-text

                  (:header
                   (:h2.title w-text)
                   (:span.subtext ("used ~a times" freq))
                   (:span.icon-close))

                  (:section.translations
                   (dolist (bw bank-words)
                     (:div.labeled-quote
                      (:label (bank-word-type bw))
                      (dolist (trans (bank-word-translations bw))
                        (:blockquote trans)))))

                  (:footer
                   (:span.subtext "used as")
                   (:span ("~{~a~^, ~}" (mapcar #'word-text nlp-words)))
                   (:span.subtext "in the article.")))))))))
