/*Variable tableau*/
tabtemp([[2,3,1,2,2,3],[2,1,3,1,3,1],[1,3,2,3,1,2],[3,1,2,1,3,2],[2,3,1,3,1,3],[2,1,3,2,2,1]]).
t1([[['____',2],['____',3],['____',1],['____',2],['____',2],['____',3]],[['____',2],['____',1],['____',3],['____',1],['____',3],['____',1]],[['____',1],['____',3],['____',2],['____',3],['____',1],['____',2]],[['____',3],['____',1],['____',2],['____',1],['____',3],['____',2]],[['____',2],['____',3],['____',1],['____',3],['____',1],['____',3]],[['____',2],['____',1],['____',3],['____',2],['____',2],['____',1]]]).
t2([[['____',3],['____',1],['____',2],['____',2],['____',3],['____',1]],[['____',2],['____',3],['____',1],['____',3],['____',1],['____',2]],[['____',2],['____',1],['____',3],['____',1],['____',3],['____',2]],[['____',1],['____',3],['____',2],['____',2],['____',1],['____',3]],[['____',3],['____',1],['____',3],['____',1],['____',3],['____',1]],[['____',2],['____',2],['____',1],['____',3],['____',2],['____',2]]]).
t3([[['____',2],['____',2],['____',3],['____',1],['____',2],['____',2]],[['____',1],['____',3],['____',1],['____',3],['____',1],['____',3]],[['____',3],['____',1],['____',2],['____',2],['____',3],['____',1]],[['____',2],['____',3],['____',1],['____',3],['____',1],['____',2]],[['____',2],['____',1],['____',3],['____',1],['____',3],['____',2]],[['____',1],['____',3],['____',2],['____',2],['____',1],['____',3]]]).
t4([[['____',1],['____',2],['____',2],['____',3],['____',1],['____',2]],[['____',3],['____',1],['____',3],['____',1],['____',3],['____',2]],[['____',2],['____',3],['____',1],['____',2],['____',1],['____',3]],[['____',2],['____',1],['____',3],['____',2],['____',3],['____',1]],[['____',1],['____',3],['____',1],['____',3],['____',1],['____',2]],[['____',3],['____',2],['____',2],['____',1],['____',3],['____',2]]]).

/*ETAPE 1
Initialiser le tableau*/
 init(_,0,Q) :- !.
 init(C, L, [X|Q]) :- initLi(C, L, X),
					Temp is L-1,
					init(C, Temp, Q).
					
initLi(0, _, _) :- !.
initLi(C, L, [X|Q]) :- X is (((2*C)+L) mod 3) +1,
					Temp is C-1,
					initLi(Temp, L, Q).

/*Prédicat Initia UI*/					
initBoard(Board) :- init(6,6,Board).

/*Afficher le tableau

AFFICHAGE 1*/
	affiche1(_,0,_) :- !.
	affiche1(C, L,[X|Q]) :- 
						tab(3),
						afficheLi1(C, L,X),
						nl,
						Temp is L-1,
						affiche1(C,Temp,Q).
						
	afficheLi1(0, _, _) :- !.
	afficheLi1(C, L,[X|Q]) :- 
						write(X),
						write(`    `),
						Temp is C-1,
						afficheLi1(Temp, L, Q).
						
/*AFFICHAGE 2
	Explication : 
	Affiche le Cième element de la première à la dernière ligne de Board
	Quand L = 0 : condition d'arret :
	Recommence avec C-1 et L = Dim (fixé à 6 pour nous).*/

	affiche2(0, _, _, _,_ ) :- !.
	affiche2(C, 0, Dim, Board,_) :- 
					Temp is C-1,
					nl,
					tab(3),
					affiche2(Temp,Dim,Dim,Board,Board).
					
	affiche2(C, L, Dim, Board, [X|Q]) :-
					afficheElemI(C,L,X),
					Temp is L-1,
					affiche2(C, Temp,Dim,Board, Q).

	/*Explication : 
	Affiche le Cieme de la liste [X|Q] : pour l'instant L ne sert à rien ici */
		
	afficheElemI(0, L, _ ):- !.
	afficheElemI(1, L, [X|_]):- write(X), write(`    `). 
	afficheElemI(C, L,[X|Q]) :- 
					Temp is C-1,
					afficheElemI(Temp, L, Q),
					!.
						
/*AFFICHAGE 3
	Explication : 
	Affiche le (Dim-C +1)ème element de la dernière à la première ligne de Board.
	Quand L = 0 : condition d'arret :
	Recommence avec C-1 et L = Dim (fixé à 6 pour nous).*/

	affiche3Bis(0, 0, _, _) :- !.
	affiche3Bis(C, 0, Dim, _) :- !.
					
	affiche3Bis(C, L, Dim, [X|Q]) :-
					Temp is L-1,
					affiche3Bis(C, Temp,Dim, Q),
					Elem is (Dim - C +1),
					afficheElemI(Elem,L,X).
					
	affiche3(0, _, _ ,_  ):- !.				
	affiche3(C, L, Dim, Board) :- 
					tab(3),
					affiche3Bis(C, L, Dim, Board ),
					Temp is C-1,
					nl,
					affiche3(Temp, L, Dim, Board).
			
/*AFFICHAGE 4*/
	affiche4(_,0,_) :- !.
	affiche4(C,L,[X|Q]) :- 
					Temp is L-1,
					affiche4(C,Temp,Q),
					tab(3),
					afficheLi4(C, Temp,X),
					nl.
						
	afficheLi4(0, _, _) :- !.
	afficheLi4(C, L,[X|Q]) :- 
					Temp is C-1,
					afficheLi4(Temp, L, Q),
					write(X),
					write(`    `).
						


/*Choix de position*/
					
position( Board, 1) :- affiche1(6,6,Board), tab(3),
					write('-----------YOU----------- '), nl, nl, !.
position( Board, 2) :- tab(3),affiche2(6,6,6,Board,Board),tab(3),
					write('-----------YOU----------- '), nl, nl, !.
position( Board, 3) :- affiche3(6,6,6,Board),tab(3),
					write('-----------YOU----------- '), nl, nl, !.
position( Board, 4) :- affiche4(6,6,Board),tab(3),
					write('-----------YOU----------- '), nl, nl, !.

/*Initialisation de la structure choisie*/					
choixPosition(_,1,1,Board) :- t1(Board),!.
choixPosition(_,1,2,Board) :- t2(Board),!.
choixPosition(_,1,3,Board) :- t3(Board),!.
choixPosition(_,1,4,Board) :- t4(Board),!.	
		
choixPosition(Temp,0,P,Board):- 
					write('Choisir une position : 1,2,3,4'),
					nl, tab(10),
					write('---4---'),
					nl, tab(10),
					write('2-----3'),
					nl, tab(10),
					write('---1---'),
					nl, 
					write('Votre choix :    '),
					read(P), nl, 
					position(Temp, P),
					write('Confirmer le choix : Oui(1) / Non(0)'),nl,
					read(C),nl,
					choixPosition(Temp,C,P,Board).
					
/*Insertion des pièces par le joueur Humain*/

majCoups(Board,Ns,Nk, 'kalR'):-Temp is (Nk-1), majPlacement(Board,Ns,Temp,Res).
majCoups(Board,Ns,Nk,'sbiR'):-Temp is (Ns-1), majPlacement(Board, Temp, Nk,Res).

/*Verif choix valide*/
verifC(C,C) :- C>2, C<7, true, ! .     
verifC(C,C2) :-  write('---ERROR Colonne entre 1 et 6'),nl,write('Colonne choisie  [1..6] ? '), read(C2),nl,verifC(C2,C3).
verifL(L,L) :- L>2, L<7, true, !.
verifL(L,L2) :- write('---ERROR Ligne entre 5 et 6'),nl,write('Ligne choisie  [5 ou 6] ? '), read(L2),nl,verifL(L2,L3).

verifPiName('kalR','kalR') :- true,!. 
verifPiName('sbiR','sbiR') :- true,!. 
verifPiName(Pi,Pi2) :- write('---ERROR '),write(Pi), write(' n est pas un nom autorise.'),nl,write('---Placement de Sbire (sbiR) ou de Kalista (kalR) ?'), read(Pi2),nl,verifPiName(Pi2,Pi3). 

verifPi('kalR',Ns,0,Pi2) :- write('---ERROR Vous n avez plus de kalista disponible'),nl,write('---Placement de Sbire (sbiR) ou de Kalista (kalR) ?'), read(Pi2),nl,verifPiName(Pi2,Pi3),nl,verifPi(Pi3,Ns,0,Pi4),!.     
verifPi('sbiR',0,Nk,Pi2) :- write('---ERROR Vous n avez plus de sbires disponible'),nl,write('---Placement de Sbire (sbiR) ou de Kalista (kalR) ?'), read(Pi2),nl,verifPiName(Pi2,Pi3),nl,verifPi(Pi3,0,Nk,Pi4),!.     
verifPi(Pi,Ns,Nk,Pi) :- true.

insertPiece3([T|Q], Piece, [Piece|Q]) :- !.

insertPiece2(1, Piece , [T2|Q2], [Res|Q2]):- insertPiece3(T2, Piece, Res) , !.		
insertPiece2(C, Piece, [T2|Q2], [T2|Res]):-
					Temp is C-1,
					insertPiece2(Temp, Piece, Q2, Res).

insertPiece(C,1, Piece, [T1|Q1], [Res|Q1]):- insertPiece2(C,Piece, T1, Res), !.	
insertPiece(C, L , Piece, [ T1| Q1] , [T1|Res]) :-
					TempLi is L-1,
					insertPiece(C, TempLi,Piece, Q1, Res ).


teteCase3([T|Q], T):-!.
					
teteCase2([T|Q], 1, Res):- teteCase3(T, Res).
teteCase2([T|Q], C, Res) :-
					Temp is C-1,
					teteCase2(Q,Temp, Res).
					
teteCase([T|Q],C,1,Res) :- teteCase2(T,C,Res), !.

teteCase([T|Q],C,L,Res) :-
					Temp is L-1,
					teteCase(Q, C, Temp, Res).
					

/*Ns : nbre de sbire restant à positionner, Nk nombre de Kalista.*/					
majPlacement(Board,0,0,Board):- write('---Placement terminé.'), nl, nl, nl, write('---La partie commence !').
majPlacement(Board,Ns, Nk,Res):-
					write('---Il vous reste '), write(Ns), write(' /5 sbires et '), write(Nk), write(' /1 Kalista a placer ... '),nl,
					write('---Placement de Sbire (sbiR) ou de Kalista (kalR) ?'), read(Pi),nl,verifPiName(Pi,Pi2),nl,verifPi(Pi2,Ns,Nk,Pi3),nl,
					write('Colonne choisie  [1..6] ? '), read(C),nl,verifC(C,C2),
					write('Ligne choisie  [5 ou 6 ] ?'), read(L),nl,verifL(L,L2),nl, nl,
					insertPiece(C2,L2,Pi,Board,Res),
					affiche1(6,6,Res),nl,nl,nl,
					majCoups(Res,Ns,Nk,Pi3).
					

majPlacementComput(Board,Res) :-
					insertPiece(2,1,'sbiO',Board,Res1),
					insertPiece(3,1,'sbiO',Res1,Res2),
					insertPiece(4,1,'kalO',Res2,Res3),
					insertPiece(5,1,'sbiO',Res3,Res4),
					insertPiece(3,2,'sbiO',Res4,Res5),
					insertPiece(4,2,'sbiO',Res5,Res).
											

						
					
/*Prédicat UI*/


afficheBoard(Board):- 
					tabtemp(Temp),
					nl,
					affiche1(6,6,Temp),
					tab(3),
					write('-----------YOU----------- '), nl, nl,
					choixPosition(Temp,0,_,Temp1),
					majPlacementComput(Temp1,Temp2),
					affiche1(6,6,Temp2),nl, nl,
					teteCase(Temp2,2,1,Res),write(Res),
					write('---Joueur ocre (ordinateur) à placé ses pièces.'),write(' A vous :'),nl,
					write('---Insertion des pièces ...   '), nl,nl,
					write('Vous êtes le joueur : '), write('Rouge.'),nl,nl,
					majPlacement(Temp2,5,1,Board),
					write('--- A vous de jouer :'),
					write('Colonne choisie  [1..6] ? '), read(C),nl,
					write('Ligne choisie  [1..6 ] ?'), read(L),nl, nl, nl.
					
/*possibleMoves(Board,'ocre',PossibleMoveList) :- 
					parcour(listpionRou).
possibleMoves(Board,'rouge',PossibleMoveList) :- .


TODO :	

Coups possibles : 
	Pour tout les noeuds de la liste de Pion d'un joueur 
		- numCase(C, L, nCase)
		- move?(C, L, history, nCase, listMove)
			- notMember(C, L, history),
			- dispo(C-1, L, nCase, listMove), 
			- dispo(C+1, L, nCase, listMove),
			- dispo(C, L+1, nCase, listMove),
			- dispo(C, L-1, nCase, listMove),
			

	dispo(C, L, nCase, listMove) :-  teteCase(C,L, Res), verifTete(Res), Temp is nCase-1 , move(C, L, nCase, [[C,L],listMove])
		



majPlacement :
	+ Sauvegarde de la position de la pièce dans une liste correspondant à tous les pions d'un joueur donné : 
		+ PionRou [ [C, L, Piece, NumCase, [ ...  coup dispo ...]] , [C, L, Piece, NumCase], [..], .... ]
		+ PionOcr [ [C, L, Piece, NumCase] , [C, L, Piece, NumCase], [..], .... ]
	
		
+deletePiece :
	+ Lors d'un coup joué, retire l'ancien pion de la liste de Pion puis ajoute le nouveau (nouvelle position).
	+ Tableau est réinitialisé avec les deux listes de pions (plus simple que de parcourir le tableau ... retirer la piece ... et remettre une autre)
	



[ [ KaR | 2 ], [ [ 1, 4], _ ] ]
[ [ sbiR | 2 ], [ [ 2, 4], _ ] ] 
[ [ sbiR | 1 ], [ [ 2, 4], _ ] ] 

*/