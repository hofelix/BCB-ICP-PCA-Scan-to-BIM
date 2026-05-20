a = open_and_importdata('D:\論文\1080911\full\20210415'); %基準
b = open_and_importdata('D:\論文\1080911\full\20210415'); %

M = a(:,1:3);
D = b(:,1:3);
M = M';
D = D';

[m,n] = size(D);
[Ricp Ticp ER t] = icp(M, D, 400, 'Matching', 'kDtree', 'Extrapolation', true);
% [Ricp Ticp ER t] = icp(M, D, 200);
Dicp = Ricp * D + repmat(Ticp, 1, n);
figure;
plot3(M(1,:),M(2,:),M(3,:),'b.',Dicp(1,:),Dicp(2,:),Dicp(3,:),'r.');
axis equal;
xlabel('x'); ylabel('y'); zlabel('z');
title('ICP result');

D =Dicp';
M = M';

% xlswrite('G:\論文\0911&0919mix\Full\ICP\FLOOR_ICP.xlsx',D);

M_n = size(M);  %the size of simulation point cloud
D_n = size(D);  %the size of real point cloud
dis_check = 0.01;
member_check = 1;
completion = 0;
parfor i = 1:M_n(1)
    member = 0;
    for j = 1:D_n(1)
        dis = sqrt((M(i,1)-D(j,1))^2+(M(i,2)-D(j,2))^2+(M(i,3)-D(j,3))^2);
        if dis <= dis_check
            member = member+1;
        end
    end
    if member >= member_check
        completion = completion + 1;
    end
end

Degree_of_completion = completion/M_n(1)*100;
fprintf('Degree of completion = %g %%' ,Degree_of_completion );