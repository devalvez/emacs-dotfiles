;;; lsp-mode
(use-package lsp-mode
  :ensure t
  :hook ((typescript-mode . lsp)
         (js-mode . lsp)
         (web-mode . lsp)
         (html-mode . lsp)
         (css-mode . lsp)
         (go-mode . lsp))
  :commands lsp
  :custom
  (lsp-enable-snippet t)
  (lsp-completion-provider :capf))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :custom
  (lsp-ui-sideline-enable t)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-delay 0.5)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-show-code-actions t)
  :hook (lsp-mode . lsp-ui-mode))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;;; Flycheck global
(use-package flycheck
  :ensure t
  :defer t
  :init (global-flycheck-mode))

;;; TypeScript / JavaScript / JSX / TSX
(use-package typescript-mode
  :ensure t
  :defer t
  :mode "\\.ts\\'"
  :hook ((typescript-mode . flycheck-mode)))

(use-package js2-mode
  :ensure t
  :defer t
  :mode "\\.js\\'"
  :hook ((js2-mode . flycheck-mode)))

(use-package web-mode
  :ensure t
  :defer t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :hook ((web-mode . flycheck-mode)))

;;; Emmet para HTML/CSS/JSX
(use-package emmet-mode
  :ensure t
  :defer t
  :hook ((web-mode css-mode)))

;;; Dotenv
(use-package dotenv-mode
  :ensure t
  :mode "\\.env\\'")

;;; Go
(use-package go-mode
  :ensure t
  :defer t
  :mode "\\.go\\'"
  :hook ((go-mode . flycheck-mode))
  :config
  (setq gofmt-command "gofmt")
  (add-hook 'before-save-hook #'gofmt-before-save))

;;; PHP
(use-package php-mode
  :ensure t
  :defer t
  :mode "\\.php\\'"
  :hook ((php-mode . flycheck-mode)))

;;; Markdown
(use-package markdown-mode
  :ensure t
  :defer t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode))
  :hook ((markdown-mode . visual-line-mode)
         (markdown-mode . flycheck-mode)))

;;; Docker
(use-package docker-compose-mode :ensure t :defer t)
(use-package dockerfile-mode     :ensure t :defer t)

;;; Prisma
(add-to-list 'load-path "~/.emacs.d/site-lisp/repos/prisma-mode")
(add-to-list 'auto-mode-alist '("\\.prisma\\'" . prisma-mode))
(autoload 'prisma-mode "prisma-mode" nil t)
;; (add-hook 'prisma-mode-hook #'lsp)
;; (add-hook 'prisma-mode-hook #'flycheck-mode)

;;; Company mode
(use-package company
  :ensure t
  :defer t
  :hook (after-init . global-company-mode))

;;; Prettier
(use-package prettier-js
  :ensure t
  :defer t
  :hook ((js2-mode typescript-mode web-mode) . prettier-js-mode))
