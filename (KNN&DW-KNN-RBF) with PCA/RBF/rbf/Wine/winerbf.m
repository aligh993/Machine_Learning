% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function []= GKNN(Wine)
clear all
clc
load Wine.dat;
Data_Set =Wine;

[X, Y] = size(Data_Set);
trait = Y-1;

Data_Set_Learning = Data_Set(:,1:Y);
Count_Instance_Set = X;
N_Fold_Cross_Validation = 10;
hit_Cnt = zeros(10);
time_m=zeros(10);

Nunmber_Of_Circles =5;

a = Wine(:,1:trait);
Pc=princomp(a);
Pc_number=5;
Pc=Pc(:,1:Pc_number);
Data_Set_Learning=a(:,:)*Pc(:,:);
Data_Set_Learning(:,Pc_number+1)=Wine(:,trait +1);
number_of_class=max(Wine(:,trait+1));
trait = Pc_number;
Y = Pc_number;

Count_Separate_Part = N_Fold_Cross_Validation;
Size_Separate_Part =floor (Count_Instance_Set / Count_Separate_Part);
Size_Train = ( Count_Separate_Part-1) *Size_Separate_Part;
Size_Test = Count_Instance_Set - Size_Train;
number_of_class=max(Data_Set(:,trait+1));

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
        Train_Target_Transpose=Train_Target';
        
        for a= 1:Nunmber_Of_Circles
            Center(a,:)=randi(Size_Train);
            Center_Target(a,:)= Data_Set_Learning(a,Y);
        end
           MaxDistance=0;
   
    for i=1:Nunmber_Of_Circles                                                               
    for j=1:Nunmber_Of_Circles
        dis=dist(Center(i,:),transpose(Center(j,:)));
        if dis > MaxDistance
            MaxDistance=dis;
        end
    end
    end
    
Sigma = MaxDistance / (sqrt(Nunmber_Of_Circles)*10);

% calculate phi %
for d=1:Nunmber_Of_Circles 
    for e=1:Size_Train % number of train data , ignore last train class that has 153 data;
%         phi(e,d) = exp((-Nunmber_Of_Circles/MaxDistance)*power(norm(Train_Set(e,trait)- Center_Target(d)),2));
                phi(e,d) = exp(-power(norm(Train_Set(e,trait)- Center_Target(d)),2)/(2*power(Sigma,2)));
    end
end

aaaa=pinv(phi,number_of_class);
WeightTranspose = aaaa*Train_Target;  
w = WeightTranspose';
yy=zeros(Size_Test , 1 );
  for g=1:Size_Test 
     for f=1:Nunmber_Of_Circles
	 
        phi_test(g,f) = exp((-Nunmber_Of_Circles/power(MaxDistance,2))*power(norm(Test_Set(g,:)- Center_Target(f)),2));
     yy(g)=  yy(g) + w(f)' * phi_test(g,f);
     end
%     yy(g) =yy(g)+ w(f) * phi_test(g,f);
     end
    
    yy(:)= round(yy(:)) ;
hit = 0;
% y(1:Size_Test,1)= round(xx(1:Size_Test,1));
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
