;;; init-dev.el --- development related tools
;;; Commentary:
;; currently includes git, docker, and projectile

;;; Code:
(require 'init-const)

;; compilation mode
(use-package compile
  :ensure nil
  :custom
  (compilation-scroll-output t))

;; quickrun codes
(use-package quickrun
  :defer 1
  :bind (("C-c x" . quickrun))
  :custom (quickrun-focus-p nil))

;; use magit for git VC
(use-package magit
   :bind (("C-x g" . magit-status)
          ("C-x M-g" . magit-dispatch)
          ("C-c M-g" . magit-file-popup))
  :mode (("\\COMMIT_EDITMSG\\'" . text-mode)
         ("\\MERGE_MSG\\'" . text-mode))
  :config
  ;; access git forges from magit
  (use-package forge)

  ;; show TODOs in magit
  (use-package magit-todos
    :hook (magit-status-mode . magit-todos-mode)))

;; walk through git revisions of a file
(use-package git-timemachine
  :bind (:map vc-prefix-map
              ("t" . git-timemachine)))

;; git related modes
(use-package gitattributes-mode)
(use-package gitconfig-mode)
(use-package gitignore-mode)

;; project managemnt
(use-package projectile
  :diminish
  :hook (after-init . projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :bind (:map projectile-command-map
              ("." . projectile-ripgrep))
  :config
  (projectile-update-mode-line)         ; Update mode-line at the first time
  :custom
  (projectile-git-submodule-command nil)
  (projectile-completion-system 'ivy)
  (projectile-sort-order 'recentf)
  (projectile-mode-line-prefix "")
  (projectile-use-git-grep t)
  (projectile-indexing-method 'alien))

;; use ripgrep to power up search speed
(use-package ripgrep
  :defer t)

;; syntax checking
(use-package flycheck
  :diminish
  :hook (after-init . global-flycheck-mode)
  :custom
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-check-syntax-automatically '(save mode-enabled))
  (flycheck-indication-mode 'right-fringe)
  (flycheck-temp-prefix ".flycheck")
  :config
  ;; display Flycheck errors in GUI tooltips
  (if (display-graphic-p)
      (use-package flycheck-pos-tip
        :defines flycheck-pos-tip-timeout
        :hook (global-flycheck-mode . flycheck-pos-tip-mode)
        :config (setq flycheck-pos-tip-timeout 30))
    (use-package flycheck-popup-tip
      :hook (flycheck-mode . flycheck-popup-tip-mode))))

;; docker
(use-package docker :diminish)
(use-package dockerfile-mode)

(provide 'init-dev)
;;; init-dev.el ends here
