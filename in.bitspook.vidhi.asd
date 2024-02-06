(defsystem "in.bitspook.vidhi"
  :author "Charanjit Singh"
  :license "AGPL-3.0-only"
  :depends-on (:serapeum
               :dexador
               :clss :plump
               :in.bitspook.cl-ownpress
               :in.bitspook.website)
  :components ((:module "src"
                :components ((:file "package")
                             (:file "nachrichtenleicht")

                             (:module "lass"
                              :components ((:file "modern-normalize")
                                           (:file "pollen")
                                           (:file "global-lass")))

                             (:module "widgets"
                              :components ((:file "simple-exercise")
                                           (:file "demo-page")
                                           (:file "reader-page")))

                             (:module "publisher"
                              :components ((:file "page"))))))
  :description "Help me methodically learn German.")
