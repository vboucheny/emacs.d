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

;; Org

;;; Default dirs
(let ((default-directory "~/org/"))
  (setq org-default-notes-file-path (expand-file-name "notes.org"))
  (setq refile-file-path (expand-file-name "todo.org"))
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
