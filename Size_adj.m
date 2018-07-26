%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              Image size adjustment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc;

ASM_path = 'C:\Users\user\Desktop\MicroExpression_Protocl_version1.00\ASM\';
data_path = 'C:\Users\user\Desktop\result\DATA\HR_CASME2\';

cd(data_path);
sub_dir = dir;
sub_num = length(sub_dir)-2;

for j = 17 : sub_num
    
    sub_name = getfield(sub_dir, {j + 2}, 'name');
    sub_name    
    cd(ASM_path);
    [micro_dir, micro_num] = FileList([data_path sub_name], ASM_path);
    
    for i = 1 : micro_num
        micro_name = getfield(micro_dir, {i + 2}, 'name');
        
        cd(ASM_path)
        [video_dir, video_num] = FileList([data_path sub_name '\' micro_name], ASM_path);
       
        for k = 1 : video_num
            video_name = getfield(video_dir, {k + 2}, 'name');
            
            cd([video_dir(k).folder '\' video_name])            
            img_dir = dir;
            img_num = length(img_dir) - 2;
            
            for l = 1 : img_num
                img_name = getfield(img_dir, {l + 2}, 'name');
                img = imread(img_name);
                img=imresize(img,[288,288]);
                imwrite(img,[data_path sub_name '\' micro_name '\' video_name '\' img_name],'png');
                
            end
        end
    end    
    cd ..
end

