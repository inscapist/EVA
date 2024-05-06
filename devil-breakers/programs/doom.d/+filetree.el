;;; $DOOMDIR/+filetree.el -*- lexical-binding: t; -*-

;; (setq felix/treemacs-font "Monoid"
;;       felix/treemacs-font-size 20
;;       felix/treemacs-font-weight 'extra-light
;;       doom-variable-pitch-font (font-spec :family felix/treemacs-font :size felix/treemacs-font-size :weight felix/treemacs-font-weight))

;; (custom-set-faces!
;;   `(treemacs-root-face :family ,felix/default-font :slant italic :weight normal))

;; (custom-set-faces!
;;   `(treemacs-file-face :family ,felix/default-font :slant italic :weight normal :height 0.9)
;;   `(treemacs-tags-face :family ,felix/default-font :slant italic :weight normal :height 0.9)
;;   `(treemacs-hl-line-face :family ,felix/default-font :slant italic :weight normal :height 0.9)
;;   `(treemacs-directory-face :family ,felix/default-font :slant italic :weight normal :height 0.9))

;; customize treemacs
(after! treemacs
  (setq treemacs--width-is-locked nil
        treemacs-width 32
        treemacs-position 'left
        treemacs-show-cursor t
        treemacs-read-string-input 'from-minibuffer)
  (treemacs-git-mode 'simple)
  (with-eval-after-load 'treemacs
    (defun treemacs-ignore-python-cache-dirs (_filename absolute-path)
      (or
       (cl-search "__pycache__" absolute-path)
       (cl-search ".pytest_cache" absolute-path)))
    (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-python-cache-dirs)
    (add-to-list 'treemacs-pre-file-insert-predicates #'treemacs-is-file-git-ignored?)))

