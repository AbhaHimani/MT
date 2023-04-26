format short
clc
clear all

variables={'x1','x2','x3','s1','s2','sol'};
cost=[-2 0 -1 0 0 0];
Info=[-1 -1 1;-1 2 -4];
b=[-5;-8];
s=eye(size(Info,1));

A=[Info s b]
BV=[];

for i=1:size(s,2)
    for j=1:size(A,2)
        if s(:,i)==A(:,j)
            BV=[BV j];
        end
    end
end
BV


B=A(:,BV)
A=inv(B)*A;
ZjCj=cost(BV)*A-cost

Simplex=[ZjCj;A]
Simplex=array2table(Simplex);
Simplex.Properties.VariableNames(1:size(Simplex,2))=variables
RUN=true;
while RUN
sol=A(:,end)

if any(sol<0)
    fprintf('Not feasible')
    [leavVar,pvtrow]=min(sol);

    row=A(pvtrow,1:end-1)
    ZJ=ZjCj(:,1:end-1)
    for i=1:size(row,2)
        if row(i)<0
            ratio(i)=abs(ZJ(i)./row(i))
        else
            ratio(i)=inf;
        end
    end
    [minVal,pvtcol]=min(ratio);
    BV(pvtrow)=pvtcol;

    B=A(:,BV)
A=inv(B)*A;
ZjCj=cost(BV)*A-cost

else
    RUN=false;
    fprintf('Feasible')
end
end

FINALBFS=zeros(1,size(A,2));
FINALBFS(BV)=A(:,end);
FINALBFS(end)=-ZjCj(end);
OPTBFS=array2table(FINALBFS);
OPTBFS.Properties.VariableNames(1,1:size(FINALBFS,2))=variables