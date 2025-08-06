% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [correct] =correct_DWKNN(Z_Test,Z_Train,index,a,K,weight)    
%3NN & 5NN    
if K>1
    correct=0;
    for i=1:a
        for j=1:K
             r(j)=Z_Train(index(i,j),1);
             counter(j)=0;
            
            for n=1:K
                if Z_Train(index(i,n),1)==r(j) ;
                   counter(j)=counter(j)+weight(i,j);
                end
            end
        end
      [C,I]=max(counter);
        if Z_Test(i,1)==r(I)
            correct=correct+1;
        end
    end
    
end
end

