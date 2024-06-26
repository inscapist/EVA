;;; $DOOMDIR/+editor.el -*- lexical-binding: t; -*-

;; Do not ask for "Confirm exit Emacs"
(setq confirm-kill-emacs nil)

;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Silence all that useless output
(setq direnv-always-show-summary nil)

;; Display line number, use `SPC t l' to toggle
(setq display-line-numbers-type t)

;; History & backup settings (save nothing, that's what git is for)
(setq auto-save-default nil
      create-lockfiles nil
      history-length 500
      make-backup-files nil)

;; Avy is the best
(setq avy-all-windows t)

;; Lsp optimization
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; disable symbol highlighting
(setq lsp-enable-symbol-highlighting t)

;; start with lisp interaction mode in scratch buffer
;; (setq doom-scratch-initial-major-mode 'lisp-interaction-mode)

;; origami
;;(global-origami-mode)
;;(add-hook 'lsp-after-open-hook #'lsp-origami-try-enable)


;; https://emacs.stackexchange.com/questions/28135/in-evil-mode-how-can-i-prevent-adding-to-the-kill-ring-when-i-yank-text-visual
(setq-default evil-kill-on-visual-paste nil)


;; don't show code action on sideline, as it blocks the code
(setq lsp-ui-sideline-show-code-actions nil)

;; popup rules
(after! embark
  (set-popup-rule! "^*Embark" :side 'bottom :size 0.4 :select t :modeline nil :quit nil :ttl nil))
(after! cider
  (set-popup-rule! "^*cider-repl" :side 'right :size 0.35 :select t :modeline nil :quit nil :ttl nil))
;;(setq cider-ns-refresh-show-log-buffer t))


;; Allow local variables to be set
(put 'cider-ns-refresh-before-fn 'safe-local-variable (lambda (_) t))
(put 'cider-ns-refresh-after-fn 'safe-local-variable (lambda (_) t))
(put 'cider-default-cljs-repl 'safe-local-variable (lambda (_) t))
(put 'cider-shadow-cljs-default-options 'safe-local-variable (lambda (_) t))

;; prioritize snippets
(setq +lsp-company-backends '(:separate company-yasnippet company-capf))
