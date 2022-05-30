;;; init.el --- Load the full configuration

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;;(setq debug-on-error t)


(setq mac-command-modifier 'meta)

;; Custom
(setq custom-file (concat user-emacs-directory "/custom.el"))

;; Desktop
(desktop-save-mode 1)

;; elpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; magit
(package-install 'magit)

;; theme
(package-install 'zenburn-theme)
(load-theme 'zenburn t)

;; GUI
;; Suppress GUI features
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(set-scroll-bar-mode nil)
(menu-bar-mode -1)
(setq visible-bell 1)
(fset 'yes-or-no-p 'y-or-n-p)

;; IDO
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)

;; Editing
;;; Cut/copy the current line if no region is active

(put 'kill-ring-save 'interactive-form
     '(interactive
       (if (use-region-p)
           (list (region-beginning) (region-end))
         (list (line-beginning-position) (line-beginning-position 2)))))
(put 'kill-region 'interactive-form      
     '(interactive
       (if (use-region-p)
           (list (region-beginning) (region-end))
         (list (line-beginning-position) (line-beginning-position 2)))))

;;; Duplicate line
(package-install 'move-dup)
(require 'move-dup)
(define-key global-map [M-up] 'move-dup-move-lines-up)
(define-key global-map [M-down] 'move-dup-move-lines-down)
(define-key global-map "\C-cd" 'move-dup-duplicate-down)
(define-key global-map "\C-cu" 'move-dup-duplicate-up)

;; Org

;;; Default dirs
(let ((default-directory "~/org/"))
  (setq org-default-notes-file-path (expand-file-name "notes.org"))
  (setq refile-file-path (expand-file-name "todo.org"))
  (setq events-file-path (expand-file-name "events.org"))
  (setq org-journal-dir (expand-file-name "journal")))
  
;;; Journal
(package-install 'org-journal)
(require 'org-journal)

;;; Capture templates
(setq org-capture-templates
      `(("t" "todo" entry (file refile-file-path)
         "* TODO %?")
	("n" "note" entry (file "")
	 "* %? :NOTE:") ; "" => `org-default-notes-file'
	("e" "event" entry (file events-file-path)
	 "* %?\nSCHEDULED: %T")
	))


;;; Keybindings
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-cc" 'org-capture)

;;; Agenda
(setq org-agenda-files '("~/org/"))

;;; Refiling
(setq org-refile-use-cache nil)
(setq org-refile-use-outline-path t)
(setq org-outline-path-complete-in-steps nil)
;;; Org Babel
(setq org-confirm-babel-evaluate nil)
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (ruby . t)
     (shell . t)
     )))

;; Search
(package-install 'anzu)
(require 'anzu)
(add-hook 'after-init-hook 'global-anzu-mode)
(setq anzu-mode-lighter "")
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key [remap query-replace] 'anzu-query-replace)
