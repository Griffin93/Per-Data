clear all; clc;

database_path = 'C:\Users\user\Desktop\result\DATA\TIM10ed\CASME2\HR\';
ASM_path = 'C:\Users\user\Desktop\MicroExpression_Protocl_version1.00\ASM\';
mkdir_path = 'C:\Users\user\Desktop\result\DATA\TIM10ed\CASME2\SR\2_72\';


    cd(ASM_path)
    [sub_dir, sub_num] = FileList(database_path, ASM_path);
    
    for i = 1 : sub_num
        sub_name = getfield(sub_dir, {i + 2}, 'name');
        sub_name
        cd(ASM_path)
        [emo_dir, emo_num] = FileList([database_path '\' sub_name], ASM_path);
        for j = 1 : emo_num
            emo_name = getfield(emo_dir, {j + 2}, 'name');
            mkdir([mkdir_path num2str(i,'%02d')], emo_name );
            cd(ASM_path)
            [video_dir, video_num] = FileList([database_path '\' sub_name '\' emo_name], ASM_path);            
            for in = 1 : video_num
                video_name = getfield(video_dir, {in + 2}, 'name');
                mkdir([mkdir_path num2str(i,'%02d') '\' emo_name], video_name );
            end
        end
    end