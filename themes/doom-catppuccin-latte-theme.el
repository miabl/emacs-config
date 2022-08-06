;;; doom-catppuccin-latte-theme.el --- inspired by Atom One Dark -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;;
;; Shamelessly ripped from catppuccin-latte and just changed hex values :)
;; Added: May 23, 2016 (28620647f838)
;; Author: Henrik Lissner <https://github.com/hlissner>
;; Maintainer: Henrik Lissner <https://github.com/hlissner>
;; Source: https://github.com/atom/one-dark-ui
;;
;;; Commentary:
;;
;; This themepack's flagship theme.
;;
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

(defcustom doom-catppuccin-latte-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-catppuccin-latte-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme doom-catppuccin-latte
  "A dark theme inspired by Atom One Dark."

  ;; name        default   256           16
  ((bg         '("#ffffff" "black"       "black"  ))
   (fg         '("#4c4f69" "#bfbfbf"     "brightwhite"  ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#e6e9ef" "black"       "black"        ))
   (fg-alt     '("#5c5f77" "#a6adc8"     "white"        ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#dce0e8" "e6e9ef"       "black"        ))
   (base1      '("#eff1f5" "#ccd0da"     "brightblack"  ))
   (base2      '("#bcc0cc" "#acb0be"     "brightblack"  ))
   (base3      '("#acb0be" "#9ca0b0"     "brightblack"  ))
   (base4      '("#8c8fa1" "#3f3f3f"     "brightblack"  ))
   (base5      '("#7c7f93" "#525252"     "brightblack"  ))
   (base6      '("#6c6f85" "#6b6b6b"     "brightblack"  ))
   (base7      '("#5c5f77" "#a6adc8"     "brightblack"  ))
   (base8      '("#4c4f69" "#cdd6f4"     "white"        ))

   (grey       base4)
   (red        '("#d20f39" "#e64553" "red"          ))
   (orange     '("#fe640b" "#dc8a78" "brightred"    ))
   (green      '("#40a02b" "#179299" "green"        ))
   (teal       '("#40a02b" "#209fb5" "brightgreen"  ))
   (yellow     '("#df8e1d" "#fe640b" "yellow"       ))
   (blue       '("#04a5e5" "#7287fd" "brightblue"   ))
   (dark-blue  '("#1e66f5" "#209fb5" "blue"         ))
   (magenta    '("#dc8a78" "#dd7878" "brightmagenta"))
   (violet     '("#7287fd" "#7287fd" "magenta"      ))
   (cyan       '("#04a5e5" "#209fb5" "brightcyan"   ))
   (dark-cyan  '("#1e66f5" "#7287fd" "cyan"         ))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if doom-catppuccin-latte-brighter-comments dark-cyan base4))
   (doc-comments   (if doom-catppuccin-latte-brighter-comments dark-cyan base4))
   (constants      teal)
   (functions      magenta)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           violet)
   (strings        green)
   (variables      (doom-lighten magenta 0.4))
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.55) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; These are extra color variables used only in this theme; i.e. they aren't
   ;; mandatory for derived themes.
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-catppuccin-latte-brighter-modeline
                                 (doom-darken blue 0.45)
                             (doom-lighten bg-alt 0.8)))
   (modeline-bg-alt          (if doom-catppuccin-latte-brighter-modeline
                                 (doom-darken blue 0.475)
                               `(,(car bg-alt) ,@(cdr base0))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base0)))
   (modeline-bg-inactive-alt `(,(doom-lighten (car bg-alt) 0.8) ,@(cdr bg)))

   (-modeline-pad
    (when doom-catppuccin-latte-padded-modeline
      (if (integerp doom-catppuccin-latte-padded-modeline) doom-catppuccin-latte-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-catppuccin-latte-brighter-comments (doom-darken bg-alt 0.05)))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-catppuccin-latte-brighter-modeline base8 highlight))

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-catppuccin-latte-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'normal)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'normal)
   (doom-modeline-buffer-project-root :foreground green :weight 'normal)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'semi-light)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'normal :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; org-mode
   ((org-block &override) :background (doom-lighten base0 0.8))
   ((org-block-begin-line &override) :background (doom-lighten base0 0.75) :foreground comments)
   ;;;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-attr :foreground orange)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt))))

  ;;;; Base theme variable overrides-
  ())

;;; catppuccin-latte-theme.el ends here;;;
