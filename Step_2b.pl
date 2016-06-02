
/*Variable tableau*/
tabtemp([[2,3,1,2,2,3],[2,1,3,1,3,1],[1,3,2,3,1,2],[3,1,2,1,3,2],[2,3,1,3,1,3],[2,1,3,2,2,1]]).
t1([[('____',2),('____',3),('____',1),('____',2),('____',2),('____',3)],[('____',2),('____',1),('____',3),('____',1),('____',3),('____',1)],[('____',1),('____',3),('____',2),('____',3),('____',1),('____',2)],[('____',3),('____',1),('____',2),('____',1),('____',3),('____',2)],[('____',2),('____',3),('____',1),('____',3),('____',1),('____',3)],[('____',2),('____',1),('____',3),('____',2),('____',2),('____',1)]]).
t2([[('____',3),('____',1),('____',2),('____',2),('____',3),('____',1)],[('____',2),('____',3),('____',1),('____',3),('____',1),('____',2)],[('____',2),('____',1),('____',3),('____',1),('____',3),('____',2)],[('____',1),('____',3),('____',2),('____',2),('____',1),('____',3)],[('____',3),('____',1),('____',3),('____',1),('____',3),('____',1)],[('____',2),('____',2),('____',1),('____',3),('____',2),('____',2)]]).
t3([[('____',2),('____',2),('____',3),('____',1),('____',2),('____',2)],[('____',1),('____',3),('____',1),('____',3),('____',1),('____',3)],[('____',3),('____',1),('____',2),('____',2),('____',3),('____',1)],[('____',2),('____',3),('____',1),('____',3),('____',1),('____',2)],[('____',2),('____',1),('____',3),('____',1),('____',3),('____',2)],[('____',1),('____',3),('____',2),('____',2),('____',1),('____',3)]]).
t4([[('____',1),('____',2),('____',2),('____',3),('____',1),('____',2)],[('____',3),('____',1),('____',3),('____',1),('____',3),('____',2)],[('____',2),('____',3),('____',1),('____',2),('____',1),('____',3)],[('____',2),('____',1),('____',3),('____',2),('____',3),('____',1)],[('____',1),('____',3),('____',1),('____',3),('____',1),('____',2)],[('____',3),('____',2),('____',2),('____',1),('____',3),('____',2)]]).

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
						write('[ '),write(X),write(' ]'),
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

majCoups(Board,Ns,Nk, 'kalR', ListPreli, Res):-Temp is (Nk-1), majPlacement(Board,Ns,Temp,Res, ListPreli, ListJoueurRouge).
majCoups(Board,Ns,Nk,'sbiR', ListPreli, Res):-Temp is (Ns-1), majPlacement(Board, Temp, Nk,Res, ListPreli, ListJoueurRouge).

/*Verif choix valide*/
verifC(C,C) :- C>0, C<7, true, ! .     
verifC(C,C2) :-  write('---ERROR Colonne entre 1 et 6'),nl,write('Colonne choisie  [1..6] ? '), read(C2),nl,verifC(C2,C3).
verifL(L,L) :- L>4, L<7, true, !.
verifL(L,L2) :- write('---ERROR Ligne entre 5 et 6'),nl,write('Ligne choisie  [5 ou 6] ? '), read(L2),nl,verifL(L2,L3).

verifPiName('kalR','kalR') :- true,!. 
verifPiName('sbiR','sbiR') :- true,!. 
verifPiName(Pi,Pi2) :- write('---ERROR '),write(Pi), write(' n est pas un nom autorise.'),nl,write('---Placement de Sbire (sbiR) ou de Kalista (kalR) ?'), read(Pi2),nl,verifPiName(Pi2,Pi3). 

verifPi('kalR',Ns,0,Pi2) :- write('---ERROR Vous n avez plus de kalista disponible'),nl,write('---Placement de Sbire (sbiR) ou de Kalista (kalR) ?'), read(Pi2),nl,verifPiName(Pi2,Pi3),nl,verifPi(Pi3,Ns,0,Pi4),!.     
verifPi('sbiR',0,Nk,Pi2) :- write('---ERROR Vous n avez plus de sbires disponible'),nl,write('---Placement de Sbire (sbiR) ou de Kalista (kalR) ?'), read(Pi2),nl,verifPiName(Pi2,Pi3),nl,verifPi(Pi3,0,Nk,Pi4),!.     
verifPi(Pi,Ns,Nk,Pi) :- true.

placeLibre(C,L, C, L):- \+rouge(C,L), \+ocre(C,L), true.
placeLibre(C,L, Cok, Lok):- write('Place occupée :'), nl, write('Colonne choisie  [1..6] ? '), read(C2),nl,verifC(C2,C3), write('Ligne choisie  [5 ou 6 ] ?'), read(L2),nl,verifL(L2,L3),nl, nl,placeLibre(C3,L3, Cok, Lok).

insertPiece3((T1,Q1), Piece, (Piece,Q1)) :- !.

insertPiece2(1, Piece , [T2|Q2], [Res|Q2]):- insertPiece3(T2, Piece, Res) , !.		
insertPiece2(C, Piece, [T2|Q2], [T2|Res]):-
					Temp is C-1,
					insertPiece2(Temp, Piece, Q2, Res).

insertPiece(C,1, Piece, [T1|Q1], [Res|Q1]):- insertPiece2(C,Piece, T1, Res), !.	
insertPiece(C, L , Piece, [ T1| Q1] , [T1|Res]) :-
					TempLi is L-1,
					insertPiece(C, TempLi,Piece, Q1, Res ).


teteCase3((T1,Q1), T1):-!. 
					
teteCase2([T|Q], 1, Res):- teteCase3(T, Res).
teteCase2([T|Q], C, Res) :-
					Temp is C-1,
					teteCase2(Q,Temp, Res).
					
teteCase([T|Q],C,1,Res) :- teteCase2(T,C,Res), !.

teteCase([T|Q],C,L,Res) :-
					Temp is L-1,
					teteCase(Q, C, Temp, Res).
							
numCase3((T1,Q1) , Q1):- ! .
numCase2([T|Q], 1, Res):- numCase3(T, Res).
numCase2([T|Q], C, Res) :-
					Temp is C-1,
					numCase2(Q,Temp, Res).
					
numCase([T|Q],C,1,Res):- numCase2(T,C,Res), !.

numCase([T|Q],C,L,Res):-
					Temp is L-1,
					numCase(Q, C, Temp, Res).
					
					
insertListeJoueur(C,L, Pi, N, [], [ (C,L,Pi,N,[]) | [] ] ):- !.				
insertListeJoueur(C,L, Pi, N, List, [ (C, L, Pi, N, [] ) | List ] ):-!.	
					

/*Ns : nbre de sbire restant à positionner, Nk nombre de Kalista.*/					
majPlacement(Board,0,0,Board, ListJoueurRouge, ListJoueurRouge):- write('---Placement terminé.'), nl, nl, nl, write('---La partie commence !'),nl,nl.
majPlacement(Board,Ns, Nk,Res, Tmp, ListJoueurRouge):-
					write('votre placement :'), write(Tmp), nl , nl,
					write('---Il vous reste '), write(Ns), write(' /5 sbires et '), write(Nk), write(' /1 Kalista a placer ... '),nl,
					write('---Placement de Sbire (sbiR) ou de Kalista (kalR) ?'), read(Pi),nl,verifPiName(Pi,Pi2),nl,verifPi(Pi2,Ns,Nk,Pi3),nl,
					write('Colonne choisie  [1..6] ? '), read(C),nl,verifC(C,C2),
					write('Ligne choisie  [5 ou 6 ] ?'), read(L),nl,verifL(L,L2),nl, nl,placeLibre(C2,L2, C3, L3),
					insertPiece(C3,L3,Pi3,Board,Res1), numCase(Res1, C3,L3, N),  insertListeJoueur(C3,L3,Pi3,N, Tmp, Tmp2), assertz(rouge(C3,L3)),assertz(pion(C3,L3)),
					affiche1(6,6,Res1),nl,nl,nl,
					majCoups(Res1,Ns,Nk,Pi3,Tmp2,Res).
					

majPlacementComput(Board,Res, ListJoueurOcre) :-
					insertPiece(2,1,'sbiO',Board,Res1), numCase(Res1, 2,1, N),  insertListeJoueur(2,1,'sbiO',N, [], Tmp), asserta(ocre(2,1)), assertz(pion(2,1)),
					insertPiece(3,1,'sbiO',Res1,Res2), numCase(Res2, 3,1, N1), insertListeJoueur(3,1,'sbiO',N1, Tmp, Tmp1), assertz(ocre(3,1)), assertz(pion(3,1)),
					insertPiece(4,1,'kalO',Res2,Res3), numCase(Res3, 4,1, N2), insertListeJoueur(4,1,'kalO',N2, Tmp1, Tmp2), assertz(ocre(4,1)),assertz(pion(4,1)),
					insertPiece(5,1,'sbiO',Res3,Res4), numCase(Res4, 5,1, N3), insertListeJoueur(5,1,'sbiO',N3, Tmp2, Tmp3), assertz(ocre(5,1)), assertz(pion(5,1)),
					insertPiece(3,2,'sbiO',Res4,Res5), numCase(Res5, 3,2, N4), insertListeJoueur(3,2,'sbiO',N4, Tmp3, Tmp4), assertz(ocre(3,2)), assertz(pion(3,2)),
					insertPiece(4,2,'sbiO',Res5,Res), numCase(Res,4,2, N5), insertListeJoueur(4,2,'sbiO',N5, Tmp4, ListJoueurOcre), assertz(ocre(4,2)), assertz(pion(4,2)).

majPlacementHumain(Board,Res, ListJoueurRouge) :-
					insertPiece(2,5,'sbiR',Board,Res1), numCase(Res1, 2,5, N),  insertListeJoueur(2,5,'sbiR',N, [], Tmp), asserta(rouge(2,5)), assertz(pion(2,5)),
					insertPiece(3,5,'sbiR',Res1,Res2), numCase(Res2, 3,5, N1), insertListeJoueur(3,5,'sbiR',N1, Tmp, Tmp1), assertz(rouge(3,5)), assertz(pion(3,5)),
					insertPiece(4,5,'kalR',Res2,Res3), numCase(Res3, 4,5, N2), insertListeJoueur(4,5,'kalR',N2, Tmp1, Tmp2), assertz(rouge(4,5)),assertz(pion(4,5)),
					insertPiece(5,5,'sbiR',Res3,Res4), numCase(Res4, 5,5, N3), insertListeJoueur(5,5,'sbiR',N3, Tmp2, Tmp3), assertz(rouge(5,5)), assertz(pion(5,5)),
					insertPiece(3,6,'sbiR',Res4,Res5), numCase(Res5, 3,6, N4), insertListeJoueur(3,6,'sbiR',N4, Tmp3, Tmp4), assertz(rouge(3,6)), assertz(pion(3,6)),
					insertPiece(4,6,'sbiR',Res5,Res), numCase(Res,4,6, N5), insertListeJoueur(4,6,'sbiR',N5, Tmp4, ListJoueurRouge), assertz(rouge(4,6)), assertz(pion(4,6)).

					
possibleMoves(_, ListJoueur, PossibleMoveList):-
					derouler(ListJoueur, PossibleMoveList).


					
/*Parcourt de list de pion du joueurs en questions*/
derouler( [], [] ).
derouler( [ ( C, L, _ , N, _ ) |Q], [ ( (C, L), M ) |Res] ):-
					asserta(history([])),
					possibilities(N, C, L, M1),
					retire_doublons(M1,M),
					derouler(Q, Res).
					
					
/*Lance une recherche sur les 4 positions autour du pions considéré : possibilities retourne une liste composée de tous les moves possible*/			
possibilities(1, C, L, M):- 
					history(H),
					Cplus is C+1, Cmoins is C-1, Lplus is L+1, Lmoins is L-1,
					tryMove(Cplus, L, H, M4), tryMove(Cmoins, L, H, M1), tryMove(C, Lplus, H, M2), tryMove(C, Lmoins, H, M3), 
					append(M4,M1,Res), 
					append(M2,M3, Res2), 
					append(Res, Res2, M).

possibilities(N, C, L, M):-
					history(H),
					Tmp is N-1,
					possibilities(Tmp, C, L, Res),
					reload( Res,M).
					
			
					
/*Relance la recherche pour les nouveaux emplacements trouvés autour du pion X considéré en prenant comme historique X */					
reload(  [] , [] ).
reload([ (C,L)| Q ], M ):-
					asserta(history((C,L))),
					possibilities(1, C, L, Res),
					retract(history((C,L))),
					reload(Q,Tmp),
					append(Tmp, Res, M).
	
/* Try Move renvoie une liste si le move est possible et une liste vide sinon : Cela permet de ne pas arreter la recherche si fail*/
tryMove( C, L, H, [ (C, L) ]):-
					C>0, 
					C<7,
					L>0,
					L<7,
					\+pion(C,L),
					\+element((C,L) , H).


tryMove( C, L, _, []).
					
element( X, [X|Q]).
element( X, [T|Q]):- element(X, Q).

retire_elements(_, [], []).
retire_elements(X, [X|Q], Res):-retire_elements(X,Q,Res),!.
retire_elements(X, [T|Q], [T|Res]):- retire_elements(X, Q, Res).

retire_doublons([], []).
retire_doublons([T|Q], [T|R]):-
			retire_elements(T,Q,Res),
			retire_doublons(Res,R).

/*En fonction de l'etat du jeu : donne tous les pions disponible et leurs possible New Mouvement*/
donneChoix([], []).
donneChoix( [ ((C,L), M) |Q], [ pion(C,L) |Res] ):- donneChoix(Q, Res).

donneChoixNew((_,_), [], []).
donneChoixNew((C,L), [ ((C,L), M) |Q], M):-!.
donneChoixNew((C,L), [ ((C1,L1), M) |Q], Res):- 
			donneChoixNew(X, Q,Res). 

verifChoix(C,L, ChoixPosition, C, L):-	
			element(pion(C,L), ChoixPosition), true,!.
			
verifChoix(C,L, ChoixPosition, Cbis, Lbis):-
			write('Error : vous ne possédez pas de pions  à cet emplacement'), 
			varPossibleMoveRouge(PossibleMoveList),
			donneChoix(PossibleMoveList, ChoixPosition),
			write(ChoixPosition), nl,nl,
			write('Colonne:- [1..6] ? '), read(C2),nl, 
			write('Ligne:-  [1..6 ] ?'), read(L2),nl, nl, verifChoix(C2,L2, ChoixPosition, Cbis, Lbis).


			
/* Boucle de jeu */ 			
gagner(0).


boucleJeu:-repeat, jeu, !.
jeu:- 
	/*On intialise avec le bon tableau*/
	tableau(Board), 
	/*On détruit l'ancien*/
	retractall(tableau(_)),
	/*On recupere les moves disponibles*/
	varPossibleMoveRouge(PossibleMoveList),
	write(PossibleMoveList),
	/*On détruit les anciens*/
	retractall(varPossibleMoveRouge(_)),
	
	
	write('--- A vous de jouer :'),nl,
	affiche1(6,6,Board),nl,nl,
	nl, write('---Veuillez choisir un pion à déplacer:'),nl,
	donneChoix(PossibleMoveList, ChoixPosition),
	write(ChoixPosition), nl,nl,
	write('Colonne:-  [1..6] ? '), read(C),nl, 
	write('Ligne:-  [1..6 ] ?'), read(L),nl, nl, 	verifChoix(C,L, ChoixPosition, Cbis, Lbis),
	write('---Vous pouvez choisir parmis ces positions'),nl,nl,
	donneChoixNew((C,L),PossibleMoveList, ChoixNewPositions),
	write(ChoixNewPositions),
	read(NewPosition),
	
	
	/*On remet le nouveu tableu en var dynamique*/
	asserta(tableau(Board)),
	/*On remet les nouveau moove disponible en var dynamique : Attention : deja fait dans le predicat possibleMove */
	asserta(varPossibleMoveRouge(PossibleMoveList)),
	
	gagner(jeu), jeu = 1, nl.

	
/*Prédicat UI*/
					
afficheBoard(Board):- 
					tabtemp(Temp),
					nl,
					affiche1(6,6,Temp),
					tab(3),
					write('-----------YOU----------- '), nl, nl,
					choixPosition(Temp,0,_,Temp1),asserta(ocre([],[])), asserta(rouge([], [])),
					majPlacementComput(Temp1,Temp2, ListJoueurOcre),nl,write('Placement du joueur Ocre : '), nl, write(ListJoueurOcre),nl,
					affiche1(6,6,Temp2),nl, nl, 
					write('---Joueur ocre (ordinateur) à placé ses pièces.'),write(' A vous :'),nl,
					write('---Insertion des pièces ...   '), nl,nl,
					write('Vous êtes le joueur : '), write('Rouge.'),nl,nl,
					/*majPlacement(Temp2,5,1,Board, Temp3, ListJoueurRouge), sera utilise lors du vrai test*/
					majPlacementHumain(Temp2, Board, ListJoueurRouge), write('Placement du joueur Rouge : '), nl, write(ListJoueurRouge),nl,
					affiche1(6,6,Board), nl, nl,
					/*On initialise tout en dynamique avant de lancer la boucle du jeu*/
					asserta(tableau(Board)), 
					possibleMoves(Board, ListJoueurRouge, PossibleMoveList), asserta(varPossibleMoveRouge(PossibleMoveList)),
					possibleMoves(Board, ListJoueurOcre, PossibleMoveList2), asserta(varPossibleMoveOcre(PossibleMoveList2)),
					boucleJeu.
/*

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