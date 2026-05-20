function [ varargout ] = open_and_importdata( path_name , varargin  )
%  == open_and_importdata ==
%  輸入和確認檔案格式可以使用的小程式
%  應用的方程式有 importdata & uigetfile
%  只能輸入( txt & excell )檔
%  進入的資料形式只能為 ( struct & double )

if nargout == 0
    fprintf(2,'NO output argument\n');
    varargout{1} = 'error：NO output argument';
    return;
elseif nargout >2
    fprintf(2,'Too many output argument\n');
    varargout{1} = 'error：Too many output argument';
    return;
end
if nargin ==1
    validateattributes(path_name,{'char'},{'nonempty'})
elseif nargin > 1
    fprintf(2,'Too many input argument \n');
    varargout{1} = 'error：Too many input argument';
    return
else
    path_name = cd;
end

Original_path = cd;
cd(path_name);
[FN, PN] = uigetfile({ '*.xlsx' ; '*.txt' ; '*.xls' },'Open File');
cd(Original_path)
if isequal(FN,0) || isequal(PN,0)
    msgbox('No File Select','File Open Error','error');
    return;
else
    file_name = FN;
    path_name = PN;
end
str = [path_name,file_name];
if strcmpi(file_name(length(file_name)-3:length(file_name)),'.txt')==1 %---------(.txt)檔用
    XYZ_temp = importdata(str);
else  %---------excell( .xls / .xlsx )檔用
    [~,sheets_inf]= xlsfinfo(str);
    read_sheet = 1;
    for ll = 1:1: length(sheets_inf)
        if strcmpi(sheets_inf{ll},'data')==1 || strcmpi(sheets_inf{ll},'資料')==1
            read_sheet = ll;
        end
    end
    [XYZ_temp,~,~] = xlsread(str,read_sheet);
end
if iscell(XYZ_temp)==1
    msgbox('Format of the input doesn''t meet the program requirements (Structure is "Cell")','ERROR','error');
    return
end
if isstruct(XYZ_temp)==1
    struct_name = fieldnames(XYZ_temp);
    if sum(strcmpi(struct_name,'data')) >= 1
        XYZ_temp = XYZ_temp.data;
    else
        msgbox('Format of the input doesn''t meet the program requirements (Structure is "Struct" without Field "data" )','ERROR','error');
        return
    end
end


varargout{1} = XYZ_temp;
varargout{2} = path_name;

end

