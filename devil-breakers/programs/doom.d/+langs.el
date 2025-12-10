;;; $DOOMDIR/+langs.el -*- lexical-binding: t; -*-

(setq web-mode-code-indent-offset 2)

;; lsp settings
;; (setq lsp-rust-analyzer-rustfmt-override-command '("leptosfmt" "--stdin" "--rustfmt"))

(after! lsp-mode
  (setq lsp-enable-file-watchers nil)
  (setq lsp-clients-typescript-init-opts '(:importModuleSpecifierPreference "non-relative"))
  (add-to-list 'exec-path "~/elixir-ls"))

;; rust-analyzer: make sure we send cargo config
;; in the shapes it expects, to avoid deserialization
;; errors like those at /cargo/cfgs.
(after! lsp-rust
  ;; rust-analyzer expects `cargo.cfgs` to be a sequence
  ;; (JSON array). Use an empty vector here instead of nil
  ;; so it doesn't see `null` and complain.
  (setq lsp-rust-analyzer-cargo-cfgs [])
  ;; Ensure extraEnv is always a JSON object (map),
  ;; not a sequence/array.
  (setq lsp-rust-analyzer-cargo-extra-env (make-hash-table :test 'equal)))


;; SQL
;; (setq sqlformat-command 'pgformatter)
;; (setq sqlformat-args '("-s2" "-g" "-u" "2" "-U" "1"))
;; (add-hook 'sql-mode-hook 'sqlformat-on-save-mode)

;; electric rjsx
;; https://github.com/felipeochoa/rjsx-mode/issues/112
(defun +javascript-rjsx-electric-gt-a (_)
  (when (and (looking-back "<>")
             (looking-at-p "/>"))
    (save-excursion (insert "<"))))
(advice-add #'rjsx-electric-gt :after #'+javascript-rjsx-electric-gt-a)

;; typescript tsx use prettier
(setq-hook! 'typescript-tsx-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-mode-hook +format-with-lsp nil)
(setq-hook! 'nix-mode-hook +format-with-lsp nil)

;; https://github.com/doomemacs/doomemacs/issues/7490
(setq-hook! 'clojure-mode-hook
  apheleia-inhibit t
  +format-with nil)


;; do not format markdown slidev
(setq-hook! 'markdown-mode-hook +format-with :none)

;; where smartparens lives, summon some cleverness
;; Ma, I can now slurp and barf as i pleased T_T
(add-hook 'clojure-mode-hook #'evil-cleverparens-mode)
(add-hook 'latex-mode-hook #'evil-cleverparens-mode)
(add-hook 'elixir-mode-hook #'evil-cleverparens-mode)
(add-hook 'emacs-lisp-mode-hook #'evil-cleverparens-mode)

;; format html:
;;   add the following code to .dir-locals.el
;;   ((web-mode . ((eval . (prettier-mode t)))))
;; (setq-hook! 'web-mode-hook +format-with :none)


;; =============================================
;; Astro support
(define-derived-mode astro-mode web-mode "astro")
(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(astro-mode . "astro"))

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("astro-ls" "--stdio"))
                    :activation-fn (lsp-activate-on "astro")
                    :server-id 'astro-ls)))

(add-hook! astro-mode #'lsp!)
;; =============================================


;; =============================================
;; Ruby support
(use-package! apheleia)
(setq +format-on-save-disabled-modes
      '(ruby-mode web-mode))

(after! ruby-mode
  (setq-hook! 'ruby-mode-hook +format-with 'prettier-ruby))

;; force ruby-lsp to be used instead of rubocop
(with-eval-after-load 'lsp-mode
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("ruby-lsp"))
    :activation-fn (lsp-activate-on "ruby")
    :priority 9999
    :server-id 'ruby-lsp)))
;; =============================================
