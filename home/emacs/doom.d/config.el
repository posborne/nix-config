;;; config.el --- Description -*- lexical-binding: t; -*-
;;; $DOOMDIR/config.el


;; Setup doom themes and fonts
(setq doom-theme 'doom-palenight)
(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 14 :weight 'medium))


;; Additional keybinds
(map! "C-c c TAB" #'eglot-inlay-hints-mode)


;; Close the compile window automatically if it finishes
;; successfully; otherwise it just gets in the way.
