function T=BFS(visible,o,d)

discovered=[o];
q=[o];
T=cell(1,length(visible));
Q=cell(1,length(visible));

while not(isempty(q))
    j=q(1); q=q(2:length(q));  % pop the front
    neigh=find(visible(j,:));
    for nn=1:length(neigh)
        if isempty(find(discovered==neigh(nn)))
            T{j}=[T{j}, neigh(nn)];
	    Q{neigh(nn)} = j;
            if neigh(nn)==d
		T = Q;
                return
            end
            discovered=[discovered, neigh(nn)];
            q=[q, neigh(nn)];
        end
    end
end

printf('BFS(): Target node not found.\n')

