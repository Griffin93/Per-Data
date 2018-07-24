%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                   LR image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc;
close all;
ASM_path = 'C:\Users\user\Desktop\MicroExpression_Protocl_version1.00\ASM\';
LR_code = 'C:\Users\user\Desktop\code_paper\';
LR_output = 'C:\Users\user\Desktop\LR\144\';
HR_size = 'C:\Users\user\Desktop\result\DATA\TIM10ed\CASME2\HR\';

psf = fspecial('gaussian', 7, 0.85);   % 0.85±ê×¼²î
cd(LR_code)
A=Set_blur_matrix( psf );
B=Set_sample_matrix();

cd(ASM_path);
[sub_dir,sub_num] = FileList(HR_size, ASM_path);

for j = 1 : sub_num
    sub_name = getfield(sub_dir, {j + 2}, 'name');
    sub_name
    mkdir(LR_output, sub_name);
    cd(ASM_path);
    [emotion_dir, emotion_num] = FileList([HR_size sub_name], ASM_path);
        
    for m = 1 : emotion_num
        emotion_name = getfield(emotion_dir, {m + 2}, 'name');
        mkdir([LR_output, sub_name], emotion_name);
        cd(ASM_path);
        [video_dir, video_num] = FileList([HR_size sub_name '\' emotion_name], ASM_path);
        
        for in = 1 : video_num
            video_name = getfield(video_dir, {in + 2}, 'name');
            mkdir([LR_output sub_name '\' emotion_name], video_name);
            cd([HR_size sub_name '\' emotion_name '\' video_name])
            img_dir = dir;
            img_num = length(img_dir) - 2;
            
            for k = 1 : img_num
                img_name = getfield(img_dir, {k + 2}, 'name');
                
                img_RGB = imread(img_name);
                img_YUV = rgb2ycbcr(img_RGB);   % RGB×ªYUV
                [hn_YUV, wn_YUV, dn_YUV] = size(img_YUV);
                Y = img_YUV(:,:,1);     % Y ¾ØÕó
                U = img_YUV(:,:,2);     % U ¾ØÕó
                V = img_YUV(:,:,3);     % V ¾ØÕó
                
                YY = reshape(Y,[],1);
                UU = reshape(U,[],1);
                VV = reshape(V,[],1);
                img = double(YY);
                ATY=(B*A)*img(:);
                
                YYY = reshape(ATY,144,144);
                YYY = uint8(YYY);
                UUU = imresize(U,1/2);
                VVV = imresize(V,1/2);
                
                Img_YUV(:,:,1) = YYY;
                Img_YUV(:,:,2) = UUU;
                Img_YUV(:,:,3) = VVV;
                
                Img_RGB = ycbcr2rgb(Img_YUV);
                
                %%%%%%%%%%%%%%%%%%%%%%%%
                %                 img_gray = imread(img_name);
                %                 img_col = reshape(img_gray,[],1);
                %                 img = double(img_col);
                %                 ATY=(B*A)*img(:);
                %                 img = reshape(ATY,40,40);
                %                 img = uint8(img);
                %%%%%%%%%%%%%%%%%%%
                
                imwrite(Img_RGB,[LR_output sub_name '\' emotion_name '\' video_name '\' img_name],'png');
                
            end
        end
    end
    cd ..
end
