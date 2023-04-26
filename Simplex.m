variables={'x_1','x_2','x_3','s_1','s_2','s_3','sol'}
cost=[-1 3 -2 0 0 0 0];
info=[3 -1 2; -2 4 0; -4 3 8];
b=[7;12;10];
s=eye(size(info,1));
A=[info s b];
% BV=[];
% for j=1:size(s,2)
%     for i=1:size(A,2)
%         if A(:,i)==s(:,j)
%             BV=[BV i];
%         end
%     end
% end

BV=[4 5 6];
B=A(:,BV)
A=inv(B)*A;
ZjCj=cost(BV)*A-cost;
Zcj=[ZjCj;A];
SimplexTable=array2table(Zcj) 
RUN=true;
while RUN
ZC=ZjCj(:,1:end-1);
if any(ZC<0);
    fprintf("NOt Optimal")
    [EntVal,pvt_col]=min(ZC);
    Sol=A(:,end);
    Col=A(:,pvt_col);
    for i=1:size(A,1)
        if Col(i)>0
            ratio(i)=Sol(i)./Col(i);
        else
            ratio(i)=inf;
        end
    end
    [minR,pvt_row]=min(ratio);
    BV(pvt_row)=pvt_col;
    B=A(:,BV)
A=inv(B)*A;
ZjCj=cost(BV)*A-cost;

else
    RUN=false;
    fprintf("Optimal")
end
end
FINAL_BFS=zeros(1,size(A,2));
FINAL_BFS(BV)=A(:,end);
FINAL_BFS(end)=sum(FINAL_BFS.*cost)
OptimalBFS=array2table(FINAL_BFS);