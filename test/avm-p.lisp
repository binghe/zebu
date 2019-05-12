; -*- mode:     CL -*- ----------------------------------------------------- ;
; File:         av-printers.l
; Description:  
; Author:       Joachim H. Laubsch
; Created:      13-Apr-92
; Modified:     Thu Oct  2 12:49:53 1997 (Joachim H. Laubsch)
; Language:     CL
; Package:      CL-USER
; Status:       Experimental (Do Not Distribute) 
; RCS $Header: $
;
; (c) Copyright 1992, Hewlett-Packard Company
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Revisions:
; RCS $Log: $
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "CL-USER")

(defun print-FEAT-TERM (ITEM STREAM LEVEL)
  (DECLARE (IGNORE LEVEL))
  (format STREAM
	  "~@[type: ~S ~][~{~S~^ ~}]"
	  (FEAT-TERM--type ITEM)
	  (FEAT-TERM--slots ITEM)))

(defun print-General-Var (ITEM STREAM LEVEL)
  (DECLARE (IGNORE LEVEL))
  (format STREAM
	  "%~S"
	  (General-Var--name ITEM)))

(defun print-Label-value-pair (ITEM STREAM LEVEL)
  (DECLARE (IGNORE LEVEL))
  (format STREAM
	  "(~S ~S)"
	  (Label-value-pair--label ITEM)
	  (Label-value-pair--value ITEM)))

(defun PRINT-TAGGED-TERM (ITEM STREAM LEVEL)
  (DECLARE (IGNORE LEVEL))
  (format STREAM
	  "~S=~S"
	  (Tagged-Term--tag ITEM)
	  (Tagged-Term--term ITEM)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            End of av-printers.l
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
