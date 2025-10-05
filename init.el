;;; init.el --- Configuções do editor  -*- lexical-binding: t; -*-

;;; Commentary:
;; Este é um exemplo de um pacote Emacs Lisp.
;; Ele contém apenas uma função simples.

;;; Code:

;; Define pasta para backups
(setq backup-directory-alist '(("." . "~/.emacs.d/personal/backup/")))

(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs.d/personal/auto-save-list/" t)))

(unless (file-exists-p "~/.emacs.d/personal/auto-save-list/")
  (make-directory "~/.emacs.d/personal/auto-save-list/" t))
;

(setq visible-bell t)
(setq ring-bell-function 'ignore)

(prefer-coding-system 'utf-8)
(setq-default truncate-lines t)
(global-display-line-numbers-mode t)

(setq-default indent-tabs-mode nil)  ;; nunca usar TABs, só espaços
(setq-default tab-width 2)           ;; largura visual de TAB = 4
(setq-default standard-indent 2)     ;; indentação padrão = 4

(setq-default cursor-type 'box)
;; (setq-default cursor-type '(bar . 1))
(setq scroll-preserve-screen-position t)

;
(toggle-truncate-lines)

(setq-default fill-column 80)
(global-display-fill-column-indicator-mode)

(setq-default indicate-empty-lines t)
;; (define-fringe-bitmap 'tilde [0 0 0 113 219 142 0 0] nil nil 'center)
;; (setcdr (assq 'empty-line fringe-indicator-alist) 'tilde)
;; (set-fringe-bitmap-face 'tilde 'font-lock-function-name-face)

(setq package-user-dir "~/.emacs.d/site-lisp/packages") ;; Define novo diretório para pacotes

(require 'package)

;; Adiciona o MELPA ao repositório de pacotes
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Inicializa o sistema de pacotes
(package-initialize)

(use-package smartparens
  :ensure smartparens  ;; install the package
  :config
  (smartparens-global-mode t))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  ;;
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  ;;
  (exec-path-from-shell-copy-envs '("PATH" "NVM_DIR" "NODE_PATH"))
  ;;
  (getenv "PATH")
  (executable-find "node"))

(setq package-enable-at-startup nil) ;; Evita que o package.el inicialize automaticamente

;; Atualiza a lista de pacotes se ainda não estiver disponível
(unless package-archive-contents
  (package-refresh-contents))

;; Instalar um pacote (exemplo: use-package)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))


;;
(setq straight-base-dir "~/.emacs.d/site-lisp/") ;; Define o novo diretório base
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(load "~/.emacs.d/modules/language/config.el")

;; Configuração específica para GUI
(when (display-graphic-p)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (load "~/.emacs.d/modules/theme/config.el")
  (load "~/.emacs.d/modules/tools/config.el")
  (load "~/.emacs.d/personal/custom.el")
  (load "~/.emacs.d/modules/mail/config.el"))

;; Configuração específica para Terminal
(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (menu-bar-mode -1)
  (load "~/.emacs.d/modules/theme/config.el")
  (load "~/.emacs.d/modules/tools/config-term.el"))

(setq projectile-known-projects-file "~/.emacs.d/personal/projectile-bookmarks.eld")
(setq recentf-save-file "~/.emacs.d/personal/recentf")
(setq dap-breakpoints-file "~/.emacs.d/personal/.dap-breakpoints")
(setq lsp-session-file "~/.emacs.d/personal/.lsp-session-v1")


;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f1ec380515260f66ad1bcdf76563dd925a2b85f5b651997a4f34fecf019f3102"
     "a5116c017175cd68368e4c030fb889118ccb4f4480b5d0b9ffc1a53fac8d21a7" default))
 '(neo-theme 'nerd)
 '(package-selected-packages
   '(alert beacon centaur-tabs company-posframe company-quickhelp consult dap-mode
	   dashboard docker-compose-mode dockerfile-mode dotenv-mode embark
	   emmet-mode fix-word flycheck-posframe go-mode google-translate helm
	   highlight-defined highlight-numbers indent-bars js2-mode
	   kaolin-themes keycast marginalia minimap multiple-cursors neotree
	   orderless php-mode prettier prettier-js projectile rainbow-delimiters
	   rainbow-mode smartparens spaceline-all-the-icons switch-window try
	   typescript-mode undo-tree vertico wakatime-mode web-mode which-key))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight regular :height 98 :width normal))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1"))))
 '(keycast-key
   ((t (:inherit mode-line :background "#60977d" :foreground "#222225" :weight bold)))) ;;#616d42 -- current hyprland color theme
 '(keycast-command
   ((t (:inherit mode-line :foreground "#8be9fd" :weight normal))))
 '(keycast-key-release
   ((t (:inherit mode-line :foreground "#6272a4"))))
 )

;;; init.el ends here
