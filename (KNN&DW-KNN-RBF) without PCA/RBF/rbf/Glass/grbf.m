% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function []= GKNN(Glass)
clear all
clc
load Glass.dat;
Data_Set =Glass;

[X, Y] = size(Data_Set);
trait = Y-1;

Data_Set_Learning = Data_Set(:,1:Y);
Count_Instance_Set = X;
N_Fold_Cross_Validation = 10;
hit_Cnt = zeros(10);
time_m=zeros(10);

Count_Separate_Part = N_Fold_Cross_Validation;
Size_Separate_Part =floor (Count_Instance_Set / Count_Separate_Part);
Size_Train = ( Count_Separate_Part-1) *Size_Separate_Part;
Size_Test = Count_Instance_Set - Size_Train;
number_of_class=max(Data_Set(:,trait+1));

Number_Of_Circles = number_of_class;

for fold = 1:N_Fold_Cross_Validation
  tic
  Bottom=(fold-1)*Size_Separate_Part;
 Top=Bottom + Size_Test;
         train_set1=Data_Set_Learning(1:Bottom,:);
        train_set2=Data_Set_Learning((Top+1):end,:);
        Train_Set=[train_set1;train_set2];
        Test_Set=Data_Set_Learning((Bottom+1):(Top),:);
            tr1=Data_Set_Learning(1:Bottom,Y);
        tr2=Data_Set_Learning((Top+1):end,Y);
        Train_Target=[tr1;tr2];
        Test_Target=Data_Set_Learning((Bottom+1):(Top),Y);
%         Train_Target_Transpose=Train_Target';
        
        a=0;
        mark_trait=ones(Number_Of_Circles);
        for bnb=1:Number_Of_Circles
            mark_trait(bnb)=1;
        end
        for cv=1:Size_Train
            mark_trait(Train_Set(cv,trait+1))=0;
        end
        sumx=0;
        
          for cb=1:Number_Of_Circles
            sumx=mark_trait(cb)+sumx;
        end  
        mark_train=zeros(Size_Train);
        Center=zeros(Number_Of_Circles-sumx,trait+1);
        zx=1*(Number_Of_Circles)-sumx;
       while a<zx
            mlm   =randi(Size_Train);
            nln=Train_Set(mlm,trait+1);
             if  ((mark_train(mlm)==0) && (mark_trait(nln)<1))
                 a = a+1;
%                     Center_Target(a,:)= Data_Set_Learning(a,Y);
                    Center(a,:)=Train_Set(mlm,:);

                    mark_trait(nln)=mark_trait(nln)+1;
%                     mark_trait(nln)=1;
                    mark_train(mlm)=1;
             end
        end

           MaxDistance=0;
     
    for i=1:zx                                                               
    for j=1:zx
        dis=dist(Center(i,1:trait),transpose(Center(j,1:trait)));
        if dis > MaxDistance
            MaxDistance=dis;
        end
    end
    end
    
Sigma = MaxDistance / (sqrt(Number_Of_Circles));

for d=1:zx 
    for e=1:Size_Train 
%        ss = dist(Train_Set(e,1:trait),transpose(Center(d,1:trait)));
%         phi(e,d) = exp((-zx/power(MaxDistance,2))*power(dist(ss,2)));
                phi(e,d) = exp(-power(norm(Train_Set(e,1:trait)- Center(d,1:trait)),2)/(2*power(Sigma,2)));
    end
end
aaaa=pinv(phi);
WeightTranspose = aaaa*Train_Target;  
w = WeightTranspose';
yy=zeros(Size_Test , 1 );
 for f=1:zx
   for g=1:Size_Test  
%    phi_test(g,f) = exp((-zx/power(MaxDistance,2))*power(dist(Train_Set(g,1:trait),Center(f,1:trait)),2));
                phi_test(g,f) = exp(-power(norm(Train_Set(g,1:trait)- Center(f,1:trait)),2)/(2*power(Sigma,2)));
     yy(g)=  yy(g) + w(f)' * phi_test(g,f);
     end
     end
    
    yy(:)= round(yy(:)) ;
hit = 0;
 for nn = 1 : Size_Test
     if  yy(nn,:)==Test_Target(nn,:);
         hit = hit +1;
     end
 end
hit_Cnt(fold,1)=hit;
toc
time_m(fold,1)=toc;
end
  mean(hit_Cnt(1:fold,1))  *(100 / Size_Test)
  max(hit_Cnt(1:fold,1)) *(100 / Size_Test)
  min(hit_Cnt(1:fold,1)) *(100 / Size_Test)
  std(hit_Cnt(1:fold,1)) *(100 / Size_Test)
  mean(time_m(1:fold,1))
