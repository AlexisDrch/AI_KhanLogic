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
initBoard(L) :- init(6,6,L).

/*Afficher le tableau

affichage 1*/

 affiche1(_,0,_) :- !.
 affiche1(C, L,[X|Q]) :- 
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
					
affiche3(_,0,_) :- !.

					
					
/*affichage 2*/
 
 affiche(C, L, [X|Q], 2) :- 
					afficheLi(C, L, X, 2),
					nl,
					Temp is L-1,
					affiche(C, Temp, Q, 2).
					
afficheLi(C, L, [X|Q], 2) :- 
					Temp is C-1,
					afficheLi(Temp, L, Q, 2),
					write(X),
					write(` `).

/*affichage 3*/

affiche3(C,L,[X|Q]) :- 
					Temp is L-1,
					affiche3(C,Temp,Q),
					afficheLi3(C, Temp,X),
					nl.
					
afficheLi3(0, _, _) :- !.
afficheLi3(C, L,[X|Q]) :- 
					Temp is C-1,
					afficheLi3(Temp, L, Q),
					write(X),
					write(` `).

/*Choix de position*/
					
position(R, L, 1) :- affiche1(6,6,L), !.
position(R, L, 2) :- affiche2(6,6,L), !.
position(R, L, 3) :- affiche3(6,6,L), !.
position(R, L, 4) :- affiche4(6,6,L), !.
					
/*Prédicat Afficha UI*/

afficheBoard(L) :- 	initBoard(L),
					affiche1(6,6,L),
					nl,
					write('Choisir une position : 1,2,3,4'),
					nl,
					write('---4---'),
					nl,
					write('2-----3'),
					nl,
					write('---1---'),
					nl,
					read(P), 
					position(R, L, P).
					
					
					
					
/*	

 3
2 4
 1 

1 : [1,1]...[1,6]
	...
	[6,1]...[6,6]

2 : [1,6]...[6,6]
	...
	[1,1]...[6,1]
	
	
3 : [6,6]...[6,1]
	...
	[1,6]...[1,1]
	
4 : [6,1]...[1,1]
	...
	[6,6]...[1,6]


*/