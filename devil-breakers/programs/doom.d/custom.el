(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(ignored-local-variable-values
   '((eval setq projectile-project-compilation-cmd "env TERM=dumb nix build --show-trace -vv && ./result && git push"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:slant italic :weight thin :height 0.95))))
 '(font-lock-function-name-face ((t (:slant normal :weight normal))))
 '(font-lock-keyword-face ((t (:slant italic :weight thin :height 0.95))))
 '(mode-line ((t (:height 0.8 :family "Monoid"))))
 '(mode-line-inactive ((t (:height 0.8 "Monoid"))))
 '(treemacs-root-face ((t (:family "Monoid" :slant italic :weight normal)))))
