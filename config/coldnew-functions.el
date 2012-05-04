;;; coldnew-function.el ---
(eval-when-compile (require 'cl))


(defun emacs-process-p (pid)
  "If pid is the process ID of an emacs process, return t, else nil.
Also returns nil if pid is nil."
  (when pid
    (let ((attributes (process-attributes pid)) (cmd))
      (dolist (attr attributes)
	(if (string= "comm" (car attr))
	    (setq cmd (cdr attr))))
      (if (and cmd (or (string= "emacs" cmd) (string= "emacs.exe" cmd))) t))))

(defun get-ip-address (&optional dev)
  "get the IP-address for device DEV (default: eth0)"
  (let ((dev (if dev dev "eth0")))
    (format-network-address (car (network-interface-info dev)) t)))

;;;; ---------------------------------------------------------------------------
;;;; Search
;;;; ---------------------------------------------------------------------------

(defun search-backward-to-char (chr)
  "Search backwards to a character"
  (while (not (= (char-after) chr))
    (backward-char 1)))

(defun search-forward-to-char (chr)
  "Search forwards to a character"
  (while (not (= (char-before) chr))
    (forward-char 1)))

;;;; ---------------------------------------------------------------------------
;;;; Region
;;;; ---------------------------------------------------------------------------
(defun select-region-to-before-match (match &optional dir)
  "Selects from point to the just before the first match of
'match'.  The 'dir' controls direction, if nil or 'forwards then
go forwards, if 'backwards go backwards."
  (let ((start (point))
	(end nil))

    (transient-mark-mode 1)    ;; Transient mark
    (push-mark)                ;; Mark the start, where point is now

    (if (or (null dir)
	    (equalp 'forwards dir))

	;; Move forwards to the next match then back off
	(progn
	  (search-forward match)
	  (backward-char))

      ;; Or search backwards and move forwards
      (progn
	(search-backward match)
	(forward-char)))

    ;; Store, then hilight
    (setq end (point))
    (exchange-point-and-mark)

    ;; And return, swap the start/end depending on direction we're going
    (if (or (null dir)
	    (equalp 'forwards dir))
	(list start end)
      (list end start))))



;;;; ---------------------------------------------------------------------------
;;;; Buffer
;;;; ---------------------------------------------------------------------------
(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
	(if (eq mode major-mode)
	    (add-to-list 'buffer-mode-matches buf))))
    buffer-mode-matches))

;;;; ---------------------------------------------------------------------------
;;;; Date
;;;; ---------------------------------------------------------------------------
(defun current-date-time ()
  "return current date in `%Y-%m-%d' format, ex:`2012-04-25'."
  (let ((system-time-locale "en_US")
	(format "%Y-%m-%d"))
    (format-time-string "%Y-%m-%d")))

;;;; ---------------------------------------------------------------------------
;;;; Testing
;;;; ---------------------------------------------------------------------------
(defun font-exist-p (fontname)
  "test if this font is exist or not."
  (if (not (x-list-fonts fontname))
      nil t))

;;;; ---------------------------------------------------------------------------
;;;; Advice
;;;; ---------------------------------------------------------------------------

(defadvice kill-emacs (around recompile-emacs-config activate)
  "Before exit emacs, recompile emacs-config"
  (let ((config-dir emacs-config-dir))
    (byte-recompile-directory config-dir 0) ad-do-it))



(provide 'coldnew-functions)
;; coldnew-functions.el ends here.
