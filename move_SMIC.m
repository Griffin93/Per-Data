clear all; clc;

ASM_path = 'C:\Users\user\Desktop\MicroExpression_Protocl_version1.00\ASM\';
database_path = 'C:\Users\user\Desktop\result\DATA\TIM10ed\CASME2\SR\2_72\';


cd(ASM_path)
[sub_dir, sub_num] = FileList(database_path, ASM_path);

for i = 1 : sub_num
    sub_name = getfield(sub_dir, {i + 2}, 'name');
    sub_name
    cd([database_path sub_name]);
    imgDir = dir('*.png');
    nMat = length(imgDir);
    for iMat = 1 : nMat
        imgName = getfield(imgDir, {iMat}, 'name');
        index_path = findstr(imgName,'_');
        index_path2 = findstr(imgName,'.');
        emoNamenu = imgName(index_path(2)+1:index_path2-1);
        if emoNamenu == '1'
            movefile(imgName,[database_path num2str(i,'%02d') '\' 'happiness' '\' ]);
        elseif emoNamenu == '2'
            movefile(imgName,[database_path num2str(i,'%02d') '\' 'surprise' '\' ]);
        elseif emoNamenu == '-1'
            movefile(imgName,[database_path num2str(i,'%02d') '\' 'disgust' '\' ]);
        elseif emoNamenu == '-2'
            movefile(imgName,[database_path num2str(i,'%02d') '\' 'repression' '\' ]);
        elseif emoNamenu == '0'
            movefile(imgName,[database_path num2str(i,'%02d') '\' 'others' '\' ]);
        end
    end
    
%     emoDir = dir('*.');  % 读取文件夹信息
%     nemo = length(emoDir)-2;
%     for iemo = 1 : nemo
%         emoName = getfield(emoDir, {iemo+2}, 'name');
%         
%         cd([database_path sub_name '\' emoName]);
%         %     cd([database_path sub_name '\' 'negative']);
%         img2Dir = dir('*.png');  % 读取图片信息
%         nnMat = length(img2Dir);
%         videoDir = dir('*.');  % 读取文件夹信息
%         nvideo = length(videoDir)-2;
%         for iiMat = 1 : nnMat
%             img2Name = getfield(img2Dir, {iiMat}, 'name');  % 图片名称
%             index_path3 = findstr(img2Name,'_');
%             vidnuName = img2Name(index_path3(1)+1:index_path3(2)-1); % 图片的图片号
%             imgNum = str2num(vidnuName);  % 1-1640
%             for ivideo = 1 : nvideo
%                 vidName = getfield(videoDir, {ivideo+2}, 'name');  % 片段文件夹名称
%                 index_path4 = findstr(vidName,'_');
%                 vid_clip_Name = vidName(index_path4(2)+1:end);  % 片段文件夹号
%                 clipNum = str2num(vid_clip_Name);
%                 imgN = ceil(imgNum/10);
%                 if clipNum == imgN
%                     movefile(img2Name,[database_path num2str(i,'%02d') '\' 'negative' '\' vidName]);
%                 end
%             end
%         end
%     end
        
end


