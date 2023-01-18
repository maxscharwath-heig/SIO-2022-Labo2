/*
 * SIO - Labo 2
 * Modélisation du problème d'ordonnancement de tâches sur machines parallèles
 * 
 * Nicolas Crausaz et Maxime Scharwath
 * 17.01.2023
 */

/*
 * Définition des ensembles et constantes
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
param MaxTardiness := max{i in Tasks}ReleaseDate[i] + sum{i in Tasks}ProcessingTime[i];


/*
 * Variables de décision
 */

/* Variable binaire (uik) indiquant si la tâche i est exécutée sur la machine k */
var ExecutedOn{(i, k) in Tasks cross Machines}, binary;

/* Variable de décision (xik) indiquant le temps de début d'exécution de la tâche i sur la machine k*/
var StartingDate{(i, k) in Tasks cross Machines} >= 0;

/* Variable auxiliaire (Ti) correspondant au retard (tardiness) de la tâche i */
var TaskTardiness{i in Tasks} >= 0;

/* Variable de décision binaire (yij) pour chaque paire {i, j} de tâches différentes */
var ExecutedBefore{(i,j) in Tasks cross Tasks}, binary;

/* 
 * Contraintes
 */

/* Une tâche i ne s'exécute que sur une seule machine k */
subject to OnlyExecutedOnce{i in Tasks}:
  sum{k in Machines}ExecutedOn[i, k] = 1;

/* Le retard d'une tâche i (Ti) s'exécutant sur une machine k est postérieur à sa durée d'exécution moins son écheance */
subject to MaxTaskTardiness{i in Tasks}:
  TaskTardiness[i] >= sum{k in Machines}(StartingDate[i, k]) + ProcessingTime[i] - DueDate[i];

/* Une tâche i ne peut pas commencer avant que la tâche soit disponible */
subject to StartAfterRelease{(i,k) in Tasks cross Machines}:
  StartingDate[i, k] >= ReleaseDate[i] * ExecutedOn[i,k];

/* Contraintes vérifiant que pour chaque paire {i, j} de tâches, 
   soit la tâche i termine son exécution avant que la tâche j ne débute soit c’est l’inverse. */
subject to ExecuteIBeforeJOnK{(i,j) in Tasks cross Tasks, k in Machines: i < j}:
  StartingDate[i, k] + ProcessingTime[i] - StartingDate[j, k] <= MaxTardiness * (3 - ExecutedBefore[i, j] - ExecutedOn[i,k] - ExecutedOn[j,k]);

subject to ExecuteJBeforeIOnK{(i,j) in Tasks cross Tasks, k in Machines: i < j}:
  StartingDate[j, k] + ProcessingTime[j] - StartingDate[i, k] <= MaxTardiness * (2 + ExecutedBefore[i, j] - ExecutedOn[i,k] - ExecutedOn[j,k]);


/* 
 *  Fonction objectif
 */
minimize MeanTardiness: 
	sum{i in Tasks} TaskTardiness[i] / card(Tasks);


solve;

/*
 * Affichage du résultat
 */

printf "\n\nOrdonnancement minimisant le retard moyen \n";
for {k in Machines} {
  printf: "--- \n Machine %s:\n", k;
  for {i in Tasks} {
    printf{{0}: ExecutedOn[i,k] = 1}  " Tâche %d\t  Début : %d\t Fin : %d\t Retard: %d\n", i, StartingDate[i, k], StartingDate[i, k] + ProcessingTime[i], TaskTardiness[i];
  }
}
printf "\nRetard moyen %s et retard total: %s \n", MeanTardiness, MeanTardiness * card(Tasks);
printf "Valeur de la constante Max Tardiness (M) = %s \n", MaxTardiness;


data;

/* Choix du nombre de machines */
param NbMachines := 2;

/* Jeu de données 1 */
param : Tasks : ReleaseDate DueDate ProcessingTime :=
  1   25   50   15
  2   3    25   20
  3   28   45   10
  4   23   40   15
  5   0    20   11
  6   17   29   9
  7   0    32   16
  8   41   50   5;

/* Jeu de données 2 */
/*
param : Tasks : ReleaseDate DueDate ProcessingTime :=
  1   0    37   16
  2   11   53   26
  3   0    39   25
  4   20   33   7
  5   9    32   20
  6   0    28   9
  7   4    34   25;

*/