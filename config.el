;; Doom theme
(setq doom-theme 'doom-badger)
;; Doom font
(setq doom-font (font-spec :family "Terminus" :size 14))
;; Line Numbers
(setq display-line-numbers-type t)
;; Org Directory
(setq org-directory "~/org/")
;; Disable the Doom title
(setq-default frame-title-format '("%f"))
;; Roam Directory
(setq org-roam-directory (file-truename "~/org/roam/"))
;; Autosync Roam
(org-roam-db-autosync-mode)
;; Prevent code blocks from evaluating
(setq org-confirm-babel-evaluate t)
;; Khal Configuration
(use-package! khalel
  :after org
  :config
  (khalel-add-capture-template))
(setq khalel-khal-command "khal")
(setq khalel-vdirsyncer-command "vdirsyncer")
(setq khalel-import-org-file-confirm-overwrite nil)
;; *recursively* crawl through all org files for agenda
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
;; start org-agenda on start
(add-hook 'after-init-hook 'org-agenda-list)
;; Shellcheck
(add-hook 'sh-mode-hook 'flymake-shellcheck-load)
;; Fix tab with issue org
(setq-default tab-width 8)
