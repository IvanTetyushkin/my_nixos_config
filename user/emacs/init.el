(require 'use-package)
(use-package emacs
  :defer
  t
  :config
  ;; Org mode scratch buffers
  (setq initial-major-mode 'org-mode)

  ;; No startup screen
  (setq inhibit-startup-message t)

  ;; Truncate lines is annoying
  (setq truncate-lines nil)
  (setq truncate-partial-width-windows nil)

  ;; I want declarative config, no custom
  (setq custom-file "/dev/null")

  ;; Auto save errors are annoying
  (setq auto-save-default nil)
  
  ;; Disable the menu bar
  (menu-bar-mode -1)
  
  ;; Disable visible scrollbar
  (scroll-bar-mode -1)
  
  ;; Disable the toolbar
  (tool-bar-mode -1)
  
  ;; Disable tooltips
  (tooltip-mode -1)
  ;; No blinking
  (blink-cursor-mode 0)

  ; M-x recentf-open-file
  (recentf-mode 1)

  ; minibuffer history
  (savehist-mode 1)
  (setq history-length 25)

  ; eval-region
  (global-auto-revert-mode 1)
  (setq global-auto-revert-non-file-buffers t)

  ; backup files in one place
  (setq backup-directory-alist `(("." . "~/.backups")))
  (setq backup-by-copying t)
  (setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2)
  
  ;; org mode partial
  (setq org-attach-use-inheritance 1)
  (setq org-agenda-files '("~/Notes"))
  (setq org-link-frame-setup '((file . find-file)))
  ;; Highlight current line
)
(use-package doom-themes
  :init
  (load-theme 'doom-one :no-confirm))

(use-package eat
  :custom
  (eat-kill-buffer-on-exit 1))

; TODO: eat command hotkey

(advice-add 'project-shell :override 'eat-project)
(setq project-switch-use-entire-map t)

; full screen by default
(add-to-list 'default-frame-alist '(fullscreen . fullscreen))

(add-hook 'dired-mode-hook 'auto-revert-mode)

(require 'cc-mode)
(require 'cmake-mode)
(require 'nix-mode)

; pdf integration
(require 'pdf-tools)

(use-package pdf-tools
  :ensure
  t
  :config
  (pdf-tools-install)
  (add-hook 'pdf-view-mode-hook #'pdf-view-roll-minor-mode)
  ;; Set pdf-tools as default viewer for PDFs
  (setq-default pdf-view-display-size 'fit-width)
  ;; Automatically activate annotations on highlight
  (setq pdf-annot-activate-created-annotations t)
  ;; Enable normal isearch (C-s) in PDF view
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (define-key pdf-view-mode-map (kbd "o") 'pdf-outline)
  ;; Optional: disable linum-mode in PDF view to avoid conflicts
  ;(add-hook 'pdf-view-mode-hook (lambda () (linum-mode -1)))
  ;; Configure AUCTeX to use pdf-tools (if using LaTeX)
;  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
;        TeX-view-program-list '((PDF Tools TeX-pdf-tools-sync-view))
;        TeX-source-correlate-start-server t)
;  ;; Refresh buffer after compilation
;  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
  )



(require 'saveplace-pdf-view)
(save-place-mode 1)

(use-package org-roam
  :ensure
  t
  :config
  (defvar org-roam-places
    `(,"~/Notes"
      ,"~/ClosedNotes"
    )
  )
  (defun my_get_db_file (roam_dir)
  "Get db associated with roam dir"
  (concat roam_dir "/org-roam.db"))

  (defun my-org-roam-switch ()
    (interactive)
    (let ((current_roam org-roam-directory)
	(selected_roam
	 (completing-read "Choose storage: " org-roam-places nil t )))
      (when selected_roam
	 (setq org-roam-directory selected_roam)
	 (setq org-roam-db-location (my_get_db_file selected_roam))
	)
	(when (not (eq current_roam org-roam-directory))
	  (org-roam-db-sync)
	  (org-roam-node-find)
	  )
	))

  (setq org-roam-mode-sections
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            ;;#'org-roam-unlinked-references-section
            ))
  ; by default get first element
  (defvar default_roam_dir (nth 0 org-roam-places))
  (setq org-roam-directory default_roam_dir)
  (setq org-roam-db-location (my_get_db_file default_roam_dir))
  (org-roam-setup)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
	 ("C-c n s" . my-org-roam-switch))
  )
(use-package org-roam-ui
  :after
  org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t)
  )

(use-package gt :ensure
  t
  :config
  (setq gt-langs '(en ru en))
  (setq gt-default-translator
	(gt-translator
         :taker (gt-taker :langs '(en ru) :text 'word :prompt t)
         :engines (gt-google-engine)
         :render (gt-buffer-render)))
  )

(use-package org-noter :ensure
  t
  :config
  (setq org-noter-auto-save-last-location t)
  (setq org-noter-hide-other nil)
  (org-noter-enable-org-roam-integration)
)


(use-package gptel
  :ensure
  t
  :config
  (setq gptel-default-mode 'org-mode)
  (setq gptel-log-level 'debug)
  (setq
   gptel-model 'granite4:350m
   gptel-backend (gptel-make-ollama "Ollama"
                 :host "localhost:11434"
                 :stream t
                 :models '(granite4:350m
			   qwen3-coder-next:cloud
			   qwen3-next:80b-cloud
			   deepseek-v3.2:cloud
			   )))
  )

(use-package tree-sitter-langs
  :after
  tree-sitter
  :custom (global-tree-sitter-mode t))

(use-package treesit-auto
  :config
  (global-treesit-auto-mode)
  (treesit-auto-add-to-auto-mode-alist 'all)
  )
(use-package magit
  :ensure
  t
  )

(use-package tmr
  :ensure
  t
  :config
  (define-key global-map (kbd "C-c t") #'tmr-prefix-map)
  (setq tmr-sound-file nil
        tmr-notification-urgency 'low
        tmr-description-list 'tmr-description-history)
  (define-globalized-minor-mode my-tmr-global-mode tmr-mode-line-mode
  (lambda () (tmr-mode-line-mode 1)))
  (my-tmr-global-mode 1)
  )
