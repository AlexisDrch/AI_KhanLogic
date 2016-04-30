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

/*Afficher le tableau*/

 affiche(_,0,1,_) :- !.
 affiche(C, L,1,[X|Q]) :- 
					afficheLi(C, L,1,X),
					nl,
					Temp is L-1,
					affiche(C,Temp,1,Q).
					
afficheLi(0, _, 1, _) :- !.
afficheLi(C, L,1,[X|Q]) :- 
					write(X),
					write(` `),
					Temp is C-1,
					afficheLi(Temp, L, 1, Q).
/*affichage 3*/
 affiche(_,0,3,_) :- !.
 affiche(C, L,3,[X|Q]) :- 
					Temp is L-1,
					affiche(C,Temp,3,Q),
					afficheLi(C, L,3,X),
					nl.
					
afficheLi(0, _, 3, _) :- !.
afficheLi(C, L, 3,[X|Q]) :- 
					Temp is C-1,
					afficheLi(Temp, L, 3, Q),
					write(X),
					write(` `).

					
					
/* affichage 2 
 affiche(C, L, [X|Q], 2) :- afficheLi(C, L, X, 2),
					nl,
					Temp is L-1,
					affiche(C, Temp, Q, 2).
					
afficheLi(C, L, [X|Q], 2) :- 
					Temp is C-1,
					afficheLi(Temp, L, Q, 2),
					write(X),
					write(` `).
					

 Prédicat Afficha UI*/

afficheBoard(L) :- 	initBoard(L),
					affiche(6,6,1,L),
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
					affiche(6,6,P,L),
					!.
					
					
					
					
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