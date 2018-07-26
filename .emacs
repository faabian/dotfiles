;; manuelles Laden der Pakete *vor* den anderen Einstellungen
(setq package-enable-at-startup nil)
(package-initialize)

;; (load-theme 'zenburn t)

;; Font:
(set-face-attribute 'default t :font "DejaVu Sans Mono")
(set-face-attribute 'default nil :height 100)

;; F12 fuer .emacs
;; (interactive) -> siehe http://stackoverflow.com/questions/1250846/wrong-type-argument-commandp-error-when-binding-a-lambda-to-a-key
(global-set-key (kbd "<f12>") (lambda () (interactive) (find-file "~/.emacs")))

;; org-mode C-c l: org-store-link, zB zu active file
(global-set-key (kbd "C-c l") 'org-store-link)

(setq inferior-lisp-program "/usr/bin/sbcl")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
(require 'slime)
(slime-setup '(slime-fancy))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(global-linum-mode 1)
(show-paren-mode 1)

;; OrgMode
(setq org-startup-indented t)

;; ParEdit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/org.org")))
 '(safe-local-variable-values
   (quote
    ((org-todo-keyword-faces
      ("TODO" . "red")
      ("GELESEN" . "orange")
      ("GEÜBT" . "green"))
     (org-todo-keyword-faces
      ("TODO" . "blue")
      ("GELESEN" . "orange")
      ("GEÜBT" . "green"))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; google-c-style.el
;; C++ Programmieren

;; aus der Datei:

;; Provides the google C/C++ coding style. You may wish to add
;; `google-set-c-style' to your `c-mode-common-hook' after requiring this
;; file. For example:

(add-hook 'c-mode-common-hook 'google-set-c-style)

;; If you want the RETURN key to go to the next line and space over
;; to the right place, add this to your .emacs right after the load-file:

(add-hook 'c-mode-common-hook 'google-make-newline-indent)


;; Copyright notice skeleton
(define-skeleton fg-copyright-c++
  "Insert a copyright notice."
  nil
  "// Copyright 2016 Fabian Glöckle
// Author: Fabian Glöckle <fabian.gloeckle@saturn.uni-freiburg.de>

"
)

;; Copyright notice skeleton
(define-skeleton fg-copyright-python
  "Insert a copyright notice."
  nil
  "\"\"\"
Copyright 2016 Fabian Glöckle
Author: Fabian Glöckle <fabian.gloeckle@saturn.uni-freiburg.de>
\"\"\"
"
)

;; CEDET Semantic: http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html
(require 'semantic/ia)
(require 'semantic/bovine/gcc)

(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-semantic)
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert))
  
(add-hook 'c-mode-common-hook 'my-cedet-hook)

(add-hook 'c-mode-common-hook 'my-c-skeletons-hook)

(defun my-c-skeletons-hook ()   
  (local-set-key  (kbd "C-c o") 'ff-find-other-file)  
  (local-set-key (kbd "C-c t") 'test-function-skeleton)
  (local-set-key (kbd "C-c f") 'for-skeleton))


;; auto-complete (http://auto-complete.org/doc/manual.html#installation)

;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(require 'auto-complete-config)
(ac-config-default)
;;(add-to-list 'ac-sources 'ac-source-filename)
;;(add-to-list 'ac-sources 'ac-source-files-in-current-dir)

(setq-default ac-sources   '(;ac-source-features
		     ;ac-source-functions
		     ac-source-yasnippet
		     ;ac-source-variables
		     ;ac-source-symbols
		     ac-source-abbrev
		     ac-source-dictionary
		     ac-source-words-in-same-mode-buffers
		     ac-source-filename
		     ac-source-files-in-current-dir))

(defun standard-ac-mode () 
  (setq ac-sources '(ac-source-features
		     ac-source-functions
		     ac-source-yasnippet
		     ac-source-variables
		     ac-source-symbols
		     ac-source-abbrev
		     ac-source-dictionary
		     ac-source-words-in-same-mode-buffers)))


  (add-hook 'c-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-c-headers)
              (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))

(define-skeleton test-function-skeleton
      "Inserts a test function."
      nil
      "TEST(" (skeleton-read "Test name: ") ", " (skeleton-read "Test function: ") ") {\n"
      "  " _  "\n"
      "}" 
)

(define-skeleton for-skeleton
  "Inserts a simple for statement."
  "Loop variable: "
  > "for (int " str " = 0; " str " < " (skeleton-read "Upper bound: ") "; " str "++) {" \n
  >  _ \n
  -2 "}")

(define-skeleton header-guard-skeleton
  "Insert a header guard."
  "Variable name: "
  "#ifndef " str \n
  "#define " str \n \n
  _ \n
  "#endif  // " str )
  
