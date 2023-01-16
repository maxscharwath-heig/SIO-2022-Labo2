/*
 * SIO - Labo 2
 * Modélisation du problème d'ordonnancement de tâches
 * sur machines parallèles
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
param MaxTardiness = max{i in Tasks}ReleaseDate[i] + sum{i in Tasks}ProcessingTime[i];


/*
 * Variables de décision
 */

/* Variable binaire (Uik) indiquant si la tâche i est exécutée sur la machine k */
var ExecutedOn{(i, k) in Tasks cross Machines}, binary;

/* Variable de décision (xik) indiquant le temps de début d'exécution de la tâche i sur la machine k*/
var StartingDate{(i, k) in Tasks cross Machines} >= 0; /* TODO: var */

/* Variable auxiliaire (Ti) correspondant au retard (tardiness) de la tâche i */
/* var TaskTardiness{i in Tasks} = max(0, sum{k in Machines}(StartingDate[i, k]) + ProcessingTime[i] - DueDate[i]); */

var TaskTardines{i in Tasks} >= 0;

/* 
 * Contraintes
 */

/* Une tâche i ne s'exécute que sur une seule machine k */

/* Contrainte vérifiant que pour chaque paire {i, j} de tâches, 
   soit la tâche i termine son exécution avant que la tâche j ne débute soit c’est l’inverse. */

/* Fonction objectif */
minimize MeanTardiness: 
	sum{i in Tasks} TaskTardiness[i] / card(Tasks);


solve;

printf "Ordonnancement \n\n";
for {k in Machines} {
  printf: "Machine %s:\n", k;
  for {i in Tasks} {
    printf{{0}: ExecutedOn[i,k] = 1} " Tâche %d | Début : %d\t| Fin : %d\t| Retard: %d\n", i, StartingDate[i], StartingDate[i] + ProcessingTime[i], JobTardiness[i];
   }
  printf "\n";
}


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
