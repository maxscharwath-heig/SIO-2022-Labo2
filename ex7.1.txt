/*
 *  Modélisation du problème d'ordonnancement de tâches (Série 7 - Exercice 1, SIO, 2022-2023)
 */

/* Ensemble des tâches à exécuter */
set Jobs;

/* Dates de disponibilité des tâches */
param ReleaseDate{i in Jobs} >=0;

/* Dates d'échéance des tâches */
param DueDate{i in Jobs} >=0;

/* Temps d'exécution de chaque tâche */
param ProcessingTime{i in Jobs} >=0;

/* Constante (M) prenant la plus grande valeur des dates d'échéances */
param MaxDueDate := max{i in Jobs}DueDate[i];

/* Vérification minimale de la cohérence des données */
check{i in Jobs}: ReleaseDate[i] + ProcessingTime[i] <= DueDate[i];

/* Variable de décision (xi) de la date de début de l’exécution d'une tâche i */
var StartingDate{i in Jobs} >= 0;

/* Variable auxiliaire (t) représentant la date de fin maximale */
var MaxFinishDate >= 0;

/* Contrainte qui vérifie que la date de la variable auxilaire (t) soit postérieure à la durée d'exécution (xi + pi) de la tâche i */
subject to MaxFinishDateAfterProcess{i in Jobs}:
	MaxFinishDate >= StartingDate[i] + ProcessingTime[i];

/* Contrainte qui vérifie que la date de début (xi) est au moins en même temps que la date de disponibilité (ri) */
subject to StartAfterRelease{i in Jobs}:
	StartingDate[i] >= ReleaseDate[i];

/* Contrainte qui vérifie que l’exécution (xi + pi) de chaque tâche i se termine au plus tard à sa date d'échéance (di) */
subject to ExecBeforeDue{i in Jobs}:
	StartingDate[i] + ProcessingTime[i] <= DueDate[i];

/* Variable de décision binaire pour chaque paire {i, j} de tâches différentes, vaut 1 si i exécutée avant j sinon 0 */
var ExecutedBefore{(i,j) in Jobs cross Jobs}, binary;

/* Contrainte vérifiant que pour chaque paire {i, j} de tâches, 
   soit la tâche i termine son exécution avant que la tâche j ne débute soit c’est l’inverse. */
subject to ExecuteBefore1{(i,j) in Jobs cross Jobs: i < j}:
	StartingDate[i] + ProcessingTime[i] - StartingDate[j] <= MaxDueDate * (1 - ExecutedBefore[i, j]);

subject to ExecuteBefore2{(i,j) in Jobs cross Jobs: i < j}:
    StartingDate[j] + ProcessingTime[j] - StartingDate[i] <= MaxDueDate * ExecutedBefore[i, j];	


/* Fonction objectif */
minimize MinMaxFinishDate: 
	MaxFinishDate;

data;

param : Jobs : ReleaseDate DueDate ProcessingTime := 
  1   0   25  4
  2   3   25  9
  3   6   20  8;
 
############################################

# param : Jobs : ReleaseDate DueDate ProcessingTime := 
#   1   0   50  15
#   2   3   25  12
#   3   0   40   8
#   4   9   20   3
#   5  28   45   7;
 
end;
