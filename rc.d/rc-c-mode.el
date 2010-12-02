;;
(provide 'rc-c-mode)

(eval-when-compile (require 'cl))
(require 'thingatpt)
(require 'smartchr)

;; Coding-Style Setting
(add-hook 'c-mode-hook
	  '(lambda ()
	     (c-set-style "linux")                ; C 語言風格為 linux
	     (setq c-basic-offset             8 ) ; 縮排設定
	     (setq tab-width                  4 ) ; TAB 寬度為4個空格
	     (setq indent-tabs-mode         nil ) ; 禁止在縮排中插入制表符
	     (setq c-max-one-liner-length   100 ) ; 最大格數為 100 格
	     (setq compilation-window-height 10 ) ; 編譯結果視窗高度
	     ))

;;;; Keybindings
(add-hook 'c-mode-hook
	  '(lambda ()
	     (vim:nmap (kbd ",o") 'ff-find-other-file)
	     (vim:nmap (kbd ",h") 'ff-find-related-file)
	     (vim:imap (kbd "M-i") 'c-mode:insert-inc-or-if)
	     (vim:imap (kbd "M-d") 'c-mode:insert-do-while)
	     ;; FIXME:
	     ;; (vim:imap (kbd "=")   'c-mode:insert-equal)
	     ;; (vim:imap (kbd ".")   'c-mode:insert-pointer)
	     ;; (vim:imap (kbd ">")   'c-mode:insert-greater-or-shift)
	     ;; (vim:imap (kbd "<")   'c-mode:insert-lesser-or-shift)
	     ))

;;;; Hooks
(add-hook 'c-mode-hook
	  '(lambda ()
	     (programming-common-hook)	; programming common hook
	     ))

;;;; Auto-Mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))

;;;; Functions

(defcmd c-mode:insert-inc-or-if ()
  "If at the start of line. add `inc' and expand it,
else add `if' and expand it."
  (let* ((current (point))
	 (begin (line-beginning-position)))
    (if (eq current begin)
	(insert "inc")
      (insert "if"))
    (yas/expand)))

(defcmd c-mode:insert-do-while ()
  "insert do{...} while()."
  (insert "do")
  (yas/expand))


;; FIXME:
;; (defcmd c-mode:insert-equal ()
;;   "insert equal for easy."
;;   (if (and (featurep 'smartchr)
;; 	   (not (in-string-p)))
;;       (smartchr '(" = " " == "  "="))
;;     (self-insert-command 1)))

;; (defcmd c-mode:insert-pointer ()
;;   "insert . or -> for easy."
;;   (if (and (featurep 'smartchr)
;;   	   (not (in-string-p)))
;;       (smartchr '("." "->"))
;;     (self-insert-command 1)
;;     ))


;; (defcmd c-mode:insert-greater-or-shift ()
;;   "insert > or >> for easy."
;;   (if (and (featurep 'smartchr)
;; 	   (not (in-string-p)))
;;       (smartchr '(">" ">>"))
;;     (self-insert-command)))

;; (defcmd c-mode:insert-lesser-or-shift ()
;;   "insert < or << for easy."
;;   (if (and (featurep 'smartchr)
;; 	   (not (in-string-p)))
;;       (smartchr '("<" "<<"))
;;     (self-insert-command)))
