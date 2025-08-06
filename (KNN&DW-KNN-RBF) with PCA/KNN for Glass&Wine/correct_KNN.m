% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [correct] = correct_KNN(Z_Test,Z_Train,index,a,K)
 correct=0;
%1NN
if K==1 

    for j=1:a
        if Z_Test(j,1)==Z_Train(index(j,1),1)
            correct= correct+1;
        end
    end
    
%3NN & 5NN    
else if K>1
        
        for j=1:a
            for h=1:K
                result(j,h)=Z_Train(index(j,h),1);
            end    
                [B,F]= mode(result,2);
                if Z_Test(j,1)== B(j,1)
                    correct= correct+1;
                end  
        end
  end  
end

