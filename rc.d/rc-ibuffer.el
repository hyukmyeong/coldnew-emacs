;;
(provide 'rc-ibuffer)

(when (require 'ibuffer nil 'noerror)

  (when (require 'ibuffer-expert nil 'noerror)
    (setq ibuffer-expert t))

  (setq ibuffer-saved-filter-groups
	'(("default"
	   ("*Buffer*" (name . "\\*.*\\*"))
	   ("Help" (or (mode . woman-mode)
		       (mode . man-mode)
		       (mode . info-mode)
		       (mode . help-mode)))
	   ("IRC"   (or (mode . erc-mode)
			(mode . rcirc-mode)))
	   ("w3m"   (mode . w3m-mode))
	   ("Shell Script" (or (mode . shell-mode)
			       (mode . python-mode)
			       (mode . perl-mode)
			       (mode . ruby-mode)))
	   ("C++ . C#" (or (mode . c++-mode)
			   (mode . csharpmode)))
	   ("C . Obj-C" (or (mode . c-mode)
			    (mode . objc-mode)))
	   ("Emacs" (mode . emacs-lisp-mode))
	   )))

  ;; Keybinding
  (when (require 'vim nil 'noerror)
    ;; BUG: (require 'vim-ibuffer nil 'noerror)
    (vim:nmap (kbd "C-x C-b") 'ibuffer))


  ;; Reverse group list
  (defadvice ibuffer-generate-filter-groups (after reverse-ibuffer-groups () activate)
    (setq ad-return-value (nreverse ad-return-value)))

  ;; Switching to ibuffer puts the cursor on the most recent buffer
  (defadvice ibuffer (around ibuffer-point-to-most-recent) ()
    "Open ibuffer with cursor pointed to most recent buffer name"
    (let ((recent-buffer-name (buffer-name)))
      ad-do-it
      (ibuffer-jump-to-buffer recent-buffer-name)))
  (ad-activate 'ibuffer)

  ;; Kill ibuffer after quit
  (defadvice ibuffer-quit (after kill-ibuffer activate)
    "Kill the ibuffer buffer on exit."
    (kill-buffer "*Ibuffer*"))
  (ad-activate 'ibuffer-quit)

  (add-hook 'ibuffer-mode-hook
	    (lambda ()
	      (hl-line-mode)		; Enable hight-line
	      (ibuffer-switch-to-saved-filter-groups "default")))

  )
