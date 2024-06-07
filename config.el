;; Set specific fonts for your desktop
(when (string-equal (system-name) "desktop")
  ;; Ensure the fonts are only run on new client frames
  (add-hook 'after-make-frame-functions (lambda (frame) (with-selected-frame frame
   ;; Doom theme
   (setq doom-theme 'doom-nord)
   ;; Doom font
   (setq doom-font (font-spec :family "Terminus" :size 32))
   ;; Monospace Japanese font
   (set-fontset-font t 'japanese-jisx0208 (font-spec :family "Noto Sans CJK JP" :size 46))))))
;; Set monospace Japanese font even when not running as a client/daemon
(set-fontset-font t 'japanese-jisx0208 (font-spec :family "Noto Sans CJK JP" :size 23))
;; Line Numbers
(setq display-line-numbers-type t)
;; Org Directory
(setq org-directory "~/org/")
;; Disable the Doom title
(setq-default frame-title-format '("%f"))
;; Roam Directory
(setq org-roam-directory (file-truename "~/org/roam/"))
;; Org Journal Directory
(setq org-journal-dir (file-truename "~/org/journal/"))
;; Sex org journal date
(setq org-journal-date-format "+%A - %F")
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
;; Import khalel events on close--
;; I would like call this on startup, however there's some issue with the way it
;; gets loaded and it doesn't seem to display in my agenda until a restart. 
;; This seems like an OK workaround.
(add-hook 'kill-emacs-hook 'khalel-import-events)
;; Fix tab with issue org
(setq-default tab-width 8)
;; Auto push git auto commit
(setq-default gac-automatically-push-p t)
;; Enable org autolist
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
;; pasted verbatim from org-roam-ui docs
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
;; "Flyspell with Hunspell on buffer with Japanese
;; https://www.emacswiki.org/emacs/FlySpell#h5o-15
(defvar ispell-regexp-ja "[一-龠ぁ-🈀ァ-𛀀ー・、。々]+"
  "Regular expression to match a Japanese word.
The expression can be [^\000-\377]+, [^!-~]+, or [一-龠ぁ-🈀ァ-𛀀ー・、。々]+")
;; (add-to-list 'ispell-skip-region-alist (list ispell-regexp-ja))
(defun flyspell-skip-ja (beg end info)
  "Tell flyspell to skip a Japanese word.
Call this on `flyspell-incorrect-hook'."
  (string-match ispell-regexp-ja (buffer-substring beg end)))
(add-hook 'flyspell-incorrect-hook 'flyspell-skip-ja)
;; valign hook
(add-hook 'org-mode-hook #'valign-mode)
;; gptel
(setq gptel-api-key (shell-command-to-string "bw get password d0cac8bb-14d4-4b5a-b371-b14500e2f1c5"))
(setq gptel-default-mode 'org-mode)
(setq gptel-model "gpt-4o")
;; Fix evil search
;; https://github.com/doomemacs/doomemacs/issues/6478#issuecomment-1406167570
(setq org-fold-core-style 'overlays)
(evil-select-search-module 'evil-search-module 'evil-search)
;; Cute strike-through for done org tasks
(set-face-attribute 'org-headline-done nil :strike-through t)
;; Shortcut to go back when hitting roam links
(define-key org-mode-map (kbd "C-c m") 'org-mark-ring-goto)
(define-key org-mode-map (kbd "<mouse-8>") 'org-mark-ring-goto)
;; org-roam shortcuts
(define-key global-map (kbd "C-c f") 'org-roam-node-find)
(define-key global-map (kbd "C-c i") 'org-roam-node-insert)
(define-key global-map (kbd "C-c t") 'org-roam-dailies-goto-today)
