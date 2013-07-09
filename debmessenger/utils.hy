;; Copyright 2013 Simon Chopin <chopin.simon@gmail.com>
;;
;; This file is part of the debmessenger software and is placed under
;; the following license:
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be included
;; in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(import [ email.parser [ Parser ] ])

(defn file-to-mail [filename]
      (.parse (Parser) (open filename)))

(defn get-email-body [filename]
      (let (payload (.get_payload (file-to-mail filename)))
        (if (isinstance payload list)
          (get payload 0) ; Let's keep things simple and take the first one.
          payload)))

(defn mail-hook [translator publisher]
      (lambda (filename)
        (let ((msg-tuple (translator filename)))
          (kwapply (publisher)
                   { "topic" (get msg-tuple 0)
                     "msg" (get msg-tuple 1)
                   }))))
