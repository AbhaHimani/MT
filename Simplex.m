clc;
clear all;
a=[1 4 8 6;4 1 2 1;2 3 1 2];
bv=[5 6 7];
s=eye(size(a,1));
a=[a s];
sol=[11;7;2];
cj=[4 6 3 1 0 0 0];
cj=[cj 0];
A=[a sol];
var={'x1','x2','x3','x4','s1','s2','s3','sol'};
zj_cj=cj(bv)*A-cj;
firsttable=[zj_cj;A];
array2table(firsttable,'VariableNames',var);
RUN=true;
while RUN
    if any(zj_cj<0)
        fprintf('optimal soln not found\n');
        z=zj_cj(1:end-1);
        [enter,pivotcol]=min(z);
        mycol=A(:,pivotcol);
        if all(mycol<0)
            error('Soln is unbounded');
        else
            sol=A(:,end);
            for i=1:size(A,1)
                if (mycol(i)>0)
                    ratio(i)=sol(i)/mycol(i);
                else
                    ratio(i)=Inf;
                end
            end
            [leave,pivotrow]=min(ratio);
            pivotkey=A(pivotrow,pivotcol);
            A(pivotrow,:)=A(pivotrow,:)/pivotkey;
            for i=1:size(A,1)
                if i~=pivotrow
                    A(i,:)=A(i,:)-A(i,pivotcol)*A(pivotrow,:);
                end
            end
            bv(pivotrow)=pivotcol;
            zj_cj=cj(bv)*A-cj;
            newtablearray=[zj_cj;A];
            newtable=array2table(newtablearray,'VariableNames',var)
        end
    else
        RUN=false;
        fprintf('Basic var indices');
        bv
        fprintf('Sol vector');
        newtablearray(2:size(newtablearray,1),size(newtablearray,2))'
        fprintf('optimal sol');
        newtablearray(1,size(newtablearray,2))
    end
end
