
(in-package :asdf)

(defclass zebu-source-file (source-file) ())

(defmethod source-file-type ((c zebu-source-file) (s module)) "zb")

(defmethod perform ((operation compile-op) (c zebu-source-file))
  (zebu:zebu-compile-file (component-pathname c)))

(defmethod perform ((o load-op) (c zebu-source-file))
  (let* ((co (make-sub-operation o 'compile-op))
         (output-files (output-files co c)))
    (setf (component-property c 'last-loaded)
          (file-write-date (car output-files)))
  (zb:zebu-load-file (car output-files))))

(defmethod output-files ((operation compile-op) (c zebu-source-file))
  (list (merge-pathnames (component-pathname c)
                         (make-pathname :type "tab"))
        ;; FIXME: The following is not always right: the name of the
        ;; domain file can be given as an option to the grammar.  Look
        ;; at the function zebu::dump-domain-file to find out how the
        ;; name is constructed in the general case.
        (merge-pathnames (make-pathname
                          :name (concatenate 'string (pathname-name
                                                      (component-pathname c))
                                             "-domain"))
                         (make-pathname
                          :type (car zebu::*load-binary-pathname-types*)))
        ))

