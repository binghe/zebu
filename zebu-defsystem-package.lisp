; -*- mode:     Lisp -*- --------------------------------------------------- ;
; File:         zebu-defsystem-package.lisp
; Description:  package definition (mk:defsystem version)
; Author:       Rudi Schlatte, based on zebu-package.lisp by J.Laubsch
; Language:     CL
; Package:      CL-USER
; Status:       Experimental (Do Not Distribute) 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Package and parameter definitions for use with mk:defsystem.
; Eliminates dependence on some symbols (*ZEBU-directory* et al.)
; being present in CL-USER.
;
; This file REPLACES zebu-package.lisp when using mk:defsystem for the
; load process.  Rationale: zebu-package.lisp expects some symbols and
; packages to be present, and setting everything up including creating
; a fake package PSGRAPH was not something very clean to do.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package "CL-USER")
(provide "zebu-package")

#+LUCID					; while not up tp CLtL2
(eval-when (compile load eval)
  (defmacro LCL::DECLAIM (decl-spec) `(proclaim ',decl-spec)))

;;; 2000-03-25 by rschlatte@ist.tu-graz.ac.at:
;;;   This package is not used anywhere
;;#+LUCID
;;(defpackage "PSGRAPH"
;;    (:use "LUCID-COMMON-LISP"))
;;
;;#-LUCID
;;(defpackage "PSGRAPH"
;;    (:use "COMMON-LISP"))


(defpackage "ZEBU"
    (:nicknames "ZB")
    #+LUCID (:use "LISP" "LUCID-COMMON-LISP")
    #+LUCID (:import-from "SYSTEM" "*KEYWORD-PACKAGE*")
;;; 2000-03-25 by rschlatte@ist.tu-graz.ac.at:
;;;   Gives an error when loading compiled files
;;    #+LUCID (:import-from "LCL" "DECLAIM")
;;    (:import-from "PSGRAPH" PSGRAPH::PSGRAPH)
    #+MCL   (:use "COMMON-LISP" "CCL")
    #+KCL   (:use "LISP")
    #+ALLEGRO (:use "COMMON-LISP" "EXCL")
    
;;; 2000-03-25 by rschlatte@ist.tu-graz.ac.at:
;;;   Defined in this file / package instead, see below
;;    (:import-from "CL-USER" CL-USER::*ZEBU-DIRECTORY*
;;                  CL-USER::*ZEBU-binary-directory*)
    (:export "*COMMENT-BRACKETS*" "*COMMENT-START*" "*PRESERVE-CASE*"
	     "*CASE-SENSITIVE*"
	     "*DISALLOW-PACKAGES*" "*STRING-DELIMITER*"
	     "*SYMBOL-DELIMITER*"
	     "*IDENTIFIER-START-CHARS*" "*IDENTIFIER-CONTINUE-CHARS*"
	     "*ALLOW-CONFLICTS*" "*WARN-CONFLICTS*" 
	     "*CURRENT-GRAMMAR*" "*GENERATE-DOMAIN*"
	     "*ZEBU-VERSION*"
	     "CATEGORIZE" "END-OF-TOKENS-CATEGORY"
	     "COMPILE-LALR1-GRAMMAR" "COMPILE-SLR-GRAMMAR"
	     "DEBUG-PARSER"
	     "DEFRULE" "FILE-PARSER" "FIND-GRAMMAR" "IDENTITY*"
	     "IDENTIFIERP"
	     "KB-DOMAIN" "KB-DOMAIN-P" "KB-TYPE-NAME-P"
	     "KB-SEQUENCE" "KB-SEQUENCE-P" "*KB-SEQUENCE-SEPARATOR*"
	     "MAKE-KB-SEQUENCE" "KB-SEQUENCE-FIRST" "KB-SEQUENCE-REST"
	     "KB-DEF-SLOT-TYPE" "KB-SET-VALUED-SLOT-P"
	     "KB-SLOT-TYPE" "KB-SLOTS" "KB-SUPERTYPE" "KB-SUBTYPES"
	     "KB-LEGAL-SLOT-P"
             "KB-TREE-ATTRIBUTES" "DEFINE-TREE-ATTRIBUTES" "DEF-TREE-ATTRIBUTES"
	     "PREORDER-TRANSFORM" "POSTORDER-TRANSFORM"
	     "KIDS" "FOR-EACH-KID" "FOR-EACH-KID!"
	     "FOR-EACH-DESCENDANT" 
	     "KB-COPY" "KB-EQUAL" "KB-COMPARE"
	     "LIST-PARSER" "LR-PARSE" "PRINT-ACTIONS" "READ-PARSER"
	     "COMPILE-FROM-COMMAND-LINE"
	     "EMPTY-SEQ" "SEQ-CONS" "EMPTY-SET" "SET-CONS"
	     "K-4-3" "K-2-1" "K-2-2" "K-3-2" "CONS-1-3" "CONS-2-3"
	     "NUMBER" "STRING" "IDENTIFIER"
	     "SHOW-KB-HIERARCHY"
	     "ZEBU" "ZEBU-COMPILER" "ZEBU-COMPILE-FILE" "ZEBU-LOAD-FILE"
	     "ZEBU-RR" "ZEBU-TOP"
	     )
;;; 2000-03-25 by rschlatte@ist.tu-graz.ac.at:
;;;   Defined in this file / package instead, see below
;;    #-LUCID
;;    (:import-from "CL-USER"
;;                  CL-USER::*LOAD-SOURCE-PATHNAME-TYPES*
;;                  CL-USER::*LOAD-BINARY-PATHNAME-TYPES*))
    )

(in-package "ZB")

;;; 2000-03-25 by rschlatte@ist.tu-graz.ac.at:
;;;   Moved definitions of *ZEBU-direcotory*, *ZEBU-binary-directory*
;;;   over from ZEBU-init.lisp, got rid of importing symbols from
;;;   CL-USER in (defpackage "ZEBU")

; edit the following form for your Lisp, and the directory where you keep Zebu
(defparameter *ZEBU-directory*
  (make-pathname 
   :directory  ;; Might be loading zebu-package-fasl from the binary directory
   (remove #+64bit "binary-64bit" #-64bit "binary"
	   (pathname-directory *load-truename*)
           :from-end t :test #'string-equal
           :count 1 ;; :end 1 bug!!
	   ))
  "The location of the ZEBU source files.")
   
;;---------------------------------------------------------------------------;
;; *ZEBU-binary-directory*
;;------------------------
;; directory for compiled grammars and lisp files
;; 
(defparameter *ZEBU-binary-directory*
  (make-pathname :directory (append (pathname-directory *ZEBU-directory*)
                                    #-:64bit(list "binary")
				    #+:64bit(list "binary-64bit")))
  "The location of the compiled ZEBU files.")



;;; 2000-03-25 by rschlatte@ist.tu-graz.ac.at:
;;;   Extensions are defined multiple times in COMPILE-Zebu.lisp and
;;;   ZEBU-init.lisp
;;;   I was lazy and snarfed a list from mk:defsystem 3.x  :-)
;;; TODO
;;;   Do something clever with the environment package from CLOCC;
;;;   such a list should really be maintained in one place only.

;;; *filename-extensions* is a cons of the source and binary extensions.
(defvar *filename-extensions*
  (car `(#+(and Symbolics Lispm)              ("lisp" . "bin")
         #+(and dec common vax (not ultrix))  ("LSP"  . "FAS")
         #+(and dec common vax ultrix)        ("lsp"  . "fas")
 	 #+ACLPC                              ("lsp"  . "fsl")
 	 #+CLISP                              ("lsp"  . "fas")
         #+KCL                                ("lsp"  . "o")
         #+IBCL                               ("lsp"  . "o")
         #+Xerox                              ("lisp" . "dfasl")
	 ;; Lucid on Silicon Graphics
	 #+(and Lucid MIPS)                   ("lisp" . "mbin")
	 ;; the entry for (and lucid hp300) must precede
	 ;; that of (and lucid mc68000) for hp9000/300's running lucid,
	 ;; since *features* on hp9000/300's also include the :mc68000
	 ;; feature.
	 #+(and lucid hp300)                  ("lisp" . "6bin")
         #+(and Lucid MC68000)                ("lisp" . "lbin")
         #+(and Lucid Vax)                    ("lisp" . "vbin")
         #+(and Lucid Prime)                  ("lisp" . "pbin")
         #+(and Lucid SUNRise)                ("lisp" . "sbin")
         #+(and Lucid SPARC)                  ("lisp" . "sbin")
         #+(and Lucid :IBM-RT-PC)             ("lisp" . "bbin")
	 ;; PA is Precision Architecture, HP's 9000/800 RISC cpu
	 #+(and Lucid PA)                    ("lisp" . "hbin")
         #+excl                               ("cl"   . "fasl")
         #+CMU           ("lisp" . ,(or (c:backend-fasl-file-type c:*backend*)
					"fasl"))
;	 #+(and :CMU (not (or :sgi :sparc)))  ("lisp" . "fasl")
;        #+(and :CMU :sgi)                    ("lisp" . "sgif")
;        #+(and :CMU :sparc)                  ("lisp" . "sparcf")
	 #+PRIME                              ("lisp" . "pbin")
         #+HP                                 ("l"    . "b")
         #+TI ("lisp" . #.(string (si::local-binary-file-type)))
         #+:gclisp                            ("LSP"  . "F2S")
         #+pyramid                            ("clisp" . "o")
         #+:coral                             ("lisp" . "fasl")
	 ;; Harlequin LispWorks
	 #+:lispworks 	      ("lisp" . ,COMPILER:*FASL-EXTENSION-STRING*)
;        #+(and :sun4 :lispworks)             ("lisp" . "wfasl")
;        #+(and :mips :lispworks)             ("lisp" . "mfasl")
         #+:mcl                               ("lisp" . "fasl")

         ;; Otherwise,
         ("lisp" . "fasl")))
  "Filename extensions for Common Lisp. A cons of the form
   (Source-Extension . Binary-Extension). If the system is
   unknown (as in *features* not known), defaults to lisp and fasl.")

(defparameter *load-source-pathname-types*
  (list (car *filename-extensions*)))
(defparameter *load-binary-pathname-types*
  (list (cdr *filename-extensions*)))


;;; 2000-03-25 by rschlatte@ist.tu-graz.ac.at:
;;;   Snarfed from ZEBU-init.lisp
(defvar *zebu-version*
  (let ((file (make-pathname
               :name "Version"
               :type nil
               :directory (pathname-directory
                           *zebu-directory*))))
    (if (probe-file file)
        (with-open-file (s file :direction :input)
                        (read-line s))
      "3.5.5")))

(declaim (special *COMMENT-BRACKETS* *COMMENT-START* *PRESERVE-CASE*
	          *CASE-SENSITIVE* *DISALLOW-PACKAGES* *STRING-DELIMITER*
	          *SYMBOL-DELIMITER* *IDENTIFIER-START-CHARS*
	          *IDENTIFIER-CONTINUE-CHARS*
	          *ALLOW-CONFLICTS* *WARN-CONFLICTS*
	          *CURRENT-GRAMMAR* *GENERATE-DOMAIN*
	          ))

#-LUCID
(declaim (special *LOAD-SOURCE-PATHNAME-TYPES*
                  *LOAD-BINARY-PATHNAME-TYPES*))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            End of zebu-defsystem-package.lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
