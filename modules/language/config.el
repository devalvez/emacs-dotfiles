(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((typescript-mode js2-mode web-mode go-mode php-mode) . lsp)
  :init (setq lsp-keymap-prefix "C-c l"))

;; Flycheck
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))  ; Habilita o flycheck globalmente

;; TypeScript
(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp)
  :hook (typescript-mode . flycheck-mode))  ; Ativa o flycheck para TypeScript

;; JavaScript
(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :hook (js2-mode . lsp)
  :hook (js2-mode . flycheck-mode))  ; Ativa o flycheck para JavaScript

;; React (JSX/TSX)
(use-package web-mode
  :ensure t
  :mode ("\\.tsx\\'" "\\.jsx\\'")
  :hook (web-mode . lsp)
  :hook (web-mode . flycheck-mode))  ; Ativa o flycheck para JSX/TSX

;; HTML e CSS
(use-package web-mode
  :ensure t
  :mode ("\\.html?\\'" "\\.css\\'")
  :hook (web-mode . lsp)
  :hook (web-mode . flycheck-mode))  ; Ativa o flycheck para HTML/CSS

;; Emmet Mode
(use-package emmet-mode
  :ensure t
  :hook (web-mode css-mode))

;; Dotenv
(use-package dotenv-mode
  :ensure t
  :mode "\\.env\\'")

;; Go
(use-package go-mode
  :ensure t
  :hook (go-mode . lsp)
  :hook (go-mode . flycheck-mode)  ; Ativa o flycheck para Go
  :config
  (setq gofmt-command "gofmt")
  (add-hook 'before-save-hook 'gofmt-before-save))

;; PHP
(use-package php-mode
  :ensure t
  :mode "\\.php\\'"
  :hook (php-mode . lsp)
  :hook (php-mode . flycheck-mode))  ; Ativa o flycheck para PHP

;; Markdown
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :hook (markdown-mode . visual-line-mode)
  :hook (markdown-mode . flycheck-mode))  ; Ativa o flycheck para Markdown

(use-package docker-compose-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

;; Prisma
(add-to-list 'load-path "~/.emacs.d/site-lisp/repos/prisma-mode")
(add-to-list 'auto-mode-alist '("\\.prisma\\'" . prisma-mode))
(add-hook 'prisma-mode-hook #'lsp)
(add-hook 'prisma-mode-hook #'flycheck-mode)

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(use-package prettier-js
  :ensure t
  :hook ((js2-mode typescript-mode web-mode) . prettier-js-mode))
