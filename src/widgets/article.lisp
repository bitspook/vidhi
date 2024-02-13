(in-package #:in.bitspook.vidhi)

(defwidget nlp-sentence-w (sentence word-bank)
    (tagged-lass
     `((.text-word
        :display inline-block
        :margin-left 5px
        :margin-bottom (var --size-1)
        :border-bottom 1px dotted transparent
        :cursor not-allowed)

       ((:and .text-word .has-meaning)
        :cursor pointer
        :border-bottom-color (var --color-grey-400))))

    (dolist (word sentence)
      (let ((bw (@ word-bank (word-lemma word))))
        (if (equal "--" (word-lemma word))
            (:span (word-text word))
            (:span.text-word
             :title (unless bw "No translations 😭")
             :class (when bw "has-meaning")
             :onclick (if bw "showWordModal(this)")
             :data-lemma (word-lemma word)
             (word-text word))))))

(defwidget article-w (title description content featured-image audio word-bank)
    (tagged-lass
     base-lass
     `((.content :margin (var --scale-6) 0
                 :color (var --color-grey-600)
                 :font-size (var --scale-1)
                 :line-height (var --line-md)
                 :padding-bottom (var --scale-10))

       (.title :margin (var --scale-2) 0)

       (.description :font-size (var --scale-2)
                     :margin (var --scale-2) 0
                     :color (var --color-grey-800)
                     :font-weight (var --weight-light)
                     :line-height (var --line-md))

       (.audio-player
        :position fixed
        :background-color (var --color-grey-100)
        :bottom 0 :left 0 :right 0
        :width 100%
        :height (var --scale-9)

        (figure :margin 0
                :height 100%)

        (figcaption :padding (var --size-2))

        (audio :width 100%))))

  (:article.content
   (:header.title
    (:h1 (render 'nlp-sentence-w :sentence title :word-bank word-bank)))

   (:main
    (:p.description (render 'nlp-sentence-w :sentence description :word-bank word-bank))

    (when featured-image
      (:figure (:img :src (first featured-image))
               (:figcaption (render 'nlp-sentence-w :sentence (second featured-image) :word-bank word-bank))))

    (dolist (para content)
      (:p (render 'nlp-sentence-w :sentence para :word-bank word-bank))))

   (:footer
    (when audio
      (:section.audio-player
       (:figure
        (:figcaption "Listen to the article")
        (:audio :controls t :preload "auto" :src audio)))))))
