% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

load Glass.dat;

[X Y] = size(Glass);

a = Glass(:,1:Y-1);
Pc=princomp(a);
Pc_number=9;
Pc=Pc(:,1:Pc_number);
Data_Set_Learning=a(:,:)*Pc(:,:);
Data_Set_Learning(:,Pc_number+1)=Glass(:,Y);
number_of_class=max(Glass(:,Y));
Y = Pc_number;

Data_Set_Learning = Glass(:,1:Y);
Count_Instance_Set = X;
N_Fold_Cross_Validation = 10;
hit_cnt=zeros(10,1);
mean_hit=zeros(10,1);
 max_hit=zeros(10,1);
 min_hit=zeros(10,1);
 std_hit=zeros(10,1);
time = zeros(10,1);
Count_Separate_Part = N_Fold_Cross_Validation;
Size_Separate_Part =floor (Count_Instance_Set / Count_Separate_Part);
Size_Train = ( Count_Separate_Part-1) *Size_Separate_Part;
Size_Test = Count_Instance_Set - Size_Train;

for fold = 1:N_Fold_Cross_Validation
  tic
  Bottom=(fold-1)*Size_Separate_Part;
 Top=Bottom + Size_Test;
         train_set1=Data_Set_Learning(1:Bottom,:);
        train_set2=Data_Set_Learning((Top+1):end,:);
        Train_Set=[train_set1;train_set2];
        Test_Set=Data_Set_Learning((Bottom+1):(Top),:);
        Train_Input = Train_Set(:,1:Y-1);
        Train_Target = Train_Set(:,Y);
        Test_Input = Test_Set(:,1:Y-1);
        Test_Target = Test_Set(:,Y);
        net = newrb(Train_Input',Train_Target');
        bbb = sim(net,Test_Input');
         z=round(bbb);
for ll=1:Size_Test
        if Test_Target(ll,:)==z(ll)
            hit_cnt(fold)=hit_cnt(fold)+1; 
        end    
        mean_hit=mean(hit_cnt(:))*(100/Size_Test);
max_hit=max(hit_cnt(:))*(100/Size_Test);
min_hit=min(hit_cnt(:))*(100/Size_Test);
std_hit=std(hit_cnt(:))*(100/Size_Test);
end
toc
time(fold) = toc;
mean(time())
mean_hit()
max_hit()
min_hit()
std_hit()

end