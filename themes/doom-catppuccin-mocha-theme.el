;;; doom-catppuccin-mocha-theme.el --- inspired by Atom One Dark -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;;
;; Shamelessly ripped from doom-one and just changed hex values :)
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

(defgroup doom-catppuccin-mocha-theme nil
  "Options for the `doom-catppuccin-mocha' theme."
  :group 'doom-themes)

(defcustom doom-catppuccin-mocha-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-catppuccin-mocha-theme
  :type 'boolean)

(defcustom doom-catppuccin-mocha-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-catppuccin-mocha-theme
  :type 'boolean)

(defcustom doom-catppuccin-mocha-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-catppuccin-mocha-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme doom-catppuccin-mocha
  "A dark theme inspired by Atom One Dark."

  ;; name        default   256           16
  ((bg         '("#1e1e2e" "black"       "black"  ))
   (fg         '("#cdd6f4" "#bfbfbf"     "brightwhite"  ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#181825" "black"       "black"        ))
   (fg-alt     '("#bac2de" "#a6adc8"     "white"        ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#1e1e2e" "black"       "black"        ))
   (base1      '("#313244" "#313244"     "brightblack"  ))
   (base2      '("#45475a" "#2e2e2e"     "brightblack"  ))
   (base3      '("#6c7086" "#262626"     "brightblack"  ))
   (base4      '("#7f849c" "#3f3f3f"     "brightblack"  ))
   (base5      '("#9399b2" "#525252"     "brightblack"  ))
   (base6      '("#a6adc8" "#6b6b6b"     "brightblack"  ))
   (base7      '("#a6adc8" "#a6adc8"     "brightblack"  ))
   (base8      '("#cdd6f4" "#cdd6f4"     "white"        ))

   (grey       base4)
   (red        '("#f38ba8" "#eba0ac" "red"          ))
   (orange     '("#fab387" "#eba0ac" "brightred"    ))
   (green      '("#a6e3a1" "#a6e3a1" "green"        ))
   (teal       '("#94e2d5" "#94e2d5" "brightgreen"  ))
   (yellow     '("#f9e2af" "#f9e2af" "yellow"       ))
   (blue       '("#89b4fa" "#74c7ec" "brightblue"   ))
   (dark-blue  '("#89b4fa" "#b4befe" "blue"         ))
   (magenta    '("#f5c2e7" "#cba6f7" "brightmagenta"))
   (violet     '("#b4befe" "#cba6f7" "magenta"      ))
   (cyan       '("#74c7ec" "#89b4fa" "brightcyan"   ))
   (dark-cyan  '("#89b4fa" "#b4befe" "cyan"         ))
   (flamingo   '("#f2cdcd" "white"))
   (sapphire   '("#74c7ec" "blue"))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if doom-catppuccin-mocha-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-catppuccin-mocha-brighter-comments dark-cyan base5) 0.25))
   (constants      teal)
   (functions      magenta)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           violet)
   (strings        green)
   (variables      (doom-lighten magenta 0.4))
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
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
   (modeline-bg              (if doom-catppuccin-mocha-brighter-modeline
                                 (doom-darken blue 0.45)
                               (doom-darken bg-alt 0.1)))
   (modeline-bg-alt          (if doom-catppuccin-mocha-brighter-modeline
                                 (doom-darken blue 0.475)
                               `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when doom-catppuccin-mocha-padded-modeline
      (if (integerp doom-catppuccin-mocha-padded-modeline) doom-catppuccin-mocha-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-catppuccin-mocha-brighter-comments (doom-lighten bg 0.05)))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-catppuccin-mocha-brighter-modeline base8 highlight))

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-catppuccin-mocha-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'normal)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'normal)
   (doom-modeline-buffer-project-root :foreground green :weight 'normal)

   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'normal :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; org-mode
   ((org-block &override) :background (doom-darken base0 0.125))
   ((org-block-begin-line &override) :background (doom-darken base0 0.125) :foreground comments)
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

;;; doom-catppuccin-mocha-theme.el ends here;;;
