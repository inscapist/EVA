;;; $DOOMDIR/+ui.el -*- lexical-binding: t; -*-

;; =======================================================================
;; UI variables
;; =======================================================================

;; custom variables
(setq felix/default-font "Recursive Mono Casual Static"
      felix/default-font-size 20
      felix/default-font-weight 'extra-light ;; refer font-weight-table variable
      felix/muted-font-height 0.95
      felix/modeline-font "Recursive Mono Casual Static"
      felix/modeline-height 0.8)

;; font settings
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t
      doom-theme 'doom-pine
      doom-font (font-spec :family felix/default-font
                           :size felix/default-font-size
                           :weight felix/default-font-weight))


;; customize faces. list with SPC-h-F
(custom-set-faces!
  `(font-lock-comment-face :slant italic :weight thin :height ,felix/muted-font-height)
  `(font-lock-keyword-face :slant italic :weight thin :height ,felix/muted-font-height)
  `(font-lock-function-name-face :slant normal :weight normal)
  `(mode-line :height ,felix/modeline-height :family ,felix/modeline-font)
  `(mode-line-inactive :height ,felix/modeline-height ,felix/modeline-font))

;; thinner modeline for (modeline +light)
(setq +modeline-height 18)

;; transparency
;; (set-frame-parameter (selected-frame)'alpha '(92 . 92))
;; (add-to-list 'default-frame-alist'(alpha . (92 . 92)))

(setq gc-cons-threshold (* 4000 1024 1024)) ; I got 4GB to spare..
