clc
clear all
M=1;
A=[5 1 -1 0 0 1 0 0;6 5 0 -1 0 0 1 0;1 4 0 0 -1 0 0 1];
b=[10;30;8];
c=[0 0 0 0 0 -M -M -M];
c=[c 0];
A=[A b];
bv=[6 7 8];
zjcj=c(bv)*A-c;
simplex=[zjcj;A];
var={'x1','x2','s1','s2','s3','a1','a2','a3','sol'};
array2table(simplex, 'VariableNames',var)
RUN=true;
n=length(zjcj);
while RUN
    if any(zjcj(1:n-1)<0)
        fprintf('Solution is not optimal\n');
        zc=zjcj(1:n-1);
       [enter_var, pivot_col]=min(zc);
       if all(A(:,pivot_col)<0)
           error('LLP is unbounded');
       else
           sol=A(:,n);
           col=A(:,pivot_col);
           for i=1:size(A,1)
               if col(i)>0
                   ratio(i)=sol(i)/col(i);
               else
                   ratio(i)=inf;
               end
           end
           [leaving_var,pivot_row]=min(ratio);
       end
       bv(pivot_row)=pivot_col;
       pivot_key=A(pivot_row,pivot_col);
       A(pivot_row,:)=A(pivot_row,:)/pivot_key;
       for i=1:size(A,1)
           if i~=pivot_row
               A(i,:)=A(i,:)-A(i,pivot_col).*A(pivot_row,:)
           end
       end
       zjcj=c(bv)*A-c;
       simplex=[zjcj;A];
       array2table(simplex, 'VariableNames',var)
    else
        RUN=false;
    end
end
fprintf('Optimal Sol is %d\n',zjcj(end));
if (zjcj(end)~=0)
    fprintf('Infeasible soln');
else
    fprintf('Feasible soln');
    sol=A(:,end);
    A=A(:,1:end-4);
    A(:,end+1)=sol;
    bv=[1 3 2];
    c=[-12 -10 0 0 0];
    c=[c 0];
    zjcj=c(bv)*A-c;
    simplex=[zjcj;A];
    array2table(simplex, 'VariableNames',{'x1','x2','s1','s2','s3','sol'})
    RUN1=true;
while RUN1
    if any(zjcj(1:end-1)<0)
        fprintf('Solution is not optimal\n');
        zc=zjcj(1:n-1);
       [enter_var, pivot_col]=min(zc);
       if all(A(:,pivot_col)<0)
           error('LLP is unbounded');
       else
           sol=A(:,n);
           col=A(:,pivot_col);
           for i=1:size(A,1)
               if col(i)>0
                   ratio(i)=sol(i)/col(i);
               else
                   ratio(i)=inf;
               end
           end
           [leaving_var,pivot_row]=min(ratio);
       end
       bv(pivot_row)=pivot_col;
       pivot_key=A(pivot_row,pivot_col);
       A(pivot_row,:)=A(pivot_row,:)/pivot_key;
       for i=1:size(A,1)
           if i~=pivot_row
               A(i,:)=A(i,:)-A(i,pivot_col).*A(pivot_row,:)
           end
       end
       zjcj=c(bv)*A-c;
       simplex=[zjcj;A];
       array2table(simplex, 'VariableNames',{'x1','x2','s1','s2','s3','sol'})
    else
        RUN1=false;
        fprintf('basic variable indices are')
        bv
        fprintf('sol vector')
        simplex(2:size(simplex,1),size(simplex,2))'
        fprintf('optimal solution')
        simplex(1,end)
    end
    end 
end
