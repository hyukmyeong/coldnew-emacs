;;;; init file

(require 'site-gentoo nil 'noerror)        ; 讀取 Gentoo 安裝的外掛資訊
(setq-default inhibit-default-init t )     ; 關閉全域初始化
(setq-default debug-on-error     nil )
(setq-default custom-file "~/.emacs.d/rc.d/custom.el")

;;;;;;; start server for emacsclient
(when (require 'server nil 'noerror)
  (unless (server-running-p)
    (server-start)))

;;;;;;; 運行環境辨別
(defvar mac-p     (eq system-type 'darwin))
(defvar linux-p   (and (eq system-type 'gnu/linux) (not mac-p)))
(defvar cygwin-p  (eq system-type 'cygwin))
(defvar windows-p (eq system-type 'windows-nt))
(defvar emacs23-p (equal emacs-major-version 23))
(defvar emacs24-p (equal emacs-major-version 24))

;;;;;;;; 將指定目錄裡的東西全部加入清單
;; (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;     (let* ((my-lisp-dir "~/.emacs.d/")
;;	   (default-directory my-lisp-dir))
;;       (setq load-path (cons my-lisp-dir load-path))
;;       (normal-top-level-add-subdirs-to-load-path)))
(add-to-list 'load-path "~/.emacs.d/rc.d/")
(add-to-list 'load-path "~/.emacs.d/theme/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "~/.emacs.d/local-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;;;; Extra font-lock
(font-lock-add-keywords 'emacs-lisp-mode
			'(("(\\(\\defcmd\\)\\s \\(\\(?:\\s_\\|\\sw\\)+\\)"
			   (1 font-lock-keyword-face)
			   (2 font-lock-function-name-face))
			  ("(\\(require\\*\\)\\s [ \t']*\\(\\sw+\\)?"
			   (1 font-lock-keyword-face)
			   (2 font-lock-constant-face nil t))))


(defmacro* defcmd (name &rest body)
  "Define a interactive functions without arguments."
  (if (and (consp body)
	   (cdr body)
	   (stringp (car body)))
      (setq doc (car body)
	    body (cdr body))
    (setq doc (format "Command (%s)" name)))
  `(progn
     (put ',name 'function
	  (function* (lambda  ,@body)))
     (defun* ,name (&rest args)
       ,doc
       (interactive)
       (apply (get ',name 'function) args))))



;; (defmacro require-maybe (feature &optional file)
;;   "*Try to require FEATURE, but don't signal an error if `require' fails."
;;   `(require ,feature ,file 'noerror))

(defmacro when-available (func foo)
  "*Do something if FUNCTION is available."
  `(when (fboundp ,func) ,foo))

(defmacro require* (feature &optional file)
  "*Try to require FEATURE, but don't signal an error if `require' fails."
  `(let ((require-result (require ,feature ,file 'noerror)))
     (with-current-buffer (get-buffer-create "*Loading Log*")
       (let* ((startup-log-format-string-prefix "\t%-30s\t\t\t[")
	      (startup-log-format-string-postfix "%s")
	      (startup-status (if require-result "LOADED" "FAILED"))
	      (startup-status-face `(face (:foreground
					   ,(if require-result "green" "red")))))
	 (insert (format startup-log-format-string-prefix ,feature))
	 (let ((start-pos (point)))
	   (insert (format startup-log-format-string-postfix startup-status))
	   (add-text-properties start-pos (point) startup-status-face)
	   (insert "]\n"))))
     require-result))








(load "000-init")



;;;;;; load package initial setting
(require '000-macro)			; All Macros I use



;;(require 'circuit-mode)
;;(setq-default header-line-format mode-line-format) ; Copy mode-line to top
;;(setq-default mode-line-format nil) ; Remove mode-line
(defcmd show-mode-line ()
  (if mode-line-format
      (setq mode-line-format nil)
    (setq mode-line-format	t)))
