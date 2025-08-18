;;; config.el --- Inicia os principais packages  -*- lexical-binding: t; -*-

;;; Commentary:
;; Este é um exemplo de um pacote Emacs Lisp.
;; Ele contém apenas uma função simples.

;;; Code:
;;Configuração do vertico-cycle

(use-package company
  :ensure t
  :config
  (setq company-backends '((company-capf company-files)))
  (global-company-mode)
  :hook (after-init . global-company-mode)
  :custom
  (company-idle-delay 0.2)
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  (company-selection-wrap-around t)
  (company-show-numbers t)
  (company-dabbrev-downcase nil))

(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom (vertico-cycle t))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

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
  (completion-styles '(orderless))
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
  (beacon-mode 0))

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
  (setq projectile-project-search-path '(("~/Documents/projects/works/" . 1)
                                         "~/Documents/projects/personal/"))
  )

;
(use-package centaur-tabs
  :ensure t
  :demand
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-bar 'left)
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


(use-package embark-consult
  :ensure t
  :after (embark consult))

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
  :init (which-key-mode)
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

;; (use-package doom-modeline
;;   :ensure t
;;   :init
;;   (doom-modeline-mode 1)
;;   :custom
;;   ;; If non-nil, cause imenu to see `doom-modeline' declarations.
;; ;; This is done by adjusting `lisp-imenu-generic-expression' to
;; ;; include support for finding `doom-modeline-def-*' forms.
;; ;; Must be set before loading doom-modeline.
;; (setq doom-modeline-support-imenu t)

;; ;; How tall the mode-line should be. It's only respected in GUI.
;; ;; If the actual char height is larger, it respects the actual height.
;; (setq doom-modeline-height 25)

;; ;; How wide the mode-line bar should be. It's only respected in GUI.
;; (setq doom-modeline-bar-width 4)

;; ;; Whether to use hud instead of default bar. It's only respected in GUI.
;; (setq doom-modeline-hud nil)

;; ;; The limit of the window width.
;; ;; If `window-width' is smaller than the limit, some information won't be
;; ;; displayed. It can be an integer or a float number. `nil' means no limit."
;; (setq doom-modeline-window-width-limit 85)

;; ;; Override attributes of the face used for padding.
;; ;; If the space character is very thin in the modeline, for example if a
;; ;; variable pitch font is used there, then segments may appear unusually close.
;; ;; To use the space character from the `fixed-pitch' font family instead, set
;; ;; this variable to `(list :family (face-attribute 'fixed-pitch :family))'.
;; (setq doom-modeline-spc-face-overrides nil)

;; ;; How to detect the project root.
;; ;; nil means to use `default-directory'.
;; ;; The project management packages have some issues on detecting project root.
;; ;; e.g. `projectile' doesn't handle symlink folders well, while `project' is unable
;; ;; to hanle sub-projects.
;; ;; You can specify one if you encounter the issue.
;; (setq doom-modeline-project-detection 'auto)

;; ;; Determines the style used by `doom-modeline-buffer-file-name'.
;; ;;
;; ;; Given ~/Projects/FOSS/emacs/lisp/comint.el
;; ;;   auto => emacs/l/comint.el (in a project) or comint.el
;; ;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
;; ;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
;; ;;   truncate-with-project => emacs/l/comint.el
;; ;;   truncate-except-project => ~/P/F/emacs/l/comint.el
;; ;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
;; ;;   truncate-all => ~/P/F/e/l/comint.el
;; ;;   truncate-nil => ~/Projects/FOSS/emacs/lisp/comint.el
;; ;;   relative-from-project => emacs/lisp/comint.el
;; ;;   relative-to-project => lisp/comint.el
;; ;;   file-name => comint.el
;; ;;   file-name-with-project => FOSS|comint.el
;; ;;   buffer-name => comint.el<2> (uniquify buffer name)
;; ;;
;; ;; If you are experiencing the laggy issue, especially while editing remote files
;; ;; with tramp, please try `file-name' style.
;; ;; Please refer to https://github.com/bbatsov/projectile/issues/657.
;; (setq doom-modeline-buffer-file-name-style 'auto)

;; ;; Whether display icons in the mode-line.
;; ;; While using the server mode in GUI, should set the value explicitly.
;; (setq doom-modeline-icon t)

;; ;; Whether display the icon for `major-mode'. It respects option `doom-modeline-icon'.
;; (setq doom-modeline-major-mode-icon t)

;; ;; Whether display the colorful icon for `major-mode'.
;; ;; It respects `nerd-icons-color-icons'.
;; (setq doom-modeline-major-mode-color-icon t)

;; ;; Whether display the icon for the buffer state. It respects option `doom-modeline-icon'.
;; (setq doom-modeline-buffer-state-icon t)

;; ;; Whether display the modification icon for the buffer.
;; ;; It respects option `doom-modeline-icon' and option `doom-modeline-buffer-state-icon'.
;; (setq doom-modeline-buffer-modification-icon t)

;; ;; Whether display the lsp icon. It respects option `doom-modeline-icon'.
;; (setq doom-modeline-lsp-icon t)

;; ;; Whether display the time icon. It respects option `doom-modeline-icon'.
;; (setq doom-modeline-time-icon t)

;; ;; Whether display the live icons of time.
;; ;; It respects option `doom-modeline-icon' and option `doom-modeline-time-icon'.
;; (setq doom-modeline-time-live-icon t)

;; ;; Whether to use an analogue clock svg as the live time icon.
;; ;; It respects options `doom-modeline-icon', `doom-modeline-time-icon', and `doom-modeline-time-live-icon'.
;; (setq doom-modeline-time-analogue-clock t)

;; ;; The scaling factor used when drawing the analogue clock.
;; (setq doom-modeline-time-clock-size 0.7)

;; ;; Whether to use unicode as a fallback (instead of ASCII) when not using icons.
;; (setq doom-modeline-unicode-fallback nil)

;; ;; Whether display the buffer name.
;; (setq doom-modeline-buffer-name t)

;; ;; Whether highlight the modified buffer name.
;; (setq doom-modeline-highlight-modified-buffer-name t)

;; ;; When non-nil, mode line displays column numbers zero-based.
;; ;; See `column-number-indicator-zero-based'.
;; (setq doom-modeline-column-zero-based t)

;; ;; Specification of \"percentage offset\" of window through buffer.
;; ;; See `mode-line-percent-position'.
;; (setq doom-modeline-percent-position '(-3 "%p"))

;; ;; Format used to display line numbers in the mode line.
;; ;; See `mode-line-position-line-format'.
;; (setq doom-modeline-position-line-format '("L%l"))

;; ;; Format used to display column numbers in the mode line.
;; ;; See `mode-line-position-column-format'.
;; (setq doom-modeline-position-column-format '("C%c"))

;; ;; Format used to display combined line/column numbers in the mode line. See `mode-line-position-column-line-format'.
;; (setq doom-modeline-position-column-line-format '("%l:%c"))

;; ;; Whether display the minor modes in the mode-line.
;; (setq doom-modeline-minor-modes nil)

;; ;; If non-nil, a word count will be added to the selection-info modeline segment.
;; (setq doom-modeline-enable-word-count nil)

;; ;; Major modes in which to display word count continuously.
;; ;; Also applies to any derived modes. Respects `doom-modeline-enable-word-count'.
;; ;; If it brings the sluggish issue, disable `doom-modeline-enable-word-count' or
;; ;; remove the modes from `doom-modeline-continuous-word-count-modes'.
;; (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))

;; ;; Whether display the buffer encoding.
;; (setq doom-modeline-buffer-encoding t)

;; ;; Whether display the indentation information.
;; (setq doom-modeline-indent-info nil)

;; ;; Whether display the total line number。
;; (setq doom-modeline-total-line-number nil)

;; ;; Whether display the icon of vcs segment. It respects option `doom-modeline-icon'."
;; (setq doom-modeline-vcs-icon t)

;; ;; The maximum displayed length of the branch name of version control.
;; (setq doom-modeline-vcs-max-length 15)

;; ;; The function to display the branch name.
;; (setq doom-modeline-vcs-display-function #'doom-modeline-vcs-name)

;; ;; Alist mapping VCS states to their corresponding faces.
;; ;; See `vc-state' for possible values of the state.
;; ;; For states not explicitly listed, the `doom-modeline-vcs-default' face is used.
;; (setq doom-modeline-vcs-state-faces-alist
;;       '((needs-update . (doom-modeline-warning bold))
;;         (removed . (doom-modeline-urgent bold))
;;         (conflict . (doom-modeline-urgent bold))
;;         (unregistered . (doom-modeline-urgent bold))))

;; ;; Whether display the icon of check segment. It respects option `doom-modeline-icon'.
;; (setq doom-modeline-check-icon t)

;; ;; If non-nil, only display one number for check information if applicable.
;; (setq doom-modeline-check-simple-format nil)

;; ;; The maximum number displayed for notifications.
;; (setq doom-modeline-number-limit 99)

;; ;; Whether display the project name. Non-nil to display in the mode-line.
;; (setq doom-modeline-project-name t)

;; ;; Whether display the workspace name. Non-nil to display in the mode-line.
;; (setq doom-modeline-workspace-name t)

;; ;; Whether display the perspective name. Non-nil to display in the mode-line.
;; (setq doom-modeline-persp-name t)

;; ;; If non nil the default perspective name is displayed in the mode-line.
;; (setq doom-modeline-display-default-persp-name nil)

;; ;; If non nil the perspective name is displayed alongside a folder icon.
;; (setq doom-modeline-persp-icon t)

;; ;; Whether display the `lsp' state. Non-nil to display in the mode-line.
;; (setq doom-modeline-lsp t)

;; ;; Whether display the GitHub notifications. It requires `ghub' package.
;; (setq doom-modeline-github nil)

;; ;; The interval of checking GitHub.
;; (setq doom-modeline-github-interval (* 30 60))

;; ;; Whether display the modal state.
;; ;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
;; (setq doom-modeline-modal t)

;; ;; Whether display the modal state icon.
;; ;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
;; (setq doom-modeline-modal-icon t)

;; ;; Whether display the modern icons for modals.
;; (setq doom-modeline-modal-modern-icon t)

;; ;; When non-nil, always show the register name when recording an evil macro.
;; (setq doom-modeline-always-show-macro-register nil)

;; ;; Whether display the gnus notifications.
;; (setq doom-modeline-gnus t)

;; ;; Whether gnus should automatically be updated and how often (set to 0 or smaller than 0 to disable)
;; (setq doom-modeline-gnus-timer 2)

;; ;; Wheter groups should be excludede when gnus automatically being updated.
;; (setq doom-modeline-gnus-excluded-groups '("dummy.group"))

;; ;; Whether display the IRC notifications. It requires `circe' or `erc' package.
;; (setq doom-modeline-irc t)

;; ;; Function to stylize the irc buffer names.
;; (setq doom-modeline-irc-stylize 'identity)

;; ;; Whether display the battery status. It respects `display-battery-mode'.
;; (setq doom-modeline-battery t)

;; ;; Whether display the time. It respects `display-time-mode'.
;; (setq doom-modeline-time t)

;; ;; Whether display the misc segment on all mode lines.
;; ;; If nil, display only if the mode line is active.
;; (setq doom-modeline-display-misc-in-all-mode-lines t)

;; ;; The function to handle `buffer-file-name'.
;; (setq doom-modeline-buffer-file-name-function #'identity)

;; ;; The function to handle `buffer-file-truename'.
;; (setq doom-modeline-buffer-file-truename-function #'identity)

;; ;; Whether display the environment version.
;; (setq doom-modeline-env-version t)
;; ;; Or for individual languages
;; (setq doom-modeline-env-enable-python t)
;; (setq doom-modeline-env-enable-ruby t)
;; (setq doom-modeline-env-enable-perl t)
;; (setq doom-modeline-env-enable-go t)
;; (setq doom-modeline-env-enable-elixir t)
;; (setq doom-modeline-env-enable-rust t)

;; ;; Change the executables to use for the language version string
;; (setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
;; (setq doom-modeline-env-ruby-executable "ruby")
;; (setq doom-modeline-env-perl-executable "perl")
;; (setq doom-modeline-env-go-executable "go")
;; (setq doom-modeline-env-elixir-executable "iex")
;; (setq doom-modeline-env-rust-executable "rustc")

;; ;; What to display as the version while a new one is being loaded
;; (setq doom-modeline-env-load-string "...")

;; ;; By default, almost all segments are displayed only in the active window. To
;; ;; display such segments in all windows, specify e.g.
;; ;; (setq doom-modeline-always-visible-segments '(mu4e irc))

;; ;; Hooks that run before/after the modeline version string is updated
;; (setq doom-modeline-before-update-env-hook nil)
;; (setq doom-modeline-after-update-env-hook nil)
;; ;;
;; )

;; (use-package doom-themes
;;   :ensure t
;;   :custom
;;   ;; Global settings (defaults)
;;   (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
;;   (doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   ;; for treemacs users
;;   (doom-themes-treemacs-theme "doom-moonlight") ; use "doom-colors" for less minimal icon theme
;;   :config
;;   (load-theme 'doom-moonlight t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (nerd-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

;
(use-package spaceline
  :ensure t)
(use-package spaceline-all-the-icons
  :ensure t
  :if (featurep 'spaceline) ;; Garante que spaceline está carregado antes
  :config
  (spaceline-all-the-icons-theme)
  (spaceline-all-the-icons-theme 'your-segment-symbol "Ig: @devalvez" 'etc)
  (spaceline-all-the-icons--debug-segments)
  (spaceline-all-the-icons-toggle-slim)
  (spaceline-toggle-all-the-icons-bookmark-on)
  (spaceline-toggle-all-the-icons-buffer-position)
  (setq spaceline-all-the-icons-icon-set-modified 'toggle)
  ;; Se os ícones não aparecerem corretamente, instale as fontes:
  ;; (all-the-icons-install-fonts)
  (setq spaceline-all-the-icons-separator-type 'slant)
  (setq spaceline-all-the-icons-auto-update-p nil)
  ;; Verifique se esta variável realmente existe antes de usá-la
  ;; (setq spaceline-all-the-icons-show-editor nil)
  (setq spaceline-all-the-icons-buffer-size-limit 100000))


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
      (add-hook 'pre-command-hook 'keycast--update t)      (message "Keycast ON"))))

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

(use-package ligature
  :ensure t
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))


(use-package blamer
  :ensure t
  :bind (("C-s-i" . blamer-show-commit-info))
  :hook (prog-mode . blamer-mode) ;; Ativa automaticamente em modos de programação
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  (blamer-author-formatter " ✦ %s ")
  (blamer-datetime-formatter "[%s]")
  (blamer-commit-formatter " • %s")
  (blamer-prettify-time t)
  (blamer-tooltip-width 120) ;; Define a largura máxima da tooltip
  (blamer-tooltip-min-width 60) ;; Define a largura mínima da tooltip
  (blamer-tooltip-positions '(right)) ;; Deve ser uma lista
  (blamer-tooltip-border-width 2) ;; Ajusta a borda da tooltip
  (blamer-tooltip-border-color "gray") ;; Define a cor da borda
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                   :background nil
                   :height 92
                   :italic t)))
  :config
  (global-blamer-mode 1))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))


(use-package demap
  :ensure t
  :config
  (setq demap-minimap-window-side  'right)
  (setq demap-minimap-window-width 20)
  :bind ("C-c C-m" . demap-toggle))

(use-package auto-rename-tag
  :ensure t
  :config (auto-rename-tag-mode t))

(load-file "~/.emacs.d/modules/tools/init-utils.el")
;;; config.el ends here
