clc;
clear all;
cost = [2 10 4 5; 6 12 8 11 ; 3 9 5 7];
S = [12 25 20];
D = [25 10 15 5];
if sum(S)==sum(D)
    fprintf('Balanced');
else
    fprintf('Unbalanced! Balancing it\n');
    if sum(S)<sum(D)
        cost(end+1,:) = zeros(1,size(D,2));
        S(end+1)=sum(D)-sum(S);
        mytable = [cost S';D sum(D)]  
    else
        cost(:,end+1) = zeros(size(S,2),1);
        D(end+1)=sum(S)-sum(D);
        mytable = [ cost S';D sum(S)]
    end
end

X = zeros(size(cost));

cost1 = cost;

[m,n] =size(cost);

BVS = m + n - 1;

for i=1:m*n

    minim = min(cost(:));
    [r,c] =find(minim ==cost);
    x1 = min(S(r),D(c));

    [value,index]= max(x1);
    ii = r(index);
    jj= c(index);
    y = min( S(ii), D(jj) );

    S(ii)= S(ii)-y;
    D(jj)= D(jj) -y;
    cost(ii,jj) = Inf;
    X(ii,jj) = y;
end
X
sum(sum(cost1.* X))

if(length(nonzeros(X))==BVS)
    fprintf('Non Degenerate')
else 
    fprintf('Degenerate')
end
