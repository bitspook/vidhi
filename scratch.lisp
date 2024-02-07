(ql:quickload '(:in.bitspook.vidhi))

(in-package #:in.bitspook.vidhi)

(defparameter *deutsch-notes*
  (let ((notes-provider (make 'denote-provider)))
    (provide-all notes-provider "german")))

(defparameter *base-dir* (asdf:system-relative-pathname :in.bitspook.vidhi ""))

(defparameter *article* (fetch-nacht-article "https://www.nachrichtenleicht.de/streiks-in-deutschland-106.html"))

(defun build ()
  (let* ((www (path-join *base-dir* "docs/"))
         (static (path-join *base-dir* "src/static/"))
         (*print-pretty* t)
         (asset-pub (make 'asset-publisher :dest www)))

    (uiop:delete-directory-tree www :validate t :if-does-not-exist :ignore)

    (publish asset-pub :content static)

    (let* ((assisted-reader-pub
             (make 'assisted-reader-publisher
                   :dest www
                   :asset-pub asset-pub)))
      (publish assisted-reader-pub :article *article*))
    t))

(build)

;; setup py4cl to work with poetry env
(setf py4cl:*python-command* "/Users/charanjit.singh/Library/Caches/pypoetry/virtualenvs/vidhi-91ierX8q-py3.11/bin/python")

(py4cl:import-module "spacy" :as "sp")

(py4cl:import-module "vidhi" :as "vidhipy")

(defparameter *nlp* (sp:load "de_dep_news_trf"))

(py4cl:python-exec "vidhipy.nlp(\"Hallo Meine liebe\")")

;; quick hack to auto-build
;; elisp
;; (defun build-website (successp notes buffer loadp)
;;   (sly-eval '(in.bitspook.vidhi::build)))
;; (add-hook 'sly-compilation-finished-hook #'build-website)
