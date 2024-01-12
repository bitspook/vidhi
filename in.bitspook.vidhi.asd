(defsystem "in.bitspook.vidhi"
  :author "Charanjit Singh"
  :license "AGPL-3.0-only"
  :depends-on (:in.bitspook.cl-ownpress
               :local-time
               :feeder :plump :quri)
  :components ((:module "src"
                :components ((:file "package")
                             (:module "lass"
                              :components ((:file "modern-normalize")
                                           (:file "pollen")
                                           (:file "global-lass"))))))
  :description "Help me methodically learn German.")
