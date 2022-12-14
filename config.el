(setq user-full-name "Mia")

(defun my/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (pcase appearance
    ('light (load-theme 'doom-catppuccin-latte t))
    ('dark (load-theme 'doom-catppuccin-mocha t))))

(add-hook 'ns-system-appearance-change-functions #'my/apply-theme)

(setq doom-font (font-spec :family "RobotoMono Nerd Font" :weight 'semi-light :size 13)
      doom-big-font (font-spec :family "RobotoMono Nerd Font" :weight 'semi-light :size 14)
      doom-unicode-font (font-spec :family "RobotoMono Nerd Font Mono" :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 14)
      doom-serif-font (font-spec :family "IBM Plex Mono")
 )



(custom-set-faces!
  '(bold :weight normal)
  '(outline-1 :weight normal)
  '(outline-2 :weight normal)
  '(outline-3 :weight normal)
  '(outline-4 :weight normal)
  '(outline-5 :weight normal)
  '(outline-6 :weight normal)
  '(outline-8 :weight normal)
  '(outline-9 :weight normal)
  '(treemacs-directory-face :weight normal))

(setq-default line-spacing 0.25)
(setq default-text-properties '(line-spacing 0.25 line-height 1.25))

(setq-default tab-width 2)

(setq display-line-numbers-type 'relative)            ; Relative line numbers

(setq-default fill-column 80                          ; Default line width
              sentence-end-double-space nil           ; Use a single space after dots
              truncate-string-ellipsis "…"            ; Nicer ellipsis
              large-file-warning-threshold 20000000)  ; Nicer ellipsis

(display-time-mode 1)
(unless (string-match-p "^Power N/A" (battery))   ; On laptops...
  (display-battery-mode 1))

(setq fancy-splash-image "~/.doom.d/images/catppuccin.png")

(custom-set-faces!
'(bold  :weight normal))

(setq doom-themes-treemacs-enable-variable-pitch nil)

(setenv "PATH" (concat ":/opt/homebrew/opt/grep/libexec/gnubin:/Library/TeX/texbin/:texlive/2022/bin/" (getenv "PATH")))
(add-to-list 'exec-path "/Library/TeX/texbin/")
(add-to-list 'exec-path "texlive/2022/bin/")
(add-to-list 'exec-path "/opt/homebrew/opt/grep/libexec/gnubin")

(setq undo-limit 10000000
      evil-want-fine-undo t)

(setq-default org-ellipsis " …"              ; Nicer ellipsis
              org-tags-column 1              ; Tags next to header title
              org-hide-emphasis-markers t    ; Hide markers
              org-cycle-separator-lines 2    ; Number of empty lines between sections
              org-use-property-inheritance t ; Properties ARE inherited
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
(setq org-agenda-files '("~/Documents/org/tasks" "~/Documents/org/tasks/uni"))

(require 'svg-lib)
(require 'svg-tag-mode)

(add-hook 'org-mode-hook 'svg-tag-mode)

(defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
(defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
(defconst day-re "[A-Za-z]\\{3\\}")
(defconst day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re))

(defun svg-progress-percent (value)
  (svg-image (svg-lib-concat
              (svg-lib-progress-bar (/ (string-to-number value) 100.0)
                                nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
              (svg-lib-tag (concat value "%")
                           nil :stroke 0 :margin 0 :font-size 12)) :ascent 'center))

(defun svg-progress-count (value)
  (let* ((seq (mapcar #'string-to-number (split-string value "/")))
         (count (float (car seq)))
         (total (float (cadr seq))))
  (svg-image (svg-lib-concat
              (svg-lib-progress-bar (/ count total) nil
                                    :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
              (svg-lib-tag value nil
                           :stroke 0 :margin 0 :font-size 12)) :ascent 'center)))

(setq svg-tag-tags
      `(
        ;; Org tags
        (":\\([A-Za-z0-9]+\\):" . ((lambda (tag) (svg-tag-make tag :font-size 12))))
        (":\\([A-Za-z0-9]+[ \-]\\):" . ((lambda (tag) tag :font-size 12)))

        ;; Task priority
        ("\\[#[A-Z]\\]" . ( (lambda (tag)
                              (svg-tag-make tag :face 'org-priority
                                            :beg 2 :end -1 :margin 0
                                            :font-size 12))))

        ;; Progress
        ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
                                            (svg-progress-percent (substring tag 1 -2)))))
        ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
                                          (svg-progress-count (substring tag 1 -1)))))

        ;; TODO / DONE
        ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :inverse t :margin 0 :font-size 12))))
        ("WAIT" . ((lambda (tag) (svg-tag-make "WAIT" :face 'org-done :margin 0 :font-size 12))))
        ("KILL" . ((lambda (tag) (svg-tag-make "KILL" :face 'org-done :margin 0 :font-size 12))))
        ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :margin 0 :font-size 12))))
        ("DEADLINE" . ((lambda (tag) (svg-tag-make "DEADLINE" :face 'org-done :margin 0 :font-size 12))))
        ("SCHEDULED" . ((lambda (tag) (svg-tag-make "SCHEDULED" :face 'org-done :margin 0 :font-size 12))))


        ;; Citation of the form [cite:@Knuth:1984]
        ("\\(\\[cite:@[A-Za-z]+:\\)" . ((lambda (tag)
                                          (svg-tag-make tag
                                                        :inverse t
                                                        :beg 7 :end -1
                                                        :crop-right t
                                                        :font-size 12))))
        ("\\[cite:@[A-Za-z]+:\\([0-9]+\\]\\)" . ((lambda (tag)
                                                (svg-tag-make tag
                                                              :end -1
                                                              :crop-left t
                                                              :font-size 12))))


        ;; Active date (with or without day name, with or without time)
        (,(format "\\(<%s>\\)" date-re) .
         ((lambda (tag)
            (svg-tag-make tag :beg 1 :end -1 :margin 0 :font-size 12))))
        (,(format "\\(<%s \\)%s>" date-re day-time-re) .
         ((lambda (tag)
            (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :font-size 12))))
        (,(format "<%s \\(%s>\\)" date-re day-time-re) .
         ((lambda (tag)
            (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :font-size 12))))

        ;; Inactive date  (with or without day name, with or without time)
         (,(format "\\(\\[%s\\]\\)" date-re) .
          ((lambda (tag)
             (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date :font-size 12))))
         (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
          ((lambda (tag)
             (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date :font-size 12))))
         (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
          ((lambda (tag)
             (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date :font-size 12))))))

(setq org-enforce-todo-checkbox-dependencies t)
(setq org-agenda-dim-blocked-tasks nil)

(defun my/org-agenda-highlight-todo (x)
  (let* ((done (string-match-p (regexp-quote "DONE") x))
         (canceled (string-match-p (regexp-quote "~") x))
         (x (replace-regexp-in-string "TODO" "" x))
         (x (replace-regexp-in-string "DONE" "" x))
         (x (replace-regexp-in-string "WAIT" "" x))
         (x (replace-regexp-in-string "~" "" x))
         (x (if (and (boundp 'org-agenda-dim) org-agenda-dim)
                (propertize x 'face 'org-done) x))
         (x (if done (propertize x 'face 'org-done) x))
         (x (if canceled (propertize x 'face 'org-done) x)))
    x))

(setq org-agenda-hide-tags-regexp
    (regexp-opt '("CITS3001" "CITS1402" "STAT2402" "CITS2211" "coursework")))

(advice-add 'org-agenda-highlight-todo
            :filter-return #'my/org-agenda-highlight-todo)

(defun my/svg-tag-timestamp (&rest args)
  "Create a timestamp SVG tag for the time at point."

  (interactive)
  (let ((inhibit-read-only t))

    (goto-char (point-min))
    (while (search-forward-regexp
            "\\(\([0-9]/[0-9]\):\\)" nil t)
              (set-text-properties (match-beginning 1) (match-end 1)
                             `(display ,(svg-tag-make "ANYTIME"
                                                      :face 'org-meta-line
                                                      :inverse nil
                                                      :padding 3 :alignment 0))))

    (goto-char (point-min))
    (while (search-forward-regexp
            "\\([0-9]+:[0-9]+\\)\\(\\.+\\)" nil t)

              (set-text-properties (match-beginning 1) (match-end 2)
                             `(display ,(svg-tag-make (match-string 1)
                                                       :face 'org-scheduled
                                                       :margin 4 :alignment 0))))

    (goto-char (point-min))
    (while (search-forward-regexp
            "\\([0-9]+:[0-9]+\\)\\(\\.*\\)" nil t)

              (set-text-properties (match-beginning 1) (match-end 2)
                             `(display ,(svg-tag-make (match-string 1)
                                                      :face 'org-scheduled
                                                      :inverse t
                                                      :margin 4 :alignment 0))))
    (goto-char (point-min))
    (while (search-forward-regexp
            "\\([0-9]+:[0-9]+\\)\\(-[0-9]+:[0-9]+\\)" nil t)
      (let* ((t1 (parse-time-string (match-string 1)))
             (t2 (parse-time-string (substring (match-string 2) 1)))
             (t1 (+ (* (nth 2 t1) 60) (nth 1 t1)))
             (t2 (+ (* (nth 2 t2) 60) (nth 1 t2)))
             (d  (- t2 t1)))

        (set-text-properties (match-beginning 1) (match-end 1)
                                `(display ,(svg-tag-make (match-string 1)
                                                         :face 'org-roam-dim
                                                         :crop-right t)))
        ;; 15m: ¼, 30m:½, 45m:¾
        (if (< d 60)
             (set-text-properties (match-beginning 2) (match-end 2)
                                  `(display ,(svg-tag-make (format "%2dm" d)
                                                           :face 'org-roam-dim
                                                           :crop-left t :inverse t)))
           (set-text-properties (match-beginning 2) (match-end 2)
                                `(display ,(svg-tag-make (format "%1dH" (/ d 60))
                                                         :face 'org-roam-dim
                                                         :crop-left t :inverse t
                                                         :padding 2 :alignment 0))))))))

(add-hook 'org-agenda-mode-hook #'my/svg-tag-timestamp)
(advice-add 'org-agenda-redo :after #'my/svg-tag-timestamp)

                (defun my/org-agenda-custom-date ()
  (interactive)
  (let* ((timestamp (org-entry-get nil "TIMESTAMP"))
         (timestamp (or timestamp (org-entry-get nil "DEADLINE"))))
    (if timestamp
        (let* ((delta (- (org-time-string-to-absolute (org-read-date nil nil timestamp))
                         (org-time-string-to-absolute (org-read-date nil nil ""))))
               (delta (/ (+ 1 delta) 30.0))
               (face (cond  ((< delta 0.25) 'org-date)
                            ((< delta 0.50) 'org-code)
                           ((< delta 1.00) 'org-scheduled)
                           (t 'org-roam-dim))))
          (concat
           (propertize " " 'face nil
                       'display (svg-lib-progress-pie
                                 delta nil
                                 :background (face-background face nil 'default)
                                 :foreground (face-foreground face)
                                 :margin 0 :stroke 2 :padding 1))
           " "
              (propertize
            (format-time-string "%a %d/%m" (org-time-string-to-time timestamp))
            'face 'org-agenda-current-time)
              " ("
                        (number-to-string (org-time-stamp-to-now timestamp))
                        "d)"


        ))


      "     "

      ))
                )

(setq org-agenda-time-grid
      '((daily today require-timed)
        ()
        "......" "----------------"))
1
(setq org-agenda-current-time-string "   now")

(setq org-agenda-custom-commands
        '(("x" "Tasks"
          ((todo "TODO" ;; "PROJECT"
                 ( (org-agenda-todo-keyword-format "%s")
                   (org-agenda-prefix-format '((todo   . " ")))
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp))
                   (org-agenda-overriding-header (propertize " Todo \n" 'face 'bold))))

           (tags "CITS3001-assignment|CITS1402-assignment|STAT2402-assignment|CITS2211-assignment"
                 ((org-agenda-span 90)
                  (org-agenda-max-tags 10)
                  (org-agenda-sorting-strategy '(deadline-up priority-up))
                  (org-agenda-prefix-format '((tags   . " %(my/org-agenda-custom-date) %c ")))
                  (org-agenda-overriding-header "\n Upcoming classwork\n")))

           (tags "-TODO=\"WAIT\"+assignment+DEADLINE>=\"<now>\""
                 ((org-agenda-span 90)
                  (org-agenda-max-tags 5)
                  (org-agenda-sorting-strategy '(deadline-up priority-down))
                  (org-agenda-prefix-format '((tags .  " %(my/org-agenda-custom-date) %c ")))
                  (org-agenda-overriding-header "\n Upcoming assignments\n")))

           (tags "DEADLINE>=\"<now>\"-coursework"
                  ((org-agenda-span 90)
                   (org-agenda-max-tags 10)
                   (org-agenda-sorting-strategy '(deadline-up priority-up))
                   (org-agenda-prefix-format '((tags .  " %(my/org-agenda-custom-date) %c ")))
                   (org-agenda-overriding-header "\n Upcoming deadlines\n")))
                ))

          ("w" "Waiting"
                     ((todo "TODO" ;; "PROJECT"
                 ( (org-agenda-todo-keyword-format "%s")
                   (org-agenda-prefix-format '((todo   . " ")))
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp))
                   (org-agenda-overriding-header (propertize " Todo \n" 'face 'bold))))
           (tags "SCHEDULED>=\"<now>\""
                 ((org-agenda-span 90)
                  (org-agenda-max-tags 10)
                  (org-agenda-sorting-strategy '(deadline-up priority-up))
                  (org-agenda-prefix-format '((tags   . " %(my/org-agenda-custom-date) %c ")))
                  (org-agenda-overriding-header "\n Currently waiting\n")))
            (tags "SCHEDULED<=\"<now>\"+TODO=\"WAIT\""
                 ((org-agenda-span 90)
                  (org-agenda-max-tags 10)
                  (org-agenda-sorting-strategy '(deadline-up priority-up))
                  (org-agenda-prefix-format '((tags   . " %(my/org-agenda-custom-date) %c ")))
                  (org-agenda-overriding-header "\n Update status\n")))
                ))))

(setq org-capture-templates
       `(("i" "Inbox" entry  (file "inbox.org")
        ,(concat "* TODO %?\n"
                 "/Entered on/ %U"))))

(use-package pdf-view
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
)

(use-package! lsp-ui)

(setq doom-themes-treemacs-theme "doom-colors")
