;;
(eval-when-compile (require 'cl))



;; auto-update egg-status on file save
(setq egg-auto-update t)

;; do not switch to the status buffer in the same window
(setq egg-switch-to-buffer t)

;; kyebindings
(add-hook 'egg-status-buffer-mode-hook
	  '(lambda ()
	     (vim:local-nmap (kbd "s") 'egg-stage-untracked-files)
	     (vim:local-nmap (kbd "S") 'egg-stage-all-files)
	     (vim:local-nmap (kbd "c") 'egg-commit-log-edit)
	     (vim:local-nmap (kbd "p") 'egg-buffer-cmd-navigate-prev)
	     (vim:local-nmap (kbd "n") 'egg-buffer-cmd-navigate-next)
	     (vim:local-nmap (kbd "l") 'egg-log)
	     (vim:local-nmap (kbd "G") 'egg-status-buffer-redisplay)
	     (vim:local-nmap (kbd "h") 'egg-section-cmd-toggle-hide-show)
	     (vim:local-nmap (kbd "H") 'egg-section-cmd-toggle-hide-show-children)
	     (vim:local-nmap (kbd "q") 'egg-quit-buffer)
	     (vim:local-nmap (kbd "u") 'egg-diff-section-cmd-undo)
	     ))
(add-hook 'egg-log-msg-mode-hook
	  '(lambda ()
	     (vim:local-nmap (kbd "p") 'egg-buffer-cmd-navigate-prev)
	     (vim:local-nmap (kbd "n") 'egg-buffer-cmd-navigate-next)
	     (vim:local-nmap (kbd "/") 'egg-search-changes)
	     (vim:local-nmap (kbd "s") 'egg-status)
	     (vim:local-nmap (kbd "G") 'egg-buffer-cmd-refresh)
	     (vim:local-nmap (kbd "q") 'egg-quit-buffer)
	     (vim:local-nmap (kbd "h") 'egg-section-cmd-toggle-hide-show)
	     (vim:local-nmap (kbd "H") 'egg-section-cmd-toggle-hide-show-children)
	     (vim:local-nmap (kbd "o") 'egg-log-buffer-checkout-commit)
	     (vim:local-nmap (kbd "b") 'egg-log-buffer-start-new-branch)
	     (vim:local-nmap (kbd "a") 'egg-log-buffer-attach-head)
	     (vim:local-nmap (kbd "t") 'egg-log-buffer-tag-commit)
	     (vim:local-nmap (kbd "T") 'egg-log-buffer-atag-commit)
	     (vim:local-nmap (kbd "B") 'egg-log-buffer-create-new-branch)
	     (vim:local-nmap (kbd "m") 'egg-log-buffer-merge)
	     (vim:local-nmap (kbd "r") 'egg-log-buffer-rebase)
	     (vim:local-nmap (kbd "R") 'egg-log-buffer-rebase-interactive)
	     ;;
	     ;; (vim:local-nmap (kbd "S") 'egg-stage-all-files)
	     ;; (vim:local-nmap (kbd "c") 'egg-commit-log-edit)
	     ;; (vim:local-nmap (kbd "l") 'egg-log)
	     ;; (vim:local-nmap (kbd "u") 'egg-diff-section-cmd-undo)
	     ))

;;;;;;;; Advice

;; visiting a file in ibuffer makes it "fullscreen"
(defadvice egg-status (around goto-egg-status-buffer activate)
  "Delete other windows after visiting egg-status"
  ad-do-it
  (delete-other-windows))


(provide '054-egg)
;; 054-egg.el ends here.