clc; clear all;
database_path = 'C:\Users\user\Desktop\result\Features\HR_SAMM\';
% database_path = 'C:\Users\user\Desktop\www\';
ASM_path = 'C:\Users\user\Desktop\ME_code\ASM\';
cd(ASM_path);
[TIM_dir, TIM_num] = FileList(database_path, ASM_path);

for i = 1 : TIM_num
    TIM_name = getfield(TIM_dir, {i + 2}, 'name');
    TIM_name
    cd(ASM_path)
    [sub_dir, sub_num] = FileList([database_path TIM_name], ASM_path);
    
    for j = 1 : sub_num
        sub_name = getfield(sub_dir, {j + 2}, 'name');
        sub_name
        cd(ASM_path)
        [emo_dir, emo_num] = FileList([database_path TIM_name '\' sub_name], ASM_path);
        
        for lk = 1 : emo_num
            emo_name = getfield(emo_dir, {lk + 2}, 'name');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%             cd([database_path TIM_name '\' sub_name '\' emo_name])
%             video_dir = dir;
%             video_num = length(video_dir) - 2;
%             
%             for kk = 1 : video_num
%                 video_name = getfield(video_dir, {kk + 2}, 'name');
%                 movefile(video_name,[database_path TIM_name '\' sub_name]);
%             end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            cd([database_path TIM_name '\' sub_name])
            if strcmp(emo_name, 'anger')
                rmdir(emo_name);
            elseif strcmp(emo_name, 'contempt')
                rmdir(emo_name);
            elseif strcmp(emo_name, 'surprise')
                rmdir(emo_name);
            elseif strcmp(emo_name, 'disgust')
                rmdir(emo_name);
            elseif strcmp(emo_name, 'fear')
                rmdir(emo_name);
            elseif strcmp(emo_name, 'sadness')
                rmdir(emo_name);
            elseif strcmp(emo_name, 'happiness')
                rmdir(emo_name);
            elseif strcmp(emo_name, 'other')
                rmdir(emo_name);
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
    end
end
