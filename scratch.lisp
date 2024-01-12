(ql:quickload '(:in.bitspook.vidhi))

(in-package #:in.bitspook.vidhi)

(defparameter *base-url* "http://localhost:8080")

(defparameter *base-dir* (asdf:system-relative-pathname :in.bitspook.vidhi ""))
