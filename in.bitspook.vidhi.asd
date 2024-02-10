(defsystem "in.bitspook.vidhi"
  :author "Charanjit Singh"
  :license "AGPL-3.0-only"
  :depends-on (:serapeum
               :dexador
               :clss :plump
               :py4cl
               :in.bitspook.cl-ownpress
               :in.bitspook.website)
  :components ((:module "src"
                :components
                ((:module "nlp"
                  :components ((:file "package")))

                 (:file "package")

                 (:file "nachrichtenleicht")

                 (:module "lass"
                  :components ((:file "modern-normalize")
                               (:file "pollen")
                               (:file "global-lass")))

                 (:module "widgets"
                  :components ((:file "simple-exercise")
                               (:file "demo-page")
                               (:file "reader-page")
                               (:file "word-learner")
                               (:file "article")))

                 (:module "publisher"
                  :components ((:file "page")
                               (:file "assisted-reader"))))))
  :description "Help me methodically learn German.")
