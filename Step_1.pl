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

	affiche2(0, _, _, _ , _) :- !.
	affiche2(C, 0, Dim, Board, _) :- 
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
					write('----YOU----'), nl, nl,!.
position( Board, 2) :- tab(3),affiche2(6,6,6,Board,Board),tab(3),
					write('----YOU----'), nl, nl, !.
position( Board, 3) :- affiche3(6,6,6,Board),tab(3),
					write('----YOU----'), nl, nl, !.
position( Board, 4) :- affiche4(6,6,Board),tab(3),
					write('----YOU----'), nl, nl, !.
					
/*Prédicat Afficha UI*/

afficheBoard(Board) :- 	initBoard(Board), nl,
					affiche1(6,6,Board),
					tab(3),
					write('----YOU----'), nl, nl,
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
					position(Board, P).
					
					
					
					
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