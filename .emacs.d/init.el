;; DEFINIÇÕES BÁSICAS.

;;; DEFINE O BLOQUEIO DO BUFFER INICIAL PADRÃO.
(setq inhibit-startup-message t)

;; DEFINE A VISIBILIDADE DO MENU DE AÇÕES.
(menu-bar-mode -1)

;; DEFINE A APRESENTAÇÃO DA POSIÇÃO DA COLUNA NA BARRA DE STATUS.
(column-number-mode t)

;; DEFINE A NÚMERAÇÃO DE LINHAS.
(global-display-line-numbers-mode t)

;; DEFINE O DESTAQUE DE LINHA.
(global-hl-line-mode t)

;; DEFINE O SOBRESCREVER DE SELEÇÕES DE TEXTO.
(delete-selection-mode t)

;; DEFINE QUEBRAS DE LINHAS.
(global-visual-line-mode t)

;; DEFINIÇÕES DE FONTES.
(set-face-attribute 'default nil
                  :font "JetBrains Mono Nerd Font Mono"
                  :weight 'medium
                  :height 140)

(setq initial-major-mode 'prog-mode)

;; DEFINE O DIRETÓRIO PADRÃO PARA BACKUPS.
(setq backup-directory-alist `(("." . "~/.cache/emacs")))

;; DESATIVA OS EFEITOS SONOROS.
(setq visible-bell t)


;; SINCRONIZA A ÁREA DE TRANSFERENCIA.
;;(setq x-select-enable-clipboard t)
;;(setq x-select-enable-primary t)
;;(setq interprogram-cut-function 'own-clipboard)
;;(setq interprogram-paste-function 'get-clipboard)
;;(add-to-list 'after-init-hook 'clipmon-mode-start)

;;(require 'clipmon)


;; DEFINE O ESPAÇAMENTO PADRÃO DO DOCUMENTO.
;; http://xahlee.info/emacs/emacs/emacs_tabs_space_indentation_setup.html
(setq-default tab-width 4)
(setq tab-width 4)
(progn
  (setq-default indent-tabs-mode nil))

(setq-default tab-always-indent t)
(setq-default tab-always-indent nil)
(setq-default tab-always-indent 'complete)

(defun my-insert-tab-char ()
  (interactive)
  (insert "\t"))
(global-set-key (kbd "TAB") 'my-insert-tab-char)
(global-set-key (kbd "<tab>") 'my-insert-tab-char)

(electric-indent-local-mode 1)
(electric-indent-mode 1)

;; FUNÇÕES.

;; DEFINE A INDENTAÇÃO DO TEXTO.
(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 1))

(defun shift-left ()
  (interactive)
  (shift-region -1))

(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)

;; PACOTES

;; DEFINE O INSTALADOR DE PACOTES.
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org"   . "https://orgmode.org/elpa/")
			 ("elpa"  . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;
(unless (package-installed-p 'flycheck)
  (package-install 'flycheck))

(setq flycheck-check-syntax-automatically '(mode-enabled save))


(use-package flycheck
  :ensure t
  :init
  (progn
    (global-flycheck-mode)))

;; DEFINE ATUALIZAÇÕES AUTOMATICAS DE COMPONENTES.
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "21:00"))

;; DEFINE A INSTALAÇÃO DO PACOTE DE TEMAS.
(use-package gruvbox-theme
  :ensure t
  :config
  (progn
    (load-theme 'gruvbox-dark-soft t)))

;; DEFINE PADRÕES DE FORMATO AO DOCUMENTO.
(use-package editorconfig
  :ensure t
  :config
  (progn
    (editorconfig-mode 1)))

;; DEFINE O SERVIDOR DE PROTOCOLO DE LINGUAGENS. (IDE)
(use-package lsp-mode
  :commands lsp
  :hook
  (sh-mode . lsp))


;; DEFINE ??
(use-package lsp-ui)

;; DEFINE O AUTO COMPLETAR DA BARRA INFERIOR.
(use-package ivy)
(ivy-mode)

;; DEFINE O VERIFICADOR DE CÓDIGO. (SHELL SCRIPT)
;;(use-package flycheck-checkbashisms
;;  :ensure t
;;  :config
;;  (progn
;;    (flycheck-checkbashisms-setup)
;;    (setq flycheck-checkbashisms-newline t)
;;    (setq flycheck-checkbashisms-posix t))

;; DEFINE O AUTO COMPLETAR.
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ivy lsp-ui auto-complete awesome-tab flycheck-color-mode-line powerline flycheck-checkbashisms flycheck lsp-mode editorconfig use-package gruvbox-theme auto-package-update)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )