(in-package #:in.bitspook.vidhi)

(defwidget nlp-sentence-w (sentence)
    (tagged-lass
     `((.text-word :display inline-block :margin-left 5px)
       ))

    (dolist (word sentence)
      (if (equal "--" (word-lemma word))
          (:span (word-text word))
          (:span.text-word :data-lemma (word-lemma word) (word-text word)))))

(defwidget article-w (title description content featured-image)
    (tagged-lass
     base-lass
     `((.content :margin (var --scale-6) 0
                 :color (var --color-grey-600)
                 :font-size (var --scale-1)
                 :line-height (var --line-md))

       (.title :margin (var --scale-2) 0)

       (.description :font-size (var --scale-2)
                     :margin (var --scale-2) 0
                     :color (var --color-grey-800)
                     :font-weight (var --weight-light)
                     :line-height (var --line-md))))

  (:article.content
   (:header.title
    (:h1 (render 'nlp-sentence-w :sentence title)))

   (:main
    (:p.description (render 'nlp-sentence-w :sentence description))

    (when featured-image
      (:figure (:img :src (first featured-image))
               (:figcaption (render 'nlp-sentence-w :sentence (second featured-image)))))

    (dolist (para content)
      (:p (render 'nlp-sentence-w :sentence para))))))
