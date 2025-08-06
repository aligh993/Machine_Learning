% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [correct,TP,FN,FP,TN] =correct_DWKNN_WDBC(Z_Test,Z_Train,index,a,K,weight)
%3NN & 5NN
TP=0;
FN=0;
FP=0;
TN=0;
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
        
        if Z_Test(i,1)==1
            if r(I)==1;
                TP=TP+1;
                correct=correct+1;
            end
            if r(I)==0;
                FN=FN+1;
            end
        end
          
        if Z_Test(i,1)==0
            if r(I)==1
                FP=FP+1;
            end
            if r(I)==0
                TN=TN+1;
                correct=correct+1;
                
            end
        end    
    end
    
end
end


