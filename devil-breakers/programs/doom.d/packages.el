;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; ==============================================
;; After changing this file, runs `doom sync -u'
;; ==============================================

;; Disable
(package! undo-fu-session :disable t)
(package! alchemist :disable t)
(package! alchemist-company :disable t)
(package! lsp-ui :disable t)


;; Extra packages
(package! zoom)
(package! treemacs-all-the-icons)
(package! evil-cleverparens)
(package! origami)
(package! lsp-origami)
(package! graphviz-dot-mode)
(package! prettier)
(package! just-mode)
(package! coffee-mode)
(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
;; (package! sqlformat)


;; Themes
(package! kaolin-themes)


;; Unpin
(unpin! (:lang clojure python elixir javascript))
(unpin! (:tools lsp))
(unpin! (:editor format))
(unpin! (:ui treemacs))
