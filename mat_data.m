%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                           low_data  &  high_data 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clc;

ASM_path = 'E:\MER\MicroExpression_Protocl_version1.00\ASM\';
data_file = 'E:\MER\result\DATA\TIM10ed\CASME2\LR\144\';   %LRimageΪ��άͼ�����ݣ�HRimageΪ��άͼ������
data_output = 'E:\MER\result\DATA\data\CASME2\TIM10_288\';    %LRdataΪ��ά�������ݣ�HRdataΪ��ά��������

data_Label = [];
data_u_Label = [];
data_v_Label = [];
em_Label = [];
sub_Label = [];
add = [];

cd(ASM_path);
[sub_dir,sub_num] = FileList(data_file , ASM_path);
for j = 1 : sub_num
    sub_name = getfield(sub_dir, {j + 2}, 'name');
    data3_Label = [];
    data_u3_Label = [];
    data_v3_Label = [];
    em3_Label = [];
    sub3_Label = [];
    add3 = [];
    
    cd(ASM_path);
    [emotion_dir, emotion_num] = FileList([data_file sub_name], ASM_path);
    for m = 1 : emotion_num
        emotion_name = getfield(emotion_dir, {m + 2}, 'name');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
       % CASME2
        switch emotion_name
            case 'repression'
                emotionVal = -2;
            case 'disgust'
                emotionVal = -1;
            case 'others'
                emotionVal = 0;
            case 'happiness'
                emotionVal = 1;
            case 'surprise'
                emotionVal = 2;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%
        % SMIC
%         switch emotion_name
%             case 'negative'
%                 emotionVal = -1;
%             case 'positive'
%                 emotionVal = 1;
%             case 'surprise'
%                 emotionVal = 2;
%         end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        data2_Label = [];
        data_u2_Label = [];
        data_v2_Label = [];
        em2_Label = [];
        sub2_Label = [];
        add2 = [];
        
        cd(ASM_path);
        [video_dir, video_num] = FileList([data_file sub_name '\' emotion_name], ASM_path);
        for in = 1 : video_num
            video_name = getfield(video_dir, {in + 2}, 'name');
            data1_Label = [];
            data_u1_Label = [];
            data_v1_Label = [];
            em1_Label = [];
            sub1_Label = [];
            add1 = [];
                        
            cd(ASM_path);
            [img_dir, img_num] = FileList([data_file sub_name '\' emotion_name '\' video_name], ASM_path);
            
            for k = 1 : img_num
                img_name = getfield(img_dir, {k + 2}, 'name');
                cd([data_file sub_name '\' emotion_name '\' video_name])
                img_RGB = imread(img_name);
                img_YUV = rgb2ycbcr(img_RGB);   % RGBתYUV
                                  
                Y = img_YUV(:,:,1);     % Y ����
                U = img_YUV(:,:,2);     % U ����
                V = img_YUV(:,:,3);     % V ����
                YY = reshape(Y,[],1);   % ����任Ϊһά����
                UU = reshape(U,[],1);
                VV = reshape(V,[],1);
                img_data = double(YY);  % ��Y�����任Ϊdouble��,img_dataΪ����ͼ����
                img_data_U = double(UU);
                img_data_V = double(VV);
                
                add1 = zeros(20734,img_num);  % 82944-2 high; 5184-2 low; 1296-2; 324-2
                                              % 16384-2 high; 4096-2 low; 1024-2; 256-2
                data1_Label(:,k) = img_data; % ��kѭ��������ͼ����s_data����Ϊs_name��һԪ�����ݣ���s1_ne_01��
                data_u1_Label (:,k) = img_data_U;
                data_v1_Label (:,k) = img_data_V;
                em1_Label(1,k) = emotionVal;
                sub1_Label(1,k) = j;
            end    % s_data���ɣ�s_name��ĳһԪ�����ݣ�
            data2_Label = [data2_Label,data1_Label];   % �㼯s_name���������emotion_name��ĳһԪ�����ݣ���negative��
            data_u2_Label = [data_u2_Label,data_u1_Label ];
            data_v2_Label  = [data_v2_Label,data_v1_Label];
            em2_Label = [em2_Label, em1_Label];
            sub2_Label = [sub2_Label, sub1_Label];
            add2 = [add2, add1];
        end % emotion_data���ɣ�emotion_name��ĳһԪ�����ݣ�
        data3_Label = [data3_Label,data2_Label];         % �㼯emotion_name���������video_name��ĳһԪ�����ݣ���s01��
        data_u3_Label = [data_u3_Label,data_u2_Label];
        data_v3_Label = [data_v3_Label,data_v2_Label];
        em3_Label = [em3_Label, em2_Label];
        sub3_Label = [sub3_Label,sub2_Label];
        add3 = [add3, add2];
    end   % video_data���ɣ�video_name��ĳһԪ�����ݣ�
    data_Label = [data_Label,data3_Label];
    data_u_Label = [data_u_Label,data_u3_Label];
    data_v_Label = [data_v_Label,data_v3_Label];
    em_Label = [em_Label, em3_Label];
    sub_Label = [sub_Label,sub3_Label];
    add = [add,add3];
    e_s_Label = [em_Label;sub_Label;add];
    sub_name
end
% LOW
re_data_low = cat(3,e_s_Label,data_Label);
re_data_uv_low = cat(3,data_u_Label,data_v_Label);
save([data_output 'data_144.mat'], 're_data_low', '-v7.3');   % data_low?????????????
save([data_output 'sub_data_UV_144.mat'], 're_data_uv_low', '-v7.3');
%% HIGH
% re_data_high = cat(3,e_s_Label,data_Label);
% re_data_uv_high = cat(3,data_u_Label,data_v_Label);
% save([data_output 'data_high.mat'], 're_data_high', '-v7.3');   % data_high?????????????
% save([data_output 'sub_data_UV_high.mat'], 're_data_uv_high', '-v7.3');