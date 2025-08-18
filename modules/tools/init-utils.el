;;; init-utils.el --- inicializador de utils functions  -*- lexical-binding: t; -*-

;;;Commentary:

;; function utils

;;;Code:

;; Keycast
(+toggle-keycast)
(defun turn-on-keycast ()
  (add-to-list 'global-mode-string '(" " mode-line-keycast " ")))

(defun turn-off-keycast ()
  (setq global-mode-string (delete '(" " mode-line-keycast " ") global-mode-string)))




;;Blamer tooltip
(defun my-blamer-tooltip-func (commit-info)
  "Format the tooltip for Blamer using commit information."
  (let ((commit-date (plist-get commit-info :commit-date))
        (commit-time (plist-get commit-info :commit-time))
        (author (plist-get commit-info :author))
        (avatar (or (plist-get commit-info :author-avatar) "No avatar"))) ;; Usa a chave correta para o avatar
    (message "Commit Info: %S" commit-info) ;; Exibe informações no buffer *Messages* para depuração
    (format "%s - %s\n%s\n%s" commit-date commit-time author avatar)))

(setq blamer-tooltip-function #'my-blamer-tooltip-func
      blamer-show-avatar t)

;;; init-utils.el ends here
