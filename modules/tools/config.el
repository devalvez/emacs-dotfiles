;;; config.el --- Um pacote de exemplo para Emacs  -*- lexical-binding: t; -*-

;;; Commentary:
;; Este é um exemplo de um pacote Emacs Lisp.
;; Ele contém apenas uma função simples.

;;; Code:
;;Configuração do vertico
(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom (vertico-cycle t))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package helm
  :ensure t
  :bind
  ("C-c C-f" . 'helm-find-files)
  ("C-x b" . 'helm-buffers-list)
  ("C-c C-d" . 'helm-browse-project))

(use-package consult
  :ensure t
  :bind (
         ;; A recursive grep
         ("M-s M-g" . consult-grep)
         ;; Search for files names recursively
         ("M-s M-f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search the current buffer
         ("M-s M-l" . consult-line)
         ;; Switch to another buffer, or bookmarked file, or recently
         ;; opened file.
         ("M-s M-b" . consult-buffer)))

(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)))

;; Configuração do orderless
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (partial-completion))))))

                                        ;
(use-package avy
  :ensure t)

                                        ;
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'foo-mode-hook #'rainbow-delimiters-mode))

                                        ;
(use-package highlight-numbers
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'highlight-numbers-mode)
  (set-face-attribute 'line-number nil :foreground "#5B6268")  ;; Cor padrão dos números
  (set-face-attribute 'line-number-current-line nil :foreground "#616d42" :weight 'bold)  ;; Cor da linha atual
  )

                                        ;
(use-package highlight-defined
  :ensure t
  :init (add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode))

                                        ;
(use-package beacon
  :ensure t
  :config
  (setq beacon-color "#616d42")
  (beacon-mode 1))

                                        ;
(use-package all-the-icons
  :ensure t)

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode)
  (add-hook 'typescript-mode-hook 'flycheck-mode))

(use-package flycheck-posframe
  :ensure t
  :after flycheck
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
  (set-face-attribute 'flycheck-posframe-info-face nil :inherit 'info)
  (set-face-attribute 'flycheck-posframe-warning-face nil :inherit 'warning)
  (set-face-attribute 'flycheck-posframe-error-face nil :inherit 'error)
  (setq flycheck-posframe-warning-prefix "\u26a0 ")
  (setq flycheck-posframe-border-width 10))

                                        ;
(use-package prettier
  :ensure t
  :config (add-hook 'after-init-hook #'global-prettier-mode))
                                        ;
(use-package hydra
  :ensure t)

                                        ;
(use-package dap-mode
  :ensure t
  :init (add-hook 'dap-stopped-hook
		              (lambda (arg) (call-interactively #'dap-hydra))))

                                        ;
(use-package file-info
  :straight (:host github :repo "artawower/file-info.el")
  :bind (("C-c d" . 'file-info-show))
  :config
  (setq hydra-hint-display-type 'posframe)
  (setq hydra-posframe-show-params `(:poshandler posframe-poshandler-frame-center
                                                 :internal-border-width 2
                                                 :internal-border-color "#61AFEF"
                                                 :left-fringe 16
                                                 :right-fringe 16)))

                                        ;
(use-package projectile
  :ensure t
  :config
  (projectile-mode 1)
  (setq projectile-sort-order 'recentf)
  (setq projectile-enable-caching t)
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (setq projectile-project-search-path '("~/Documents/projects/works/" "~/Documents/projects/personal/" ("~/Documents/projects/works/" . 1))))

                                        ;
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-style "slant")
  (setq centaur-tabs-set-bar 'under)
  (setq x-underline-at-descent-line t)
  (setq centaur-tabs-height 32)
  (setq centaur-tabs-set-icons nil)
  (setq centaur-tabs-plain-icons t)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-close-button "×")
  (setq centaur-tabs-modified-marker "⚬")
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

                                        ;
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-projects-backend 'projectile)
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-show-shortcuts t)
  (setq dashboard-banner-logo-title "·• E M A C S  ✦  D E V A L V E Z •·")
  (setq dashboard-startup-banner "~/.emacs.d/bonsai.png")

  (setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
  (setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package

  (setq dashboard-footer-icon
        (all-the-icons-octicon "squirrel"
                               :height 1.5
                               :v-adjust 0
                               :face 'font-lock-keyword-face))
  (defun dashboard-insert-custom (list-size)
    (insert "The End"))
  (add-to-list 'dashboard-item-generators  '(custom . dashboard-insert-custom))
  (add-to-list 'dashboard-items '(custom) t)
  (setq dashboard-set-navigator t)
  
  (setq dashboard-navigator-buttons
        `(;; line1
          ((,(all-the-icons-faicon "github" :height 1.1 :v-adjust 0.0)
            "Github"
            "github.com/devalvez"
            (lambda (&rest _) (browse-url "https://github.com/devalvez")))

           (,(all-the-icons-faicon "gitlab" :height 1.1 :v-adjust 0.0)
            "GitLab"
            "gitlab.com/WesleyAntonioAlves"
            (lambda (&rest _) (browse-url "https://gitlab.com/WesleyAntonioAlves")))

           (,(all-the-icons-faicon "rebel" :height 1.1 :v-adjust 0.0)
            "Devalvez Blog"
            "https://devalvez.com"
            (lambda (&rest _) (browse-url "https://devalvez.com")))

           )))
  (setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
  (setq dashboard-items '((recents   . 5)
                          (bookmarks . 5)
                          (projects  . 5)
                          (agenda    . 5)
                          (registers . 5)))
  
  (setq dashboard-startupify-list '(dashboard-insert-banner
                                    dashboard-insert-newline
                                    dashboard-insert-banner-title
                                    dashboard-insert-newline
                                    dashboard-insert-navigator
                                    dashboard-insert-newline
                                    dashboard-insert-init-info
                                    dashboard-insert-items
                                    dashboard-insert-newline
                                    dashboard-insert-footer))
  (setq dashboard-navigation-cycle t)
  (setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
  (setq dashboard-heading-shorcut-format " [%s]")
  (setq dashboard-item-shortcuts '((recents   . "r")
                                   (bookmarks . "m")
                                   (projects . "p")
                                   (agenda    . "a")
                                   (registers . "e")))
  (setq dashboard-item-names '(("Recent Files:"               . "Recent files:")
                               ("Agenda for today:"           . "Agenda for today:")
                               ("Agenda for the coming week:" . "Agenda for the coming week:")))
  (setq dashboard-icon-type 'all-the-icons))

                                        ;
(use-package company
  :ensure t
  :after eglot
  :hook (eglot-managed-mode . company-mode)
  :config
  (setq company-show-quick-access t)
  (setq company-tooltip-align-annotations t)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  ;; (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(use-package company-posframe
  :ensure t
  :config (company-posframe-mode 1))

                                        ;
(use-package company-quickhelp
  :ensure t
  :after company
  :init
  :config
  (setq company-quickhelp-idle-delay 0.1)
  (company-quickhelp-mode 1))

                                        ;
(use-package multiple-cursors
  :ensure t
  :bind (
	       ("C-S-<down>" . 'mc/mark-next-like-this)
	       ("C-S-<up>" . 'mc/mark-previous-like-this)
	       ("C-+" . 'mc/mark-all-like-this)
	       ("C-S-<mouse-1>" . 'mc/add-cursor-on-click)
	       ("C-S-<mouse-1>" . 'mc/add-cursor-on-click)))

;; Indentation Guide
(use-package indent-bars
  :ensure t
  :hook (prog-mode . indent-bars-mode) ;; Ativa para todos os modos de programação
  :custom
  (indent-bars-color '(highlight :face-bg t :blend 0.15)) ;; Cor dinâmica
  (indent-bars-pattern ".")   ;; Usa um padrão pontilhado para as barras
  (indent-bars-width-frac 0.1) ;; Largura das barras
  (indent-bars-pad-frac 0.1)  ;; Espaço entre barras
  (indent-bars-display-on-blank-lines t) ;; Mostra em linhas vazias
  (indent-bars-zigzag nil)    ;; Remove o efeito de zigzag
  (indent-bars-start-column 0) ;; Ajusta onde as barras começam
  )

                                        ;
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'foo-mode-hook #'rainbow-delimiters-mode))

                                        ;
(use-package fix-word
  :ensure t
  :bind (
         ("M-u" . 'fix-word-upcase)
         ("M-l" . 'fix-word-downcase)
         ("M-c" . 'fix-word-capitalize)))

                                        ;
(use-package undo-tree
  :ensure t
  :config (global-undo-tree-mode 1)
  :bind (
         ("C-z" . 'undo)
         ("C-S-z" . 'redo)))

(defun my-undo-tree-config ()
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/personal/undo"))))
(add-hook 'after-init-hook 'my-undo-tree-config)

                                        ;
(use-package neotree
  :ensure t
  :bind (("C-\\" . 'neotree-toggle))
  :config
  (setq neo-autorefresh nil)
  (setq neo-smart-open t))

                                        ;
(use-package switch-window
  :ensure t
  :bind (
         ("C-M-z" . 'switch-window)))

                                        ;
(use-package which-key
  :ensure t
  :config
  (progn
    (which-key-mode)
    ;; (which-key-setup-side-window-right-bottom)
    (which-key-setup-minibuffer)))

                                        ;
(use-package minimap
  :ensure t
  :config (minimap-mode 0))

                                        ;
(use-package google-translate
  :ensure t
  :bind (
	       ("\C-ct" . 'google-translate-at-point)
	       ("\C-cT" . 'google-translate-query-translate))
  :config (defun google-translate--search-tkk () "Search TKK." (list 430675 2721866130)))

                                        ;
(use-package screenshot
  :straight (:type git :host github :repo "tecosaur/screenshot")
  :config 
  (setq screenshot-line-numbers-p nil)
  
  (setq screenshot-min-width 80)
  (setq screenshot-max-width 90)
  (setq screenshot-truncate-lines-p nil)
  ;;
  (setq screenshot-text-only-p nil)
  ;;
  (setq screenshot-font-family "JetBrains Mono")
  (setq screenshot-font-size 10)
  ;;
  (setq screenshot-border-width 16)
  (setq screenshot-radius 10)
  ;;
  (setq screenshot-shadow-intensity 90)
  (setq screenshot-shadow-radius 8)
  (setq screenshot-shadow-offset-horizontal 1)
  (setq screenshot-shadow-offset-vertical 4)
  :hook((screenshot-buffer-creation-hook . g-screenshot-on-buffer-creation)))

;; show preview color
(use-package rainbow-mode
  :ensure t)

                                        ;
(use-package spaceline
  :ensure t)
(use-package spaceline-all-the-icons
  :ensure t
  :if (featurep 'spaceline) ;; Garante que spaceline está carregado antes
  :config
  (spaceline-all-the-icons-theme)
  (spaceline-all-the-icons-theme 'your-segment-symbol "Devalvez" 'etc)
  ;; Se os ícones não aparecerem corretamente, instale as fontes:
  ;; (all-the-icons-install-fonts)

  (setq spaceline-all-the-icons-separator-type 'slant)
  (setq spaceline-all-the-icons-auto-update-p nil)

  ;; Verifique se esta variável realmente existe antes de usá-la
  ;; (setq spaceline-all-the-icons-show-editor nil)

  (setq spaceline-all-the-icons-buffer-size-limit 1000000))

;
(use-package keycast
  :ensure t
  :bind ("C-c C-t C-k" . +toggle-keycast)
  :config
  (defun +toggle-keycast()
    (interactive)
    (if (member '("" keycast-mode-line " ") global-mode-string)
        (progn (setq global-mode-string (delete '("" keycast-mode-line " ") global-mode-string))
               (remove-hook 'pre-command-hook 'keycast--update)
               (message "Keycast OFF"))
      (add-to-list 'global-mode-string '("" keycast-mode-line " "))
      (add-hook 'pre-command-hook 'keycast--update t)
      (message "Keycast ON"))))
(+toggle-keycast)

(defun turn-on-keycast ()
  (add-to-list 'global-mode-string '(" " mode-line-keycast " ")))

(defun turn-off-keycast ()
  (setq global-mode-string (delete '(" " mode-line-keycast " ") global-mode-string)))


;
(use-package try
  :ensure t)

;
(use-package alert
  :ensure t
  :config
  (setq alert-default-style 'notifications)
  (setq alert-user-configuration-alist
        '(("Emacs startup" . (style . os)))
        ))


;
(use-package wakatime-mode
  :ensure t
  :config (global-wakatime-mode))

;;; config.el ends here
