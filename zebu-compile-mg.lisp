; -*- mode:     Lisp -*- --------------------------------------------------- ;
; File:         zebu-compile-mg.lisp
; Description:  Compile and load the metagrammar during load process
; Author:       Rudi Schlatte
; Created:      2000-03-26
; Time-stamp: <00/03/26 15:14:11 rschlatt>
; Language:     CL
; Package:      ZEBU
; Status:       Experimental (Do Not Distribute) 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; This is only needed for mk:defsystem (or until I figure out
; how to compile arbitrary file types with custom compilers
; in defsystem, which is all that happens here)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package #:ZEBU)

(eval-when (:compile-toplevel)
  (ignore-errors
    (delete-file (merge-pathnames "zebu-mg.tab" *compile-file-truename*))
    (delete-file (merge-pathnames "zmg-dom.lisp" *compile-file-truename*)))
  (zebu-compile-file
   (merge-pathnames "zebu-mg.zb" *compile-file-truename*)))


(eval-when (:load-toplevel)
  (zebu-load-file
   (merge-pathnames "zebu-mg.tab" *load-truename*)))
