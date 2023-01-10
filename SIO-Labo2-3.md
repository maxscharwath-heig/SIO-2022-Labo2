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
# Modélisation mathématique

Le contexte de ce travail est d'effectuer la modélisation d'un problème d'ordonnancement, consistant à trouver un plan d'ordonnancement permettant de répartir n tâches, devant toutes être réalisée, en disposant de m machines différentes (travail en parrallèle), cela en minimisant le retard moyen de l'éxécution des tâches.

Nous connaissons les constantes suivantes:

Pour chaque tâche $i = 1,...,n$:

- Sa date de disponibilité (date de début au plus tôt, release date) $r_i$

- Sa date d’échéance (date de fin au plus tard, due date) $d_i$

- Son temps d’exécution (durée de réalisation, processing time) $p_i$

On supposera, sans perte de généralité, que la plus petite date de disponibilité est égale à 0 et que les données sont cohérentes et vérifient, en particulier, $r_i >= 0$ et $p_i >= 0$ pour chaque tâche $i = 1,..,n$.

## Définition des variables de décision

Nous définissons les variables de décision suivantes:

$x_i$ : date de début de l'execution de la tâche $i$, $i=1,...,n$.

L’exécution de chaque tâche i ne peut commencer avant sa date de disponibilité $r_i$:

$x_i >= r_i$, pour tout i

## Définition des variables auxiliaires

On defini le retard (tardiness) Ti de la tâche i par
- $T_i = {\displaystyle \max_{i=1,...,n} (0, x_i + p_i - d_i)}$

- $e_{ij}$ : indique si la tache i s'execute sur la machine j, $i=1,...,n$, $j=1,...,m$

$$
e_{ij} = \left\{
    \begin{array}{ll}
        1 & \text{si la tâche $i$ est executé sur la machine $j$} \\
        0 & \text{sinon.}
    \end{array}
\right.
$$

## Définition de la fonction objectif

Minimiser $z= {\displaystyle \frac{1}{n}\sum_{i=1}^{n} T_i}$

## Définition des contraintes

- Une tâche n'est executé qu'une seule fois et sur une unique machine

  ${\displaystyle \sum_{i=1}^{n}}e_{ij} = 1 \qquad j=1,...,m$

L'exécution de chaque tâche ne peut commencer avant sa date de disponibilité.

- La tâche suivante doit être exécuté après la date de fin + le retard de la tâche précédente si les taches i et j sont sur la même machine

Disjonction:

On introduit une variable binaire $y_{ij}$ pour chaque paire $\{i,j\}$ de tâches différentes sur une même machine et dont l'interprétation est:

$$
y_{ij} = \left\{
    \begin{array}{ll}
        1 & \text{si la tâche $i$ est executé avant la tâche $j$ sur la même machine} \\
        0 & \text{sinon.}
    \end{array}
\right.
$$

Ainsi on a pour tout couple de tâche $\{i,j\}$

  $x_i + p_i + T_i − x_j <= M(1 − y_{ij})$

  $x_j + p_j + T_j − x_i <= M y_{ij}$

  $\qquad i=1,...,n, j=1,...,m$

multiplier par $e_{ij}$


// TODO: il faut trouver comment ajouter à la disjonction comment appliquer uniquement ces deux contraintes seulement si i et j sont sur la même machine

meme machine = ei1 + ej1 = 2



pour chaque paire {i, j} de tâches différentes SI elle sont sur la même machine
  , soit la tâche i termine son exécution
  avant que la tâche j ne débute la sienne soit c’est l’inverse


Non négativité de $T_i$, $x_i$






-----

kdo de noel de $JF_{heche}$: 

Uik: 1 si tache i s'execute sur machine k, 0 sinon
Pour une paire {i,j} de tache que vaut 2-Uik-Ujk ?

Xik = date de debut de i sur k si i est executé sur k, 0 sinon

Contrainte Xik = 0 si Uik = 0:

xik <= M * Uik

i ne debute pas son execution avant sa date

Xik > ri * Uik k = 1 à m ( car r1 est une constante )

décision: où et quand

----