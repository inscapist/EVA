;;; $DOOMDIR/+ui.el -*- lexical-binding: t; -*-

;; =======================================================================
;; UI variables
;; =======================================================================

;; custom variables
(setq
 ;; felix/default-font "CommitMono"
 ;; felix/default-font "VictorMono Nerd Font"
 ;; felix/default-font "Recursive Mono Casual Static"
 ;; felix/default-font "Ellograph CF"
 ;; felix/default-font "Dank Mono"
 ;; felix/default-font "0xProto"
 ;; felix/default-font "Monoid"
 ;; felix/default-font "Monoid HalfTight"


 ;; Compact, although maybe not so pretty
 ;; felix/default-font "Monoid HalfTight"
 ;; felix/default-font-size 27

 ;; Playful like me
 felix/default-font "MonaspiceRn Nerd Font"
 felix/default-font-size 42

 ;; Skinny graceful, but not bold enough
 ;; felix/default-font "Lekton Nerd Font"
 ;; felix/default-font-size 34

 ;; Succulent but maybe more suitable for display
 ;; felix/default-font "Agave"
 ;; felix/default-font-size 34

 ;; Tidy but boring
 ;; felix/default-font "JetBrainsMono Nerd Font"
 ;; felix/default-font-size 28


 felix/default-font-weight 'light ;; refer font-weight-table variable
 felix/muted-font-height 0.95
 felix/modeline-font "MonaspiceRn Nerd Font"
 felix/modeline-height 0.9)

;; font settings
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t
      doom-theme 'doom-pine
      doom-font (font-spec :family felix/default-font
                           :size felix/default-font-size
                           :weight felix/default-font-weight)
      all-the-icons-scale-factor 0.7)


;; use kaolin theme
;; (use-package kaolin-themes
;;   :config
;;   (load-theme 'kaolin-mono-dark t)
;;   (setq kaolin-themes-italic-comments t))
;; (use-package kaolin-themes
;;   :config
;;   (load-theme 'kaolin-mono-dark t)
;;   (setq kaolin-themes-italic-comments t))


;; customize faces. list with SPC-h-F
(custom-set-faces!
  `(font-lock-comment-face :slant italic :weight thin :height ,felix/muted-font-height)
  `(font-lock-keyword-face :slant italic :weight thin :height ,felix/muted-font-height)
  `(font-lock-function-name-face :slant normal :weight normal)
  `(mode-line :height ,felix/modeline-height :family ,felix/modeline-font)
  `(mode-line-inactive :height ,felix/modeline-height ,felix/modeline-font))

;; performance hack
(setq inhibit-compacting-font-caches t)

;; thinner modeline for (modeline +light)
(setq +modeline-height 18)

;; transparency
;; (set-frame-parameter (selected-frame)'alpha '(92 . 92))
;; (add-to-list 'default-frame-alist'(alpha . (92 . 92)))
