
% what is producible in the network

  scope(M) :- seed(M).

  scope(M) :- product(M,R), dreaction(R), scope(M2) : reactant(M2,R).

  scope(M) :- reactant(M,R), dreaction(R), draft(N), reversible(R), scope(M2) : product(M2,R).

% predecessors of targets
	% = reactant of a reaction that has at least one predecessor among its products

  predecessor(T,T) :- target(T).
  predecessor(M,T) :- reactant(M,R), dreaction(R), product(M1,R), predecessor(M1,T).
  predecessor(M,T) :- product(M,R), dreaction(R), reversible(R), reactant(M1,R), predecessor(M1,T).


% a reaction belongs to the subnetwork of target T is all its reactants are in the scope and if at least one of its products is a predecessor of target T
  subgraph(R,T) :- target(T), predecessor(M,T), product(M,R), dreaction(R) : reactant(M1,R), scope(M1).


% reactions belonging to one path2target are from the subgraph

{selected(R,T) : subgraph(R,T)}.

% scope of path2target

  pscope(M,T) :- seed(M), target(T).

  pscope(M,T) :- product(M,R), selected(R,T), target(T), pscope(M2,T) : reactant(M2,R).

  pscope(M,T) :- reactant(M,R), selected(R,T), target(T),reversible(R), pscope(M2,T) : product(M2,R).

% pscope must include target

:- target(T), scope(T), not pscope(T,T).


%minimize the number of cofcators
    #minimize { 1@1,R : selected(R,T)}.

#show selected/2.
