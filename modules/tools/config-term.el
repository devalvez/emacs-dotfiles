;; Configuração do vertico
(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom (vertico-cycle t))  ; Configuração de exemplo para o vertico

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package consult
  :ensure t
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("C-x C-r" . consult-recent-file)))

;; Configuração do orderless
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (partial-completion))))))

;
(use-package highlight-numbers
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

;
(use-package highlight-defined
  :ensure t
  :init (add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode))

;
(use-package beacon
  :ensure t
  :config
  (setq beacon-color "#616d42")
  (beacon-mode -1))

;
(use-package all-the-icons
  :ensure t)

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode)
  (add-hook 'typescript-mode-hook 'flycheck-mode))

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

;
(use-package spaceline-all-the-icons
  :ensure t
  :after spaceline
  :config
  (spaceline-all-the-icons-theme)
  ;; (all-the-icons-install-fonts)
  (setq spaceline-all-the-icons-separator-type 'wave)
  (setq spaceline-all-the-icons-auto-update-p nil)
  (setq spaceline-all-the-icons-show-editor nil)
  (setq spaceline-all-the-icons-buffer-size-limit 1000000)
  ;; Enable anzu searching
  (spaceline-all-the-icons--setup-anzu)
  ;; Enable package update indicator
  (spaceline-all-the-icons--setup-package-updates)
  ;; Enable # of commits ahead of upstream in git
  (spaceline-all-the-icons--setup-git-ahead)
  ;; Enable Neotree mode line
  (spaceline-all-the-icons--setup-neotree)
  ;; Change Icons
  (setq spaceline-all-the-icons-icon-set-modified 'circle)
  (setq spaceline-all-the-icons-icon-set-bookmark 'bookmark)
  (setq spaceline-all-the-icons-icon-set-dedicated 'pin)
  (setq spaceline-all-the-icons-icon-set-window-numbering 'circle)
  (setq spaceline-all-the-icons-icon-set-window-eyebrowse-workspace 'circle)
  (setq spaceline-all-the-icons-icon-set-multiple-cursors 'caret)
  (setq spaceline-all-the-icons-icon-set-git-stats 'git-stats)
  (setq spaceline-all-the-icons-icon-set-flycheck-slim 'git-stats)
  (setq spaceline-all-the-icons-icon-set-sun-time 'sun/moon))

;
(use-package wakatime-mode
  :ensure t
  :config (global-wakatime-mode))
