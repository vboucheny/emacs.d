;;; init.el --- Load the full configuration

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;;(setq debug-on-error t)



(setq mac-command-modifier 'meta)

;; elpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; magit
(package-install 'magit)

;; theme
(package-install 'zenburn-theme)
(load-theme 'zenburn t)

;; gui frames
;; Suppress GUI features
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(set-scroll-bar-mode nil)
(menu-bar-mode -1)
