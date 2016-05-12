/*Variable tableau*/
t1([[2,3,1,2,2,3],[2,1,3,1,3,1],[1,3,2,3,1,2],[3,1,2,1,3,2],[2,3,1,3,1,3],[2,1,3,2,2,1]]).
t2([[3,1,2,2,3,1],[2,3,1,3,1,2],[2,1,3,1,3,2],[1,3,2,2,1,3],[3,1,3,1,3,1],[2,2,1,3,2,2]]).
t3([[2,2,3,1,2,2],[1,3,1,3,1,3],[3,1,2,2,3,1],[2,3,1,3,1,2],[2,1,3,1,3,2],[1,3,2,2,1,3]]).
t4([[1,2,2,3,1,2],[3,1,3,1,3,2],[2,3,1,2,1,3],[2,1,3,2,3,1],[1,3,1,3,1,2],[3,2,2,1,3,2]]).

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
						write(` `),
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
	afficheElemI(1, L, [X|_]):- write(X), write(` `). 
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
						write(` `).
						


/*Choix de position*/
					
position( Board, 1) :- affiche1(6,6,Board), tab(3),
					write('----YOU----'), nl, nl.
position( Board, 2) :- tab(3),affiche2(6,6,6,Board,Board),tab(3),
					write('----YOU----'), nl, nl.
position( Board, 3) :- affiche3(6,6,6,Board),tab(3),
					write('----YOU----'), nl, nl.
position( Board, 4) :- affiche4(6,6,Board),tab(3),
					write('----YOU----'), nl, nl.

/*Initialisation de la structure choisie*/					
choixPosition(_,1,1,Board) :- t1(Board).
choixPosition(_,1,2,Board) :- t2(Board).
choixPosition(_,1,3,Board) :- t3(Board).
choixPosition(_,1,4,Board) :- t4(Board).		
		
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
majCoups(Ns,Nk,0):-Temp is (Nk-1), Nk is Temp.
majCoups(Ns,Nk,1):-Temp is (Ns-1), Ns is Temp.

majPlacement(Board, C, L):- true.

choixPlaces(Board):- !.
					
insertPiece(Board,0,0):- write('Placement terminé.'), nl, write('A vous de jouer !').
/*Ns : nbre de sbire restant à positionner, Nk nombre de Kalista.*/
insertPiece(Board,Ns, Nk):-
					write("Il vous reste"), write(Ns), write(' /6 sbires et '), write(Nk), write(' /1 Kalista à placer ... '),nl,
					choixPlaces(Board),
					write('Placement de Sbire (1) ou Kalista (0)'), read(Pi),nl,
					majCoups(Ns,Nk,Pi),
					write('Colonne choisie  [1..6] : '), read(C),nl,
					write('Colonne choisie  [1 ou 2 ] : '), read(L),nl,
					majPlacement(Board,C,L),
					affiche1(6,6,Board).
					
					
		
					
/*Prédicat UI*/

afficheBoard(Board):- 
					t1(Temp),
					nl,
					affiche1(6,6,Temp),
					tab(3),
					write('----YOU----'), nl, nl,
					choixPosition(Temp,0,_,Board),
					write('Insertion des pièces  : '), nl,tab(3),
					write('Vous êtes le joueur : '), 
					write('Rouge.'),nl,tab(3),
					tab(3),write('(Sbire = SRi et Kalista = KaRi'),nl,
					insertPiece(Board,6,1).
					
					
/*	

 4
2 3
 1 

1 : [1,1]...[1,6]
	...
	[6,1]...[6,6]

2 : [1,6]...[6,6]
	...
	[1,1]...[6,1]
	
3 : [6,1]...[1,1]
	...
	[6,6]...[1,6]
	
4 : [6,6]...[6,1]
	...
	[1,6]...[1,1]
	


*/