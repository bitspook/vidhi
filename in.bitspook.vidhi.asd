(defsystem "in.bitspook.vidhi"
  :author "Charanjit Singh"
  :license "AGPL-3.0-only"
  :depends-on (:serapeum
               :dexador :yason
               :plump :clss
               :py4cl
               :parenscript
               :in.bitspook.cl-ownpress)
  :components ((:module "src"
                :components
                ((:module "nlp"
                  :components ((:file "package")))

                 (:file "package")
                 (:file "word-bank")

                 (:file "nachrichtenleicht")

                 (:module "lass"
                  :components ((:file "modern-normalize")
                               (:file "pollen")
                               (:file "global-lass")))

                 (:module "widgets"
                  :components ((:file "simple-exercise")
                               (:file "reader-card")
                               (:file "word-learner")
                               (:file "article")
                               (:file "reader-page")
                               (:file "home-page")))

                 (:module "artifacts"
                  :components ((:file "assisted-reader")
                               (:file "home-page"))))))
  :description "Help me methodically learn German.")
