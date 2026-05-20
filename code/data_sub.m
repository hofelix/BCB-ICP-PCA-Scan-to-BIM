clc;clear all 
tic
% 
%  fid = fopen('full.txt')
%  lines = get_lines(fid)
%切為2份
% if mod(lines,2) == 0 %判斷奇偶數
%     cut_line = lines./2;
% else  
%     cut_line = (lines+1)./2;
% end
% data = open_and_importdata('E:\論文\三層樓');
% data_cell = mat2cell(data,[cut_line (lines-cut_line)],[3 0]);
% data_cell_1 = data_cell{1,1};
% data_cell_2 = data_cell{2,1};
% dlmwrite('F:\論文\三層樓\測試\ALL\自動切\皆2倍\切2份\1F_data_int_1.txt',data_cell_1,'delimiter',' ','newline', 'pc')
% dlmwrite('F:\論文\三層樓\測試\ALL\自動切\皆2倍\切2份\1F_data_int_2.txt',data_cell_2,'delimiter',' ','newline', 'pc')

% 切為3份
% if mod(lines,3) == 0 %判斷3的倍數
%     cut_line = lines./3;
% else  if mod(lines,3) == 1
%         cut_line = (lines+2)./3;
%     else  if mod(lines,3) == 2
%             cut_line = (lines+1)./3;
%         end
%     end
% end
% data = open_and_importdata('F:\論文\三層樓');
% line = [cut_line cut_line (lines-2.*cut_line)];  %%%%需確認
% data_cell = mat2cell(data,line);
% data_cell_1 = data_cell{1};
% data_cell_2 = data_cell{2};
% data_cell_3 = data_cell{3};
% dlmwrite('F:\論文\三層樓\測試\ALL\皆2倍\切3份\ALL_3-1.txt',data_cell_1,'delimiter',' ','newline', 'pc')
% dlmwrite('F:\論文\三層樓\測試\ALL\皆2倍\切3份\ALL_3-2.txt',data_cell_2,'delimiter',' ','newline', 'pc')
% dlmwrite('F:\論文\三層樓\測試\ALL\皆2倍\切3份\ALL_3-3.txt',data_cell_3,'delimiter',' ','newline', 'pc')

%切為4份
% if mod(lines,4) == 0 %判斷4的倍數
%     cut_line = lines./4;
% else  if mod(lines,4) == 1
%         cut_line = (lines+3)./4;
%     else  if mod(lines,4) == 2
%             cut_line = (lines+2)./4;
%         else  if mod(lines,4) == 3
%                 cut_line = (lines+1)./4;
%             end
%         end
%     end
% end
% data = open_and_importdata('G:\論文\1080919\FULL');
% line = [cut_line cut_line cut_line (lines-3.*cut_line)];  %%%%需確認
% data_cell = mat2cell(data,line);
% data_cell_1 = data_cell{1};
% data_cell_2 = data_cell{2};
% data_cell_3 = data_cell{3};
% data_cell_4 = data_cell{4};
% dlmwrite('G:\論文\1080919\FULL\分割資料\ALL_4-1.txt',data_cell_1,'delimiter',' ','newline', 'pc')
% dlmwrite('G:\論文\1080919\FULL\分割資料\ALL_4-2.txt',data_cell_2,'delimiter',' ','newline', 'pc')
% dlmwrite('G:\論文\1080919\FULL\分割資料\ALL_4-3.txt',data_cell_3,'delimiter',' ','newline', 'pc')
% dlmwrite('G:\論文\1080919\FULL\分割資料\ALL_4-4.txt',data_cell_4,'delimiter',' ','newline', 'pc')

% 刪除反射率
% data = open_and_importdata('E:\論文\三層樓');
% no_int = data (:,1:3);
% dlmwrite('E:\論文\三層樓\測試\反射率\1F_data_noint.txt',no_int,'delimiter',' ','newline', 'pc')

  system('copy PCA_4-1.txt+PCA_4-2.txt+PCA_4-3.txt+PCA_4-4.txt ALL_PCA.txt')%合併檔案
toc