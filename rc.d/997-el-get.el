;;
(setq el-get-dir "~/.emacs.d/lisp/")
(add-to-list 'el-get-recipe-path "~/.emacs.d/etc/recipes")

(setq el-get-sources
      '(
	ac-anything
	anything-complete
	anything-config
	anything-c-shell-history
	anything-dabbrev-expand
	anything
	anything-grep
	anything-gtags
	anything-include
	anything-ipa
	anything-kyr
	anything-match-plugin
	anything-menu
	anything-migemo
	anything-show-completion
	anything-slime
	anything-yaetags
	apel
	async-eval
	auto-complete-clang
	autocomplete
	auto-complete-etags
	auto-complete-extension
	c-eldoc
	company
	completion-ui
	csharp-mode
	doxymacs
	el-get
	emms
	fic-mode
	gnugo
	gobject-class
	highlight-cl
	highlight-parentheses
	htmlize
	hungury-delete
	ipa
	ipython
	lusty-explorer
	magit
	multi-term
	nav
	newlisp-mode
	paredit
	popup-kill-ring
	popup-pos-tip
	pos-tip
	ppindent
	pylookup
	pymacs
	qmake-mode
	quack
	rainbow-mode
	revive
	smartchr
	ssh-config
	sunrise-commander
	undo-tree
	unicad
	vim-mode
	windows
	xcode-document-viewer
	yasnippet


	(:name xcscope+
	       :type emacswiki)

	(:name rcirc-color
	       :type emacswiki)
	(:name rcirc-controls
	       :type emacswiki)
	;;elscreen
	;;auctex
	;;color-theme			;

	;;  session
	;; emacs-w3m

	))

;;(el-get 'wait)



(provide '997-el-get)
;; 997-el-get.el ends here.
