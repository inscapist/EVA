;;; $DOOMDIR/+bindings.el -*- lexical-binding: t; -*-

;; Unbind prefixes
(map! :nmo "r" nil
      :nmo "\\" nil
      :nmo "," nil
      :nei "<C-return>" nil)
(map! :map evil-snipe-mode-map
      :nmo "S" nil
      :nmo "," nil)
(map! :map evil-snipe-override-mode-map
      :nmo "S" nil
      :nmo "," nil)
(map! :map evil-cleverparens-mode-map
      :nmo "s" nil
      :nmo "S" nil
      :nmo "M-w" nil
      :nmo "M-v" nil
      :nmo "M-s" nil
      :nmo "C-\\" nil)

;; vim like sugar
(map!
 :nv "S" #'save-buffer
 :nv "F" #'avy-goto-char-timer
 :nv "J" #'evil-scroll-down
 :nv "K" #'evil-scroll-up
 :nv "gx" #'browse-url
 :nv "rr" #'evil-ex-nohighlight
 :nv "rb" #'revert-buffer
 :nv "rc" #'lsp-workspace-restart)

;; convenience
(map!
 :nei "M-v"   #'yank
 :nei "M-s"   #'save-buffer
 :nei "C-h"   #'evil-window-left
 :nei "C-l"   #'evil-window-right
 :nei "C-j"   #'evil-window-down
 :nei "C-k"   #'evil-window-up
 :nei "C-f"   #'+default/search-buffer
 :nei "C-M-h" #'+workspace/switch-left
 :nei "C-M-l" #'+workspace/switch-right
 :nei "C-M-r" #'+workspace/rename
 :nei "M-n"   #'+workspace/new
 :nei "M-w"   #'+workspace/close-window-or-workspace
 :nei "<C-return>" #'evil-make)

(map! :leader
      "o o" #'dired-jump
      "o O" #'projectile-dired)

;; Utils
(map!
 "C-c C-\\" #'evil-make)

;; Add/override treemacs keybindings
(map!
 :map treemacs-mode-map
 "p"     #'treemacs-peek
 "x"     #'treemacs-collapse-parent-node
 "X"     #'treemacs-collapse-all-projects
 "C-h"   #'evil-window-left
 "C-l"   #'evil-window-right
 "C-M-h" #'+workspace/switch-left
 "C-M-l" #'+workspace/switch-right
 "M-n"   #'+workspace/new
 "M-w"   #'+workspace/close-window-or-workspace)

;; Add some sugar in smartparens mode
(map!
 :map evil-cleverparens-mode-map
 :nmoei "s-q"    #'sp-indent-defun ;; reindent/format (useful in elisp?)
 :nmoei "s-S"    #'sp-split-sexp
 :nmoei "s-J"    #'sp-join-sexp
 :nmoei "s-("    #'evil-cp-wrap-next-round
 :nmoei "s-["    #'evil-cp-wrap-next-square
 :nmoei "s-{"    #'evil-cp-wrap-next-curly
 :nmo "s-\\"   #'evil-cp-copy-paste-form
 :nmo "C-M-\\"   #'evil-cp-copy-paste-form
 :nmo "s-j"    #'evil-cp-drag-forward
 :nmo "s-k"    #'evil-cp-drag-backward
 ;; :nmoei "s-s"    #'sp-splice-sexp ;; can be substituted with `x'
 ;; :nmoei "s-t"    #'sp-transpose-sexp ;; can be substituted by drag
 :nmoei "M-v"    nil
 :nmoei "M-V"    #'sp-convolute-sexp
 :nmoei "M-r"    #'sp-raise-sexp
 :nmoei "C-M-k"    #'delete-indentation
 :nmo "C-\\"   #'evil-cp-previous-opening
 :nmo "\\"     #'evil-cp-next-closing)

(map! :after lsp-mode
      ("C-c C-o" #'lsp-organize-imports))

(map! :after ranger
      (:map ranger-mode-map
       [escape] #'ranger-close ))

;; Add org-agenda keybindings
(map! :after evil-org-agenda
      (:map evil-org-agenda-mode-map :m "S" nil)
      (:map org-agenda-mode-map
       "S"     #'org-save-all-org-buffers
       "C-h"   #'evil-window-left
       "C-l"   #'evil-window-right
       "C-M-h" #'+workspace/switch-left
       "C-M-l" #'+workspace/switch-right
       "C-M-r"   #'+workspace/rename
       "M-n"   #'+workspace/new
       "M-w"   #'+workspace/close-window-or-workspace))

;; Easier window split
(map! :leader
      "\\" #'evil-window-vsplit
      "-" #'evil-window-split)

;; Ace window
(map! :leader "w w" #'ace-window)

;; Elfeed;
;; (map! :leader "e l" #'elfeed)

;; toggle LSP Doc
(map! :leader "h h" #'lsp-describe-thing-at-point)

(map! :map clojure-mode-map
      :nmo "C-c C-n" #'cider-ns-refresh)

;; force ALT key to be used as meta
(cond (IS-MAC
       (setq mac-option-modifier       'meta
             mac-right-option-modifier 'meta)))
