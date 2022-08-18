;;; doom-catppuccin-latte-theme.el --- inspired by Catppuccin & Ayu Light -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: August 7, 2022)
;; Author: Mia
;; Maintainer:
;; Source:
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-catppuccin-latte-theme nil
  "Options for the `doom-catppuccin-latte' theme."
  :group 'doom-themes)

(defcustom doom-catppuccin-latte-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-catppuccin-latte-theme
  :type 'boolean)

(defcustom doom-catppuccin-latte-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-catppuccin-latte-theme
  :type 'boolean)

(defcustom doom-catppuccin-latte-comment-bg doom-catppuccin-latte-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-catppuccin-latte-theme
  :type 'boolean)

(defcustom doom-catppuccin-latte-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-catppuccin-latte-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme doom-catppuccin-latte
  "A light theme inspired by Ayu Light"

  ;; name        default   256       16
  (
   ;; common
   (common-accent   '("#7287fd" "violet"  "violet" ))
   (common-bg       '("#ffffff" "black"   "black"  ))
   (common-fg       '("#4c4f69" "grey"    "grey"   ))
   (common-ui       '("#9ca0b0" "grey"    "grey"   ))
   (test            '("#6c6f85" "grey"    "grey"   ))
   ;; syntax
   (syntax-tag      '("#04a5e5" "cyan"    "blue"   ))
   (syntax-func     '("#ea76cb" "magenta"  "magenta" ))
   (syntax-entity   '("#1e66f5" "blue"    "blue"   ))
   (syntax-string   '("#40a02b" "green"   "green"  ))
   (syntax-regexp   '("#179299" "teal"    "green"  ))
   (syntax-markup   '("#e64553" "red"     "red"    ))
   (syntax-keyword  '("#04a5e5" "blue"  "blue"     ))
   (syntax-special  '("#7287fd" "violet"  "violet" ))
   (syntax-comment  '("#8c8fa1" "grey"    "grey"   ))
   (syntax-constant '("#dc8a78" "orange" "orange"  ))
   (syntax-operator '("#df8e1d" "yellow"  "yellow" ))
   (syntax-error    '("#d20f39" "red"     "red"    ))
   ;; ui
   (ui-line               (doom-darken common-bg 0.07))
   (ui-panel-shadow       (doom-lighten common-bg 0.35))
   (ui-panel-border       (doom-lighten common-bg 0.45))
   (ui-gutter-normal      (doom-lighten common-ui 0.45))
   (ui-gutter-active      common-ui)
   (ui-selection-bg       (doom-blend common-bg test 0.7))
   (ui-selection-inactive (doom-lighten test 0.93))
   (ui-selection-border   (doom-lighten test 0.93))
   (ui-guide-active       (doom-lighten common-ui 0.75))
   (ui-guide-normal       (doom-lighten common-ui 0.35))
   (ui-org-block          (doom-lighten test 0.95))
   (elscreen-bg           (doom-lighten common-fg 0.65))
   (elscreen-fg           (doom-darken common-fg 0.85))
   ;; vcs
   (vcs-added    '("#99bf4d" "green" "green" ))
   (vcs-modified '("#709ecc" "blue"  "blue"  ))
   (vcs-removed  '("#f27983" "red"   "red"   ))

   (bg         common-bg)
   (bg-alt     common-bg)
   (base0      ui-gutter-normal)
   (base1      ui-gutter-active)
   (base2      ui-selection-bg)
   (base3      ui-selection-border)
   (base4      ui-selection-inactive)
   (base5      ui-guide-active)
   (base6      ui-guide-normal)
   (base7      ui-panel-shadow)
   (base8      ui-panel-border)
   (fg         common-fg)
   (fg-alt     common-ui)

   (grey       syntax-comment)
   (red        syntax-markup)
   (orange     syntax-constant)
   (green      syntax-string)
   (teal       syntax-regexp)
   (yellow     syntax-operator)
   (blue       syntax-keyword)
   (dark-blue  (doom-darken syntax-keyword 0.2))
   (magenta    syntax-func)
   (violet     syntax-special)
   (cyan       syntax-entity)
   (dark-cyan  (doom-darken syntax-entity 0.2))

   ;; face categories -- required for all themes
   (highlight      common-accent)
   (vertical-bar   ui-panel-border)
   (selection      ui-selection-inactive)
   (builtin        syntax-func)
   (comments       (if doom-catppuccin-latte-brighter-comments syntax-comment elscreen-bg))
   (doc-comments   (doom-lighten (if doom-catppuccin-latte-brighter-comments syntax-comment elscreen-bg) 0.25))
   (constants      syntax-constant)
   (functions      syntax-func)
   (keywords       syntax-keyword)
   (methods        syntax-func)
   (operators      syntax-operator)
   (type           syntax-special)
   (strings        syntax-string)
   (variables      syntax-operator)
   (numbers        syntax-func)
   (region         ui-selection-bg)
   (error          syntax-error)
   (warning        yellow)
   (success        green)
   (vc-modified    vcs-modified)
   (vc-added       vcs-added)
   (vc-deleted     vcs-removed)

   ;; custom categories
   (hidden     (car bg))
   (-modeline-bright doom-catppuccin-latte-brighter-modeline)
   (-modeline-pad
    (when doom-catppuccin-latte-padded-modeline
      (if (integerp doom-catppuccin-latte-padded-modeline) doom-catppuccin-latte-padded-modeline 4)))

   (modeline-fg     common-ui)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        (doom-lighten blue 0.475)
      `(,(doom-lighten (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-lighten blue 0.45)
      `(,(doom-lighten (car bg-alt) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(doom-lighten (car bg) 0.1) ,@(cdr bg)))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))

  ;;;; Base theme face overrides
  (((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-catppuccin-latte-comment-bg (doom-lighten bg 0.05)))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))


   ;;;; company
   (company-tooltip :foreground common-fg :background common-bg)
   (company-tooltip-annotation :foreground common-fg)
   (company-tooltip-selection :background ui-line)
   (company-tooltip-search :foreground common-accent :weight 'bold)
   (company-scrollbar-bg :background common-bg)
   (company-scrollbar-fg :background syntax-comment)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; diff-mode <built-in>
   (diff-removed :foreground vcs-removed)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight) :weight 'normal)
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'normal)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'normal)
   (doom-modeline-buffer-project-root :foreground green :weight 'normal)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background elscreen-bg :foreground elscreen-fg)
   ;;;; highlight-numbers
   (highlight-numbers-number :foreground syntax-func :weight 'normal)
   ;;;; ivy
   (ivy-current-match :background ui-line)
   (ivy-minibuffer-match-face-1 :foreground common-accent :weight 'bold)
   (ivy-minibuffer-match-face-2 :foreground common-accent :weight 'bold)
   (ivy-minibuffer-match-face-3 :foreground common-accent :weight 'bold)
   (ivy-minibuffer-match-face-4 :foreground common-accent :weight 'bold)
   ;;;; js2-mode
   (js2-object-property :foreground common-fg)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten common-bg 0.05))
   ;;;; org <built-in>
   (org-hide :foreground hidden)
   (org-headline-done :foreground syntax-comment)
   (org-document-info-keyword :foreground comments)
   ;;;; rjsx-mode
   (rjsx-tag :foreground cyan)
   (rjsx-tag-bracket-face :foreground (doom-lighten cyan 0.5))
   (rjsx-attr :foreground syntax-func)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))
   ;;;; web-mode
   (web-mode-html-tag-face :foreground cyan)
   (web-mode-html-tag-bracket-face :foreground (doom-lighten cyan 0.5))
   (web-mode-html-attr-name-face :foreground syntax-func)))

;;; doom-catppuccin-latte-theme.el ends here
