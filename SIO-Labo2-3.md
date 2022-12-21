---
title: Ordonnancement sur machines parallèles
subtitle: SIO - Laboratoire 2
author: Nicolas Crausaz & Maxime Scharwath
date: 21.12.2022
geometry: "left=2.54cm,right=2.54cm,top=2.54cm,bottom=2.54cm"
toc: yes
toc-own-page: true
titlepage: true
titlepage-rule-height: 1
header-left: "\\headerlogo"
header-center: "Rapport"
lang: "fr"
table-use-row-colors: false
listings-no-page-break: true
include-before:
- '`\newpage{}`{=latex}'
header-includes:
    - \usepackage[most]{tcolorbox}
    - \definecolor{blue}{rgb}{0.1, 0.7, 0.8}
    - \newtcolorbox{myquote}{colback=blue,grow to right by=-10mm,grow to left by=-10mm, boxrule=0pt,boxsep=0pt,breakable}
    - \newcommand{\blueQuote}[1]{\begin{myquote} \textbf{} \emph{#1} \end{myquote}}
    - |
      ```{=latex}
      \newcommand{\headerlogo}{\includegraphics[width=1.3cm]{assets/heig.png}}
      ```
---
# Modélisation du problème

## On définit les variables de décision, réelles et non négatives
xij = date de début de l'execution de la tâche i sur une machine j, i=1,...,n et j=1,...,m

On connaît les constantes suivantes:
- sa date de disponibilité (date de début au plus tôt, release date) ri
- sa date d'échéance (date de fin au plus tard, due date) di
- son temps d'exécution (durée de réalisation, processing time) pi

On defini le retard (tardiness) Ti de la tâche i par
- Ti = max(0, xi + pi - di), i=1,...,n

### L’objectif consiste à trouver un ordonnancement minimisant le retard moyen (mean tardiness)

Minimiser z = 1/n Somme i=1 à n de Ti

## On défini les contraintes suivantes

- xij > ri, i=1,...,n et j=1,...,m <=> l'exécution de chaque tâche ne peut commencer avant sa date de disponibilité.

## On défini les variables binaires suivantes
- yij pour chaque paire {i,j} de tâche sur machine
  yij = 1 si la tâche i est executé sur la machine j, 0 sinon.

- 