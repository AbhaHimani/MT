cost = [20 19 14 21 16; 15 20 13 19 16; 18 15 18 20 10]
supply = [40 60 70]
sum(supply)
demand=[30 40 50 40 60]
sum(demand)
[m,n]=size(cost);
if sum(supply)==sum(demand)
    disp("Balanced prblm");
elseif sum(supply)<sum(demand)
    disp("Unbalanced Problm");
    cost(end+1,:)=zeros(1,n)
    supply(end+1)=sum(demand)-sum(supply)
else
    disp("Unbalanced problem");
    cost(:,end+1)=zeros(m,1)
    demand(end+1)=sum(supply)-sum(demand)
end
disp("The balanced prblm is: ");
balanced=['cost supply';demand sum(supply)]
X=zeros(m,n);
Icost=cost;
while any(supply~=0)||any(demand~=0)
    min_cost=min(cost(:))
    [r,c]=find(cost==min_cost)
    y=min(supply(r), demand(c))
    [aloc, index]=max(y)
    rr=r(index);
    cc=c(index);
    X(rr,cc)=aloc
    supply(rr)=supply(rr)-aloc
    demand(cc)=demand(cc)-aloc
    cost(rr,cc)=Inf
end
if nnz(X)==m+n-1
    disp("Non degenerate sol");
else 
    disp("Degen sol");
end
final_cost=Icost.*X;
Final_Cost=sum(final_cost(:))