(require 'flycheck)
(setq flycheck-highlight-mode 'lines)
(add-hook 'after-init-hook #'global-flycheck-mode)

(defun komitee/flycheck-hook ()
  (if (eq (length flycheck-current-errors) 0)
    (if (get-buffer flycheck-error-list-buffer)
        (delete-windows-on flycheck-error-list-buffer))
      (flycheck-list-errors)))
(add-hook 'flycheck-after-syntax-check-hook 'komitee/flycheck-hook)