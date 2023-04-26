clc
clear all
a=[-5 -1 1 0 0;-6 -5 0 1 0;-1 -4 0 0 1];
cost=[-12 -10 0 0 0]
cost=[cost 0]
b=[-10;-30;-8]
A=[a b]
bv=[3 4 5]
zjcj=cost(bv)*A-cost
var={'x1','x2','s1','s2','s3','sol'}
simp_table=[zjcj;A]
array2table(simp_table,'VariableNames',var)
Run=true
sol = A(:,end)
while Run 
if any(sol(1:end-1)<0)
fprintf('sol not feasible')
[leave_val,pvt_row]=min(sol)
if all(A(pvt_row,:)>=0)
error('infeasible solution')
else
col=A(pvt_row,1:end-1)
zc=zjcj(1:end-1)
for i=1:size(a,2)
if col(i)<0
ratio(i)=abs(zjcj(i)/col(i))
else
ratio(i)=inf
 end
end
[enter_value,pvt_col]=min(ratio)                               
end
pvt_key=A(pvt_row,pvt_col)
A(pvt_row,:)=A(pvt_row,:)/pvt_key
for i=1:size(A,1)
if i~=pvt_row
i
A(i,:)=A(i,:)-A(i,pvt_col)*A(pvt_row,:)
end
end
bv(pvt_row)=pvt_col
sol = A(:,end)
zjcj=cost(bv)*A-cost
new_table=[zjcj;A]
 array2table(new_table,'VariableNames',var)
else
                Run=false;
                fprintf('optimal sol is %f',zjcj(end))
end
end
