;;; -*- Lisp -*-

(in-package #:asdf)

(defsystem #:zebu
    :version "3.5.5"
    :components
    ((:module "zebu-kernel"
              ;; Functions needed in the ZEBU run-time and
              ;; compile-time enironment
              :pathname ""
              :components
              ((:file "zebu-package")
               (:file "zebu-aux"
                      :in-order-to
                      ((compile-op (load-op "zebu-package"))))
               (:file "zebu-mg-hierarchy"
                      :in-order-to
                      ((compile-op (load-op "zebu-aux"))))))
     (:module "zebu-runtime"
              ;; Run time system for LALR(1) parser
              :pathname ""
              :depends-on ("zebu-kernel")
              :components
              ((:file "zebu-loader")
               (:file "zebu-driver"
                      :in-order-to ((compile-op (load-op "zebu-loader"))))
               (:file "zebu-actions"
                      :in-order-to ((compile-op (load-op "zebu-loader"))))))))
                      
