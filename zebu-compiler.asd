;;; -*- Lisp -*-

;;;(in-package "CL-USER")

(asdf:defsystem #:zebu-compiler
    ;; Compile time system for LALR(1) parser: Converts a grammar to a
    ;; parse table
    :depends-on ("zebu")
    :components
    ((:file "zebu-regex")
     (:file "zebu-oset")
     (:file "zebu-kb-domain")        ; not explicitly in ZEBU-sys.lisp
     (:file "zebu-g-symbol"
            :in-order-to ((compile-op (load-op "zebu-oset"))))
     (:file "zebu-loadgram"
            :in-order-to ((compile-op (load-op "zebu-g-symbol")
                                      (load-op "zebu-oset"))))
     (:file "zebu-generator"
            :in-order-to ((compile-op (load-op "zebu-loadgram")
                                      (load-op "zebu-kb-domain"))))
     (:file "zebu-lr0-sets"
            :in-order-to ((compile-op (load-op "zebu-g-symbol")
                                      (load-op "zebu-loadgram"))))
     (:file "zebu-empty-st"
            :in-order-to ((compile-op (load-op "zebu-loadgram"))))
     (:file "zebu-first"
            :in-order-to ((compile-op (load-op "zebu-loadgram")
                                      (load-op "zebu-oset")))
            ;; :recompile-on "zebu-oset"
            )
     (:file "zebu-follow"
            :in-order-to ((compile-op (load-op "zebu-loadgram")
                                      (load-op "zebu-first"))))
     (:file "zebu-tables"
            :in-order-to ((compile-op (load-op "zebu-g-symbol")
                                      (load-op "zebu-loadgram")
                                      (load-op "zebu-lr0-sets"))))
     (:file "zebu-printers"
            :in-order-to ((compile-op (load-op "zebu-loadgram")
                                      (load-op "zebu-lr0-sets")
                                      (load-op "zebu-tables"))))
     (:file "zebu-slr")
     (:file "zebu-closure"
            :in-order-to ((compile-op (load-op "zebu-oset")
                                      (load-op "zebu-g-symbol")
                                      (load-op "zebu-first"))))
     (:file "zebu-lalr1"
            :in-order-to ((compile-op (load-op "zebu-oset")
                                      (load-op "zebu-lr0-sets")
                                      (load-op "zebu-follow"))))
     (:file "zebu-dump"
            :in-order-to ((compile-op (load-op "zebu-loadgram")
                                      (load-op "zebu-slr")
                                      (load-op "zebu-lalr1"))))
     (:file "zebu-compile"
            :in-order-to ((compile-op (load-op "zebu-dump"))))
     (:file "zebu-compile-mg"
            :in-order-to ((compile-op (load-op "zebu-compile")
                                      (load-op "zebu-dump")
                                      (load-op "zebu-empty-st")
                                      (load-op "zebu-closure")
                                      (load-op "zebu-tables")
                                      (load-op "zebu-generator"))
                          ((load-op (compile-op "zebu-compile-mg")
                                    (load-op "zebu-compile")
                                    (load-op "zebu-dump")
                                    (load-op "zebu-empty-st")
                                    (load-op "zebu-closure")
                                    (load-op "zebu-tables")
                                    (load-op "zebu-generator")))))
     (:file "zmg-dom"
            :in-order-to ((compile-op (load-op "zebu-compile-mg"))))
     (:file "zebu-kb-domain"
            :in-order-to ((compile-op (load-op "zmg-dom"))))
     ;;; Hook it into asdf
     (:file "zebu-asdf-setup"
            :in-order-to ((compile-op (load-op "zebu-kb-domain"))))))
   

                  
                      
