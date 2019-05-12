;; -*- mode: lisp -*-
;;****************************************************************************
;;FILE:               zebu-clisp.lisp
;;LANGUAGE:           Common-Lisp
;;SYSTEM:             Common-Lisp
;;USER-INTERFACE:     NONE
;;DESCRIPTION
;;    
;;    Here are some notes concerning the installation, patching
;;    and use of Zebu with clisp (2.30).
;;    
;;AUTHORS
;;    <PJB> Pascal Bourguignon <pjb@informatimago.com>
;;MODIFICATIONS
;;    2003-11-13 <PJB> Created.
;;BUGS
;;LEGAL
;;    GPL
;;    
;;    Copyright Pascal Bourguignon 2003 - 2003
;;    
;;    This program is free software; you can redistribute it and/or
;;    modify it under the terms of the GNU General Public License
;;    as published by the Free Software Foundation; either version
;;    2 of the License, or (at your option) any later version.
;;    
;;    This program is distributed in the hope that it will be
;;    useful, but WITHOUT ANY WARRANTY; without even the implied
;;    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;;    PURPOSE.  See the GNU General Public License for more details.
;;    
;;    You should have received a copy of the GNU General Public
;;    License along with this program; if not, write to the Free
;;    Software Foundation, Inc., 59 Temple Place, Suite 330,
;;    Boston, MA 02111-1307 USA
;;****************************************************************************

(FORMAT T "Don't try to load ~S blindly. Read it and personalize it, ~@
           or cut-and-paste from it.~%" *load-pathname*)
(EXT:QUIT)

;; 1- Install the ZEBU sources in a convenient place;
;;    (In my case, I put it in /usr/local/share/lisp/packages/com/hp);
;;    Apply the provided patch;
;;    And add some symbolic links because type and version numbers in
;;    directory names and mixed case file name mess with 
;;    logical pathname translations...

(EXT:CD "/") ;; don't stay in zebu-3.5.5 when it's deleted under clisp 2.30...
(EXT:SHELL (CONCATENATE 'STRING
             "cd /usr/local/share/lisp/packages/com/hp ;"
             "rm -rf zebu-3.5.5 zebu ;" ;; if you want to redo it...
             "tar zxf /data/mirrors/cmu-ai-repository/new/zebu-3.5.5.tgz ;"
             "patch -p0 < zebu-clisp.patch ;"
             "ln -s zebu-3.5.5 zebu ;"
             "ln -s COMPILE-ZEBU.lisp zebu/compile-zebu.lisp ;"
             "ln -s ZEBU-init.lisp    zebu/zebu-init.lisp ;"
             ))

;;
;; There should be no reject to the patch; if there is, apply it by hand!
;; (patch 2.5.4 seems to have difficulties to patch COMPILE-ZEBU.lisp).
;;


;; 2- Add logical pathname translations:

(DEFUN ADD-TRANSLATIONS (&REST TRANSLATIONS)
  "
DO:         Prepend the TRANSLATIONS to the list of logical pathname
            translations of the PACKAGE: logical host.
"
  (SETF (LOGICAL-PATHNAME-TRANSLATIONS "PACKAGE")
        (NCONC (COPY-SEQ TRANSLATIONS)
               (HANDLER-CASE
                   (LOGICAL-PATHNAME-TRANSLATIONS "PACKAGE")
                 (ERROR NIL))))
  );;ADD-TRANSLATIONS


(ADD-TRANSLATIONS
 '("COM;**;*"      "/usr/local/share/lisp/packages/com/**/*")
 '("COM;**;*.*"    "/usr/local/share/lisp/packages/com/**/*.*")
 '("COM;**;*.*.*"  "/usr/local/share/lisp/packages/com/**/*.*.*"))


;; 3- Use the file COMPILE-ZEBU.LISP to compile this software.
;;    Ignore the other "entry points" files.

(LOAD "PACKAGE:COM;HP;ZEBU;COMPILE-ZEBU.LISP")


;; 4- load ZEBU:

(LOAD "PACKAGE:COM;HP;ZEBU;ZEBU-INIT.LISP")
(ZB:ZEBU)
(ZB:ZEBU-COMPILER)
(ZB:ZEBU-RR)


;; 5- read the doc:

(DEFUN ZEBU-DOC ()
  (EXT:RUN-SHELL-COMMAND
   "gv /usr/local/share/lisp/packages/com/hp/zebu/doc/Zebu_intro.ps"
   :WAIT NIL)
  );;ZEBU-DOC
(ZEBU-DOC)


;; 6- edit a grammar file (or choose one of the example .zb files).
;;
;; 7- compile a grammar file (.zb) into a compiled grammar (.tab):

(LET ((*WARN-CONFLICTS* T)
      (*ALLOW-CONFLICTS* T))
  (ZEBU-COMPILE-FILE "arith-exp.zb" :OUTPUT-FILE "arith-exp.tab" :VERBOSE T))


;; 8- load a compiled grammar (.tab):

(DEFPARAMETER GR-ARITH (ZEBU-LOAD-FILE "arith-exp.tab" :VERBOSE T))

(DEFUN PRINT-FACTOR (FACTOR STREAM LEVEL)
  (DECLARE (IGNORE LEVEL))
  (FORMAT STREAM "(~A)" (FACTOR--VALUE FACTOR))
  );;PRINT-FACTOR


;; 9- parse a string:

(SETQ PT (READ-PARSER " 1 + a*( 4+a+c )  " :GRAMMAR GR-ARITH))
(VALUES (TYPE-OF PT)
        (PLUS-OP--ARG1 PT)
        (PLUS-OP--ARG2 PT)
        (TYPE-OF (PLUS-OP--ARG2 PT)))



;; 10- To compile a grammar:

(LOAD "PACKAGE:COM;HP;ZEBU;ZEBU-INIT.LISP")
(ZB:ZEBU)
(ZB:ZEBU-COMPILER)
(ZB:ZEBU-RR)
(LET ((*WARN-CONFLICTS* T)
      (*ALLOW-CONFLICTS* T))
  (ZEBU-COMPILE-FILE "pc2.zb" :OUTPUT-FILE "pc2.tab"))



;; 11- To use a compiled grammar:

(LOAD "PACKAGE:COM;HP;ZEBU;ZEBU-INIT.LISP")
(ZB:ZEBU)
(DEFPARAMETER GR-PC2 (ZEBU-LOAD-FILE "pc2.tab"))
(READ-PARSER " p and (q or r) and s " :GRAMMAR GR-PC2)


;;;; zebu-clisp.lisp                  -- 2003-11-13 07:39:00 -- pascal   ;;;;
