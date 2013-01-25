;;;;Ivan's .emacs file
; Yifan Gu
; 17 January 2013

; set username and mail address
(setq user-full-name "Yifan Gu")
(setq user-mail-address "gu_yifan@vobile.com")
(defconst my-company "vobile")

(add-to-list 'load-path "/usr/share/emacs/site-lisp/emacs-goodies-el")
(add-to-list 'load-path "~/.emacs.d/lisp")
;(add-to-list 'load-path "~/.emacs.d/lisp/solarized-emacs-master")
;(load-theme 'solarized-dark)
; not to show GNU startup 
;(setq inhibit-startup-message t)
; show key seq fast
(setq echo-keystrokes 0.1)
; show line number
(setq column-number-mode t)
(setq line-number-mode t)
; not asking yes or no, use y/n
(fset 'yes-or-no-p 'y-or-n-p)
; prevent rolling page jump too much, scroll-margin 3
(setq scroll-margin 3
      scroll-conservatively 10000)
; no menu bar
(menu-bar-mode nil)
; no tool bar
(tool-bar-mode nil)
; no scroll bar
(set-scroll-bar-mode nil)
; setcolor
;(set-foreground-color "grey")
;(set-background-color "black")
;(set-cursor-color "gold1")
;(set-mouse-color "gold1")

(auto-image-file-mode t);image mode
(show-paren-mode t);
(setq mouse-yank-at-point t); yank with middle key
(setq x-selet-enable-clipboard t);emacs paste clip with other program
; full screen
(defun toggle-fullscreen()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  )
(toggle-fullscreen)

;(loop for x downfrom 40 to 1 do
;      (setq tab-stop-list (cons (* x 4) tab-stop-list)))
;
;color theme
(require 'color-theme)
(eval-after-load "color-theme"
		 '(progn (color-theme-initialize) ;(color-theme-billw) 
                 (color-theme-dark-laptop)
            ))
;font
(set-default-font "Monospace-10")


; indent
(setq indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)
(setq tab-stop-list ())
;c indent
(setq-default c-basic-offset 4
	      tab-width 4
	      indent-tabs-mode t)
(require 'cc-mode)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)


;python autoindent
(add-hook 'python-mode-hook '(lambda ()
                             (local-set-key (kbd "RET") 'newline-and-indent)))

;autopair
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers


;kill whole line biding
;(global-set-key (kbd "M-g") 'kill-whole-line)
;
;CEDET
(load-file "~/.emacs.d/lisp/cedet-1.1/common/cedet.el")
(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu
;semantic config
(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
;(semantic-load-enable-guady-code-helpers)
;(semantic-load-enable-excessive-code-helpers)
;(semantic-load-enable-semantic-debugging-helpers)
;[f12] to jump
(global-set-key [f12] 'semantic-ia-fast-jump)
;[S-f12] to jump back
(global-set-key [S-f12]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                    (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                      (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))
;;auto complete
(define-key c-mode-base-map (kbd "M-n") 'semantic-ia-complete-symbol-menu)
(add-to-list 'load-path "~/.emacs.d/lisp/auto-complete-1.3.1")
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/auto-complete-1.3.1/ac-dict")
;add ac-source-semantic to all buffer
(defun ac-common-setup ()
  (setq ac-sources (append ac-sources '(ac-source-semantic-raw)))
  )
;(global-semantic-idle-completions-mode)
;
;set ssh as the tramp default method
(setq tramp-default-method "ssh")