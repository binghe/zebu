; -*- mode:     CL -*- ----------------------------------------------------- ;
; File:         zebu-actions.l
; Description:  Functions used in ZEBU grammar actions
; Author:       Joachim H. Laubsch
; Created:      11-Jul-91
; Modified:     Thu Mar  7 09:13:39 1996 (Joachim H. Laubsch)
; Language:     CL
; Package:      ZEBU
; Status:       Experimental (Do Not Distribute) 
; RCS $Header: /logon/CVS/logon/uib/lisp/lib/zebu/zebu-actions.lisp,v 1.1 2005/06/08 08:40:00 paul Exp $
;
; (c) Copyright 1991, Hewlett-Packard Company
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Revisions:
; RCS $Log: zebu-actions.lisp,v $
; RCS Revision 1.1  2005/06/08 08:40:00  paul
; RCS Files necessary for cgp
; RCS
; RCS Revision 1.1.1.1  2001/05/09 14:46:30  paul
; RCS Zebu 3.3.5 with Rudi Schlatte's adaptation to mk-defsytem
; RCS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ZEBU")
(provide "zebu-actions")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   Functions used in ZEBU grammar actions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(declaim (inline EMPTY-SEQ SEQ-CONS EMPTY-SET SET-CONS K-4-3))

(defun identity* (&rest x) x)

(defun EMPTY-SEQ () ())
(defun SEQ-CONS (a seq) (cons a seq))	

(defun EMPTY-SET () ())
(defun SET-CONS (a set) (adjoin a set))

(defun K-4-3 (ignore dummy1 result dummy2)
  ;; a K (constant) function of 4 arguments that returns the third
  (declare (ignore ignore dummy1 dummy2))
  result)

(defun K-2-1 (result dummy)
  ;; a K (constant) function of 2 arguments that returns the first
  (declare (ignore dummy))
  result)

(defun K-2-2 (dummy result)
  ;; a K (constant) function of 2 arguments that returns the 2nd
  (declare (ignore dummy))
  result)

(defun K-3-2 (dummy1 result dummy2)
  ;; a K (constant) function of 3 arguments that returns the 2nd
  (declare (ignore dummy1 dummy2))
  result)

(defun CONS-1-3 (a ignore b)
  (declare (ignore ignore))
  (cons a b))

(defun CONS-2-3 (ignore a b)
  (declare (ignore ignore))
  (cons a b))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        End of zebu-actions.l
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
