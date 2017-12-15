;; mapserver-mode-el -- Major mode for editing UMN MapServer files
;;
;; Author: Axel Schaefer
;; Modified: 25 August 2014
;; Keywords: UMN Mapserver major-mode
;;
;; Available at: https://github.com/AxxL/mapserver-emacs-mode
;;
;; Modified version of Hal Muellers mapserver-mode.
;; Forked from: https://github.com/halmueller/mapserver-emacs-mode
;; 
;; Adjusted to mapserver 6.4.1.
;; 
;; The original file seems to be based on the Mode Tutorial by Scott Andrew
;; Borton at http://www.emacswiki.org/emacs/ModeTutorial. See also the
;; Sample Major Mode example by Stefan Monnier at
;; http://www.emacswiki.org/emacs/SampleMode.
;; 
;;
;; INSTALLATION
;; ------------
;;
;; Grab the neccessary file at:
;; https://github.com/AxxL/mapserver-emacs-mode/blob/master/mapserver-mode.el
;;
;; Put it into: $HOME/.emacs.d/lisp/
;;
;; You need to add the following lines to your $HOME/.emacs.d/init.el
;;
;; (autoload 'mapserver-mode "mapserver-mode" "Mode for editing UMN MapServer files." t)
;; (add-to-list 'auto-mode-alist '("\\.map\\'" . mapserver-mode))
;;
;; If you haven't specified your load-path it is a good idea to do it now. Put
;; the following line before the other two lines.
;;
;; (add-to-list 'load-path "~/.emacs.d/lisp")
;;
;; Some help for Emacs is available at the [[http://www.emacswiki.org/][Emacs Wiki]].
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; Author: Hal Mueller <hal@mobilegeographics.com>
;; Created: 22 May 2004
;; Keywords: MapServer major-mode
;;
;; Copyright (C) 2004 Hal Mueller <hal@mobilegeographics.com>
;; (distributed under the standard MapServer license)
;;
;; Permission is hereby granted, free of charge, to any person obtaining a
;; copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to permit
;; persons to whom the Software is furnished to do so, subject to the
;; following conditions:
;;
;; The above copyright notice and this permission notice shall be included
;; in all copies of this Software or works derived from this Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
;; OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
;; NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
;; DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
;; OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
;; USE OR OTHER DEALINGS IN THE SOFTWARE.



;;; Code:
(defvar mapserver-mode-hook nil)
(defvar mapserver-mode-map
  (let ((mapserver-mode-map (make-keymap)))
    (define-key mapserver-mode-map "\C-j" 'newline-and-indent)
    mapserver-mode-map)
  "Keymap for MapServer major mode")

(add-to-list 'auto-mode-alist '("\\.map\\'" . mapserver-mode))
(add-to-list 'auto-mode-alist '("\\.MAP\\'" . mapserver-mode))

(defconst mapserver-font-lock-keywords-1
  (list
   ;; These define the beginning and end of each MapServer entity definition
   '("\\<\\(C\\(?:L\\(?:ASS\\|USTER\\)\\|OMPOSITE\\)\\|END\\|FEATURE\\|GRID\\|JOIN\\|L\\(?:A\\(?:BEL\\|YER\\)\\|E\\(?:ADER\\|GEND\\)\\)\\|MAP\\|PROJECTION\\|QUERYMAP\\|REFERENCE\\|S\\(?:TYLE\\|YMBOL\\)\\|WEB\\|METADATA\\|VALIDATION\\)\\>" . font-lock-builtin-face)
   
  '("\\('\\w*'\\)" . font-lock-variable-name-face))
  "Minimal highlighting expressions for MapServer mode.")

(defconst mapserver-font-lock-keywords-2
  (append mapserver-font-lock-keywords-1
	  (list
	   ;; These are some possible attributes of MapServer entities
       '("\\<\\(A\\(?:LIGN\\|N\\(?:CHORPOINT\\|GLE\\(?:ITEM\\)?\\|TIALIAS\\)\\)\\|B\\(?:\\(?:ACKGROUND\\(?:\\(?:SHADOW\\)?COLO\\)\\|UFFE\\)R\\)\\|C\\(?:HARACTER\\|LASS\\(?:GROUP\\|ITEM\\)\\|O\\(?:LOR\\|MPOP\\|N\\(?:FIG\\|NECTION\\(?:TYPE\\)?\\)\\)\\)\\|D\\(?:ATA\\(?:PATTERN\\)?\\|E\\(?:BUG\\|FRESOLUTION\\)\\|UMP\\)\\|E\\(?:MPTY\\|NCODING\\|RROR\\|X\\(?:PRESSION\\|TENT\\)\\)\\|F\\(?:IL\\(?:LED\\|TER\\(?:ITEM\\)?\\)\\|O\\(?:CE\\|NT\\(?:SET\\)?\\|OTER\\)\\|ROM\\)\\|G\\(?:AP\\|EOMTRANSFORM\\|R\\(?:\\(?:IDSTE\\|OU\\)P\\)\\)\\|HEADER\\|I\\(?:MAGE\\(?:COLOR\\|PATH\\|QUALITY\\|TYPE\\|URL\\)?\\|N\\(?:ITIALGAP\\|TER\\(?:LACE\\|VALS\\)\\)\\|TEMS\\)\\|KEY\\(?:IMAGE\\|S\\(?:IZE\\|PACING\\)\\)\\|L\\(?:ABEL\\(?:ANGLEITEM\\|CACHE\\|FORMAT\\|ITEM\\|M\\(?:\\(?:AX\\|IN\\)SCALEDENOM\\)\\|REQUIRES\\|SIZEITEM\\)\\|EGENDFORMAT\\|INE\\(?:CAP\\|JOIN\\(?:MAXSIZE\\)?\\)\\|OG\\)\\|M\\(?:A\\(?:RKER\\(?:SIZE\\)?\\|SK\\|X\\(?:ARCS\\|BOXSIZE\\|DISTANCE\\|FEATURES\\|GEOWIDTH\\|INTERVAL\\|LENGTH\\|OVERLAPANGLE\\|S\\(?:CALE\\(?:DENOM\\)?\\|\\(?:IZ\\|UBDIVID\\)E\\)\\|TEMPLATE\\|WIDTH\\)\\)\\|ETADATA\\|I\\(?:N\\(?:ARCS\\|BOXSIZE\\|DISTANCE\\|FEATURESIZE\\|GEOWIDTH\\|INTERVAL\\|S\\(?:CALEDENOM\\|\\(?:IZ\\|UBDIVID\\)E\\)\\|TEMPLATE\\|WIDTH\\)\\|SCALE\\)\\)\\|NAME\\|O\\(?:FFS\\(?:ET\\|IZE\\)\\|PACITY\\|UTLINE\\(?:COLOR\\|WIDTH\\)\\)\\|P\\(?:A\\(?:RTIALS\\|TTERN\\)\\|LUGIN\\|O\\(?:INTS\\|LAROFFSET\\|S\\(?:ITION\\|TLABELCACHE\\)\\)\\|R\\(?:IORITY\\|OCESSING\\)\\)\\|QUERYFORMAT\\|RE\\(?:GION\\|PEATDISTANCE\\|QUIRES\\|SOLUTION\\)\\|S\\(?:CALE\\(?:BAR\\|DENOM\\)\\|HA\\(?:DOW\\(?:COLOR\\|SIZE\\)\\|PEPATH\\)\\|IZE\\(?:UNITS\\)?\\|T\\(?:ATUS\\|YLE\\(?:ITEM\\)?\\)\\|YMBOL\\(?:S\\(?:CALEDENOM\\|ET\\)\\)?\\)\\|T\\(?:ABLE\\|E\\(?:MP\\(?:LATE\\(?:PATTERN\\)?\\|PATH\\)\\|XT\\)\\|ILE\\(?:I\\(?:NDEX\\|TEM\\)\\|SRS\\)\\|O\\(?:LERANCE\\(?:UNITS\\)?\\)?\\|RANS\\(?:FORM\\|PAREN\\(?:CY\\|T\\)\\)\\|YPE\\)\\|UNITS\\|VALIDATION\\|W\\(?:IDTH\\|KT\\|RAP\\)\\)\\>" . font-lock-variable-name-face)
      ;; AXS
	  ;; '("\\<\\(COLOR\\|MAXSIZE\\)\\>" . font-lock-keyword-face)
       '("\\<\\(ON\\|OFF\\)\\>" . font-lock-constant-face)))
  "Additional Keywords to highlight in MapServer mode.")

(defconst mapserver-font-lock-keywords-3
  (append mapserver-font-lock-keywords-2
	  (list
	   ;; These are some possible built-in values for MapServer attributes
	   ;; POINT POLYGON LINE
       ;; AXS
       ;; '("\\<(LINE\\|PO\\(?:INT\\|LYGON\\))\\>" . font-lock-constant-face)))
       '("\\<\\(LINE\\|MULTI\\(?:LINE\\|PO\\(?:INT\\|LYGON\\)\\)\\|O\\(?:FF\\|N\\)\\|PO\\(?:INT\\|LYGON\\)\\|RASTER\\|TRUETYPE\\|angle\\|bbox_pixel_is_point\\|c\\(?:lear\\|o\\(?:lor-\\(?:burn\\|dodge\\)\\|nt\\(?:our\\|rast\\)\\)\\)\\|d\\(?:arken\\|ifference\\|st\\(?:-\\(?:atop\\|in\\|o\\(?:ut\\|ver\\)\\)\\)?\\)\\|e\\(?:mbed\\|xclusion\\)\\|gml_\\(?:\\(?:exclude_item\\|g\\(?:eometrie\\|roup\\)\\|\\(?:include\\|xml\\)_item\\)s\\)\\|hard-light\\|invert\\(?:-rgb\\)?\\|kerneldensity\\|l\\(?:ighten\\|ocal\\)\\|m\\(?:eters\\|inus\\|ultiply\\)\\|o\\(?:gr\\|r\\(?:aclespatial\\)?\\|verlay\\|ws_\\(?:a\\(?:ccessconstraints\\|ddress\\(?:type\\)?\\|llowed_ip_list\\)\\|c\\(?:ity\\|o\\(?:ntact\\(?:electronicmailaddress\\|facsimiletelephone\\|information\\|organization\\|p\\(?:\\(?:ers\\|ositi\\)on\\)\\|voicetelephone\\)\\|untry\\)\\)\\|denied_ip_list\\|enable_request\\|fees\\|http_max_age\\|keywordlist\\|postcode\\|s\\(?:chemas_location\\|ld_enabled\\|tateorprovince\\)\\|updatesequence\\)\\)\\|p\\(?:lu\\(?:gin\\|s\\)\\|ostgis\\)\\|r\\(?:adius\\|l\\)\\|s\\(?:creen\\|de\\|oft-light\\|rc\\(?:-\\(?:atop\\|in\\|o\\(?:ut\\|ver\\)\\)\\)?\\)\\|u\\(?:nion\\|vraster\\|[lr]\\)\\|w\\(?:fs\\|ms\\(?:_\\(?:a\\(?:bstract\\|ccessconstraints\\|ddress\\(?: \\|type\\)\\|llowed_ip_list\\|ttribution_\\(?:logourl_\\(?:format\\|h\\(?:eight\\|ref\\)\\|width\\)\\|\\(?:onlineresourc\\|titl\\)e\\)\\|uthorityurl_\\(?:href\\|name\\)\\)\\|bbox_extended\\|c\\(?:ity\\|o\\(?:ntact\\(?:electronicmailaddress\\|facsimiletelephone\\|organization\\|p\\(?:\\(?:ers\\|ositi\\)on\\)\\|voicetelephone\\)\\|untry\\)\\)\\|d\\(?:ataurl_\\(?:format\\|href\\)\\|enied_ip_list\\)\\|e\\(?:n\\(?:able_request\\|coding\\)\\|x\\(?:clude_items\\|tent\\)\\)\\|fe\\(?:ature_info_mime_type\\|es\\)\\|g\\(?:et\\(?:capabilities_version\\|\\(?:featureinfo\\|legendgraphic\\|map\\)_formatlist\\)\\|roup_\\(?:abstract\\|title\\)\\)\\|i\\(?:dentifier_\\(?:authority\\|value\\)\\|nclude_items\\)\\|keywordlist\\(?:_vocabulary\\)?\\|la\\(?:nguages\\|yer\\(?:_group\\|limit\\)\\)\\|metadataurl_\\(?:format\\|href\\|type\\)\\|o\\(?:\\(?:nlineresourc\\|paqu\\)e\\)\\|postcode\\|r\\(?:e\\(?:mote_sld_max_bytes\\|s[xy]\\)\\|ootlayer_\\(?:abstract\\|keywordlist\\|title\\)\\)\\|s\\(?:ervice_onlineresource\\|rs\\|t\\(?:\\(?:ateorprovinc\\|yl\\)e\\)\\)\\|ti\\(?:me\\(?:default\\|extent\\|format\\|item\\)\\|tle\\)\\)\\)?\\)\\|xor\\)\\>" . font-lock-constant-face)))
       
  "Balls-out highlighting in MapServer mode.")

(defvar mapserver-mode-tab-width 4)
(defvar mapserver-font-lock-keywords mapserver-font-lock-keywords-3
  "Default highlighting expressions for MapServer mode.")

(defun mapserver-indent-line ()
  "Indent current line as MapServer code."
  (interactive)
  (beginning-of-line)
  (if (bobp)
      (indent-line-to 0)	   ; First line is always non-indented
    (let ((not-indented t) cur-indent)
	(if (looking-at "^[ \t]*END") ; If the line we are looking at is the end of a block, then decrease the indentation
	    (progn
	      (save-excursion
		(forward-line -1)
		(setq cur-indent (- (current-indentation) mapserver-mode-tab-width)))
	      (if (< cur-indent 0) ; We can't indent past the left margin
		  (setq cur-indent 0)))
	  (save-excursion
	    (while not-indented	; Iterate backwards until we find an indentation hint
	      (forward-line -1)
	      (if (looking-at "^[ \t]*END") ; This hint indicates that we need to indent at the level of the END_ token
		  (progn
		    (indent-according-to-mode)
		    (setq cur-indent (current-indentation))
		    (setq not-indented nil))
		;; CLASS FEATURE FONTSET GRID JOIN LAYER LEGEND MAP OUTPUTFORMAT POINTS PROJECTION QUERYMAP REFERENCE SCALEBAR STYLE WEB
		(if (or (looking-at "^SYMBOL$")
			(looking-at "^[ \t]*\\(CLASS$\\|COMPOSITE\\|FEATURE\\|FONTSET\\|GRID\\|JOIN\\|LABEL$\\|LAYER\\|LEGEND\\|MAP\\|METADATA\\|OUTPUTFORMAT\\|POINTS\\|PROJECTION\\|QUERYMAP\\|REFERENCE\\|SCALEBAR\\|SYMBOL$\\|SYMBOLSET\\|STYLE\\|WEB\\|VALIDATION\\)"))	; This hint indicates that we need to indent an extra level
		    (progn
		      (setq cur-indent (+ (current-indentation) mapserver-mode-tab-width)) ; Do the actual indenting
		      (setq not-indented nil))
		  (if (bobp)
		      (setq not-indented nil)))))))
    (if cur-indent
	(indent-line-to cur-indent)
      (indent-line-to 0))))) ; If we didn't see an indentation hint, then allow no indentation

(defvar mapserver-mode-syntax-table
  (let ((mapserver-mode-syntax-table (make-syntax-table)))

    ;; This is added so entity names with underscores can be more easily parsed
    (modify-syntax-entry ?_ "w" mapserver-mode-syntax-table)
    (modify-syntax-entry ?# "<" mapserver-mode-syntax-table)
    (modify-syntax-entry ?\n ">" mapserver-mode-syntax-table)
    

    mapserver-mode-syntax-table)
  "Syntax table for mapserver-mode")

(defun mapserver-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map mapserver-mode-map)
  (set-syntax-table mapserver-mode-syntax-table)
  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(mapserver-font-lock-keywords))
  ;; Register our indentation function
  (set (make-local-variable 'indent-line-function) 'mapserver-indent-line)
  (set (make-local-variable 'tab-width) mapserver-mode-tab-width)
  (setq major-mode 'mapserver-mode)
  (setq mode-name "MapServer")
  (run-hooks 'mapserver-mode-hook)
  (setq comment-start "#"))




(provide 'mapserver-mode)

;;; mapserver-mode.el ends here
