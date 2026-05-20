clc;clear all 
tic

% fprintf('待分析點雲\r\n');
data = open_and_importdata('D:\論文\1080911\full\20210415\C3\6F');

%% PCA邊界提取
% ex_near = input('輸入邊界提取kd-tree鄰近點個數');
ex_near = 150;
ex_data = data(:,1:3);
%ex_ns = createns(ex_data,'nsmethod','kdtree');%建立kd-tree資料庫 才能使用knnsearch尋找鄰近點
ex_ns = KDTreeSearcher(ex_data,'Distance','euclidean','BucketSize',ex_near); 

% k_num = input('knnsearch點數');
k_num = 100;
[ex_idx, ex_dist] = knnsearch(ex_ns,ex_data,'k',k_num);%idx為鄰近點的編號 dist為與鄰近點的距離
ex_idx(:,1)=[];%第一欄為自己 故刪除
ex_N_point = size(ex_data,1);
ex_SW = zeros((k_num-1),size(ex_data,2),ex_N_point);

for ex_i = 1:1:ex_N_point
    ex_SW(:,:,ex_i) = ex_data(ex_idx(ex_i,:),:);%匯入離第ex_i個點最近的ex_near個點之座標
%        %加權重W
%      sig = sum(ex_dist(ex_i,:));
%      dist_mean = mean(ex_dist(ex_i,2));
%      if ex_dist(ex_i,:)-dist_mean == 0
%                 ex_w = 1;
%      else
%          ex_w =abs(1./( (ex_dist(ex_i,:)-dist_mean).*(sig-(dist_mean.*ex_N_point))));
%      end    
   
    ex_CV(:,:,ex_i) = cov(ex_SW(:,:,ex_i));%求出每個點周圍最近的ex_near個點之共變異數
    [ex_e_vector(:,:,ex_i),ex_e_value(:,:,ex_i)] = eig(ex_CV(:,:,ex_i));
    ex_vvv = ex_e_value(1,1,ex_i)+ex_e_value(2,2,ex_i)+ex_e_value(3,3,ex_i);%λ0+λ1+λ2
    %λ0<=λ1<=λ2
    ex_value_min(ex_i,1) = ex_e_value(1,1,ex_i)/ex_vvv;%surface variation=λ0/λ0+λ1+λ2
     ex_value_min(ex_i,2) = ex_e_value(2,2,ex_i)/ex_vvv;%surface variation=λ1/λ0+λ1+λ2
    ex_value_min(ex_i,3) = ex_e_value(3,3,ex_i)/ex_vvv;%surface variation=λ2/λ0+λ1+λ2
    %surface variation越大，越突出
%     ex_v_mean = mean(ex_value_min(:,1));
%     ex_v_std = std(ex_value_min(:,1));
end

 ex_v_mean = mean(ex_value_min(:,1));
 ex_v_std = std(ex_value_min(:,1));

%  for mult = 1:0.5:2.5
    extra_num = find(ex_value_min(:,1) >= (ex_v_mean+1.5*ex_v_std));
    extra_val = find(1.5*ex_value_min(:,2) <= ex_value_min(:,3));
    extra_edge = intersect(extra_num,extra_val);
    extra_point = data(extra_edge,1:3);
%     extra_point(:,4) = ex_value_min(extra_edge,1);


% extra_num2 = find(ex_value_min(:,1) >= (ex_v_mean+5*ex_v_std))
% extra_point2 = data(extra_num2,1:3)
%  extra_point2(:,4) = ex_value_min(extra_num2,1)

% ex_ppp = ex_data(:,:)
% ex_ppp(:,4) = ex_value_min(:,1)
% ex_ppp = sortrows(ex_ppp,-4)
% ex_qqq = ex_ppp(1:(0.1*ex_N_point),1:4)
% extra_point = ex_qqq

% figure(1)
% scatter3(ex_data(:,1),ex_data(:,2),ex_data(:,3),10,ex_value_min(:,1),'filled')
% colorbar
% axis equal

figure(1)
scatter3(ex_data(:,1),ex_data(:,2),ex_data(:,3),10,'filled')
axis equal

figure(2)
scatter3(extra_point(:,1),extra_point(:,2),extra_point(:,3),10,'filled')
axis equal

% figure(3)
% scatter3(extra_point2(:,1),extra_point2(:,2),extra_point2(:,3),10,extra_point2(:,4),'filled')
% colorbar
% axis equal
%  dlmwrite('G:\論文\1080911\full\20210415\C1\PCA_full_new.txt',extra_point,'delimiter',' ','newline', 'pc') 
% xlswrite('D:\論文\1080911\full\20210415\C3\6F\C3_PCA_6F_20210531.xlsx',extra_point)
toc