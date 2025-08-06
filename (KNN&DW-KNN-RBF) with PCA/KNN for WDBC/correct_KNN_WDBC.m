% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [correct,TP,FN,FP,TN] = correct_KNN_WDBC(Z_Test,Z_Train,index,a,K)
correct=0;
%1NN
TP=0;
FN=0;
FP=0;
TN=0;
if K==1
    for j=1:a
        if Z_Test(j,1)==1
            if Z_Train(index(j,1),1)==1;
                TP=TP+1;
                correct=correct+1;
            end
            if Z_Train(index(j,1),1)==0;
                FN=FN+1;
            end
        end
    
        
        if Z_Test(j,1)==0
              if Z_Train(index(j,1),1)==1;
                 FP=FP+1;
              end
              if Z_Train(index(j,1),1)==0;
                 TN=TN+1;
                 correct=correct+1;
              end
        end
    end
end
    
    
%3NN & 5NN
if K>1
    for j=1:a
                      
        for h=1:K
            result(j,h)=Z_Train(index(j,h),1);
        end
        [B,F]= mode(result,2);
        if Z_Test(j,1)==1 
            if B(j,1)==1;
                TP=TP+1;
                correct=correct+1;
            end
            if B(j,1)==0;
                FN=FN+1;      
            end
        end


        if Z_Test(j,1)==0
                if B(j,1)==1
                    FP=FP+1;
                end
                if B(j,1)==0
                    TN=TN+1;
                    correct=correct+1;
                end
        end
    end
end

end

