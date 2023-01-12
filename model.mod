/*
 * SIO - Labo 2
 * Modélisation du problème d'ordonnancement de tâches
 *
 * Nicolas Crausaz  Maxime Scharwath
 */

/*
 * Ensembles et constantes
 */

/* Ensemble des tâches à exécuter */
set Tasks;

/* Ensemble des machines */
param NbMachines integer, >= 1;
set Machines, default {1..NbMachines};

/* Dates de disponibilité des tâches (ri) */
param ReleaseDate{i in Tasks} >=0;

/* Dates d'échéance des tâches (di) */
param DueDate{i in Tasks} >=0;

/* Temps d'exécution de chaque tâche (pi) */
param ProcessingTime{i in Tasks} >=0;

/* Constante (M) prenant la plus grande valeur du retard possible */
var MaxTardiness = max{i in Tasks}ReleaseDate[i] + sum{i in Tasks}ProcessingTime[i];


/*
 * Variables de décision
 */

/* Variable binaire (Uik) indiquant si la tâche i est exécutée sur la machine k */
var ExecutedOn{i in Tasks, k in Machines}, binary;

/* Variable de décision (xik) indiquant le temps de début d'exécution de la tâche i sur la machine k*/
param StartingDate{i in Tasks, k in Machines} >= 0; /* TODO: var */

/* (i,k) in Tasks cross Machines */

/* Variable de décision variable (Ti) correspondant au retard (tardiness) de la tâche i */
var TaskTardiness{i in Tasks} = max(0, sum{k in Machines}(StartingDate[i, k]) + ProcessingTime[i] - DueDate[i]);


/* ?? */
 /* check{i in Tasks}: ReleaseDate[i] + ProcessingTime[i] <= DueDate[i]; */





/* Fonction objectif */
minimize MeanTardiness: 
	sum{i in Tasks} TaskTardiness[i] / card(Tasks);

data;

param : Tasks : ReleaseDate DueDate ProcessingTime := 
  1   0   25  4
  2   3   25  9
  3   6   20  8;

param NbMachines := 4

 
############################################

# param : Tasks : ReleaseDate DueDate ProcessingTime := 
#   1   0   50  15
#   2   3   25  12
#   3   0   40   8
#   4   9   20   3
#   5  28   45   7;
 
end;
