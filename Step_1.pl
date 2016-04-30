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
 affiche(_,0,Q,_) :- !.
 affiche(_,7,Q,_) :- !.
 affiche(C, L, [X|Q], 1) :- afficheLi(C, L, X, 1),
					nl,
					Temp is L-1,
					affiche(C, Temp, Q, 1).
					
afficheLi(0, _, _, _) :- !.
afficheLi(C, L, [X|Q], 1) :- 
					write(X),
					write(` `),
					Temp is C-1,
					afficheLi(Temp, L, Q).
					
					
/* affichage 2 */
 affiche(C, L, [X|Q], 2) :- afficheLi(C, L, X, 2),
					nl,
					Temp is L-1,
					affiche(C, Temp, Q, 2).
					
afficheLi(C, L, [X|Q], 2) :- 
					Temp is C-1,
					afficheLi(Temp, L, Q, 2),
					write(X),
					write(` `).

/*Prédicat Afficha UI*/
afficheBoard(L) :- affiche(6,6,L),
					write('Entrez position')/*, read(X), write(X)*/.
				
					
					
					
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