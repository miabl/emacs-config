(setq user-full-name "Mia B")

(defun my/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (pcase appearance
    ('light (load-theme 'doom-catppuccin-latte t))
    ('dark (load-theme 'doom-catppuccin-mocha t))))

(add-hook 'ns-system-appearance-change-functions #'my/apply-theme)

(setq doom-font (font-spec :family "Roboto Mono" :weight 'semi-light :size 14)
      doom-big-font (font-spec :family "Roboto Mono" :weight 'semi-light :size 14)
      doom-unicode-font (font-spec :family "Roboto Mono" :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 16)
      doom-serif-font (font-spec :family "IBM Plex Mono")
 )

(setq display-line-numbers-type 'relative)            ; Relative line numbers

(setq-default fill-column 80                          ; Default line width
              sentence-end-double-space nil           ; Use a single space after dots
              truncate-string-ellipsis "…")           ; Nicer ellipsis

(display-time-mode 1)
(unless (string-match-p "^Power N/A" (battery))   ; On laptops...
  (display-battery-mode 1))

(setq fancy-splash-image "~/.doom.d/images/catppuccin.png")

(custom-set-faces!
  '(bold  :weight normal))

(setenv "PATH" (concat ":/Library/TeX/texbin/:texlive/2022/bin/" (getenv "PATH")))
(add-to-list 'exec-path "/Library/TeX/texbin/")
(add-to-list 'exec-path "texlive/2022/bin/")

(setq undo-limit 10000
      evil-want-fine-undo t)

(setq-default org-ellipsis " …"              ; Nicer ellipsis
              org-tags-column 1              ; Tags next to header title
              org-hide-emphasis-markers t    ; Hide markers
              org-cycle-separator-lines 2    ; Number of empty lines between sections
              org-use-property-inheritance t ; Properties ARE inherited
              org-indent-indentation-per-level 2 ; Indentation per level
              org-link-use-indirect-buffer-for-internals t ; Indirect buffer for internal links
              org-fontify-quote-and-verse-blocks t ; Specific face for quote and verse blocks
              org-return-follows-link nil    ; Follow links when hitting return
              org-outline-path-complete-in-steps nil) ; No steps in path display

(setq org-roam-directory (file-truename "~/Documents/org/roam"))
(org-roam-db-autosync-mode)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))

(setq org-preview-latex-default-process 'dvisvgm)

(setq org-format-latex-options
      (plist-put org-format-latex-options :background "Transparent"))

(setq org-agenda-sorting-strategy
      '((agenda deadline-down scheduled-down todo-state-up time-up
                habit-down priority-down category-keep)
        (todo   priority-down category-keep)
        (tags   timestamp-up priority-down category-keep)
        (search category-keep)))

(setq org-directory "~/Documents/org/tasks/")

(require 'svg-lib)
(require 'svg-tag-mode)

(defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
(defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
(defconst day-re "[A-Za-z]\\{3\\}")
(defconst day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re))

(defun svg-progress-percent (value)
  (svg-image (svg-lib-concat
              (svg-lib-progress-bar (/ (string-to-number value) 100.0)
                                nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
              (svg-lib-tag (concat value "%")
                           nil :stroke 0 :margin 0)) :ascent 'center))

(defun svg-progress-count (value)
  (let* ((seq (mapcar #'string-to-number (split-string value "/")))
         (count (float (car seq)))
         (total (float (cadr seq))))
  (svg-image (svg-lib-concat
              (svg-lib-progress-bar (/ count total) nil
                                    :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
              (svg-lib-tag value nil
                           :stroke 0 :margin 0)) :ascent 'center)))

(setq svg-tag-tags
      `(
        ;; Org tags
        (":\\([A-Za-z0-9]+\\)" . ((lambda (tag) (svg-tag-make tag :font-size 12 :height 0.8))))
        (":\\([A-Za-z0-9]+[ \-]\\)" . ((lambda (tag) tag :font-size 12 :height 0.8 )))

        ;; Task priority
        ("\\[#[A-Z]\\]" . ( (lambda (tag)
                              (svg-tag-make tag :face 'org-priority
                                            :beg 2 :end -1 :margin 0
                                            :font-size 12 :height 0.8))))

        ;; Progress
        ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
                                            (svg-progress-percent (substring tag 1 -2)))))
        ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
                                          (svg-progress-count (substring tag 1 -1)))))

        ;; TODO / DONE
        ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :inverse t :margin 0 :font-size 12 :height 0.8))))
        ("WAIT" . ((lambda (tag) (svg-tag-make "WAIT" :face 'org-done :margin 0 :font-size 12 :height 0.8))))
        ("KILL" . ((lambda (tag) (svg-tag-make "KILL" :face 'org-done :margin 0 :font-size 12 :height 0.8))))
        ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :margin 0 :font-size 12 :height 0.8))))
        ("DEADLINE" . ((lambda (tag) (svg-tag-make "DEADLINE" :face 'org-done :margin 0 :font-size 12 :height 0.8))))

        ;; Citation of the form [cite:@Knuth:1984]
        ("\\(\\[cite:@[A-Za-z]+:\\)" . ((lambda (tag)
                                          (svg-tag-make tag
                                                        :inverse t
                                                        :beg 7 :end -1
                                                        :crop-right t
                                                        :font-size 12 :height 0.8))))
        ("\\[cite:@[A-Za-z]+:\\([0-9]+\\]\\)" . ((lambda (tag)
                                                (svg-tag-make tag
                                                              :end -1
                                                              :crop-left t
                                                              :font-size 12 :height 0.8))))


        ;; Active date (with or without day name, with or without time)
        (,(format "\\(<%s>\\)" date-re) .
         ((lambda (tag)
            (svg-tag-make tag :beg 1 :end -1 :margin 0 :font-size 12 :height 0.8))))
        (,(format "\\(<%s \\)%s>" date-re day-time-re) .
         ((lambda (tag)
            (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :font-size 12 :height 0.8))))
        (,(format "<%s \\(%s>\\)" date-re day-time-re) .
         ((lambda (tag)
            (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :font-size 12 :height 0.8))))

        ;; Inactive date  (with or without day name, with or without time)
         (,(format "\\(\\[%s\\]\\)" date-re) .
          ((lambda (tag)
             (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date :font-size 12 :height 0.8))))
         (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
          ((lambda (tag)
             (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date :font-size 12 :height 0.8))))
         (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
          ((lambda (tag)
             (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date :font-size 12 :height 0.8))))))

(use-package pdf-view
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
)

(use-package! lsp-ui)
