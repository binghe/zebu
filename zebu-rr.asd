;;; -*- Lisp -*-

(in-package #:asdf)

(defsystem #:zebu-rr
    :version "3.5.5"
    :depends-on ("zebu") 
    :components
    ((:file "zebu-kb-domain")
     (:file "zebu-tree-attributes"
            :in-order-to ((compile-op (load-op "zebu-kb-domain"))))
     (:file "zebra-debug"
            :in-order-to ((compile-op (load-op "zebu-kb-domain"
                                               "zebu-tree-attributes"))))))
