;; Doom theme
(setq doom-theme 'deeper-blue)
;; Line Numbers
(setq display-line-numbers-type t)
;; Org Directory
(setq org-directory "~/org/")
;; Disable the Doom title
(setq-default frame-title-format '("%f"))
;; Roam Directory
(setq org-roam-directory (file-truename "~/roam/"))
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
;; I believe this prevents a khalel import prompt
(setq safe-local-variable-values
   (quote
    ((buffer-read-only . 1))))
;; crawl through all org files for agenda
(with-eval-after-load 'org-agenda
  (setq org-agenda-files '("~/org")))
;; start org-agenda on start
(add-hook 'after-init-hook 'org-agenda-list)
;; Shellcheck
(add-hook 'sh-mode-hook 'flymake-shellcheck-load)
;; Fix tab with issue org
(setq-default tab-width 8)
;; Make org attach directory relative to folder
(defun relative-org-attach-dir ()
  (concat (file-name-directory (buffer-file-name)) ".attach/"))
(advice-add 'org-attach-attach :before
            (lambda (&rest args)
              (setq-local org-attach-directory (relative-org-attach-dir))))
