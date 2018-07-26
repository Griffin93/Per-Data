%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         Add emotional labels and group them
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;

ASM_path = 'C:\Users\user\Desktop\MicroExpression_Protocl_version1.00\ASM\';
data_file = 'C:\Users\user\Desktop\CA\Registration\';
new_file = 'C:\Users\user\Desktop\result\DATA\HR_CASME2\';
xls_path = 'C:\Users\user\Desktop\';

cd(xls_path)
[num,txt,raw] = xlsread('CASME2-coding-updated.xlsx','Sheet4');
fields = {'Subject','Filename','Emotion'};
a = cell2struct(raw, fields, 2);

cd(data_file)
sub_dir = dir;
sub_num = length(sub_dir)-2;
for i = 1 : sub_num
    sub_name = getfield(sub_dir, {i + 2}, 'name');
    sub_name
    mkdir(new_file, sub_name);
    mkdir([new_file sub_name], 'happiness');
    mkdir([new_file sub_name], 'surprise');
    mkdir([new_file sub_name], 'others');
    mkdir([new_file sub_name], 'disgust');
    mkdir([new_file sub_name], 'repression');
    
%     cd(ASM_path)
%     [video_dir, video_num] = FileList([data_file sub_name], ASM_path);
%     for j = 1 : video_num
%         video_name = getfield(video_dir, {j + 2}, 'name');
%         a_num = length(a);
%         for k = 1 : a_num
%             aa = strcmp(sub_name,a(k).Subject);
%             bb = strcmp(video_name,a(k).Filename);
%             if (aa == 1) && (bb == 1)
%                 movefile([data_file sub_name '\' a(k).Filename],[new_file sub_name '\' a(k).Emotion '\' ]);
%             end
%         end
%     end
end
