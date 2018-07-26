clc; clear all;
database_path = 'C:\Users\user\Desktop\result\Features\HR_SAMM\';
ASM_path = 'C:\Users\user\Desktop\MicroExpression_Protocl_version1.00\ASM\';

cd(ASM_path);
[TIM_dir, TIM_num] = FileList(database_path, ASM_path);

for i = 1 : TIM_num
    TIM_name = getfield(TIM_dir, {i + 2}, 'name');
    cd(ASM_path)
    [sub_dir, sub_num] = FileList([database_path TIM_name], ASM_path);
    
    for j = 1 : sub_num
        sub_name = getfield(sub_dir, {j + 2}, 'name');
        cd(ASM_path)
        [emo_dir, emo_num] = FileList([database_path TIM_name '\' sub_name], ASM_path);
        
        for k = 1 : emo_num
            emo_Name = getfield(emo_dir, {k + 2}, 'name');
            
            switch emo_Name
                case 'anger'
                    adname = 'an_';
                case 'contempt'
                    adname = 'co_';
                case 'surprise'
                    adname = 'sur_';
                case 'disgust'
                    adname = 'dis_';
                case 'fear'
                    adname = 'fe_';
                case 'happiness'
                    adname = 'hap_';
                case 'other'
                    adname = 'o_';
                case 'sadness'
                    adname = 'sad_';
            end
            
            cd([database_path TIM_name '\' sub_name '\' emo_Name]);
            videoDir = dir('*.mat');
            nMat = length(videoDir);
            
            for iMat = 1 : nMat
                iMat
                videoName = getfield(videoDir, {iMat}, 'name');                
                oldname = videoName;
                newname = [adname,oldname];
                eval(['!rename' 32 oldname 32 newname]);
                
            end
        end
    end
end
