function  A   =  Set_blur_matrix( psf )
%对图像进行模糊化操作，psf为模板，函数中h,w控制输入图像的尺寸需要变动，2011.12.13
%s          =   4;
%[lh lw] =   size(LR);
h=288;
w=288;
% hh         =   lh*s; %超分后图像放大s倍
% hw         =   lw*s;
%M          =   lh*lw;%低分图像像素
N          =   h*w;%高分图像像素

ws         =   size(psf, 1 );
t          =   (ws-1)/2;
cen        =   ceil(ws/2);
ker        =   psf;

nv         =   ws*ws;
nt         =   (nv)*N;
R          =   zeros(nt,1);
C          =   zeros(nt,1);
V          =   zeros(nt,1);
cnt        =   1;

pos     =  (1:h*w);
pos     =  reshape(pos, [h w]);

for row = 1:h
    for col = 1:w
        

        row_idx    =   (col-1)*h + row;
        
        
        rmin       =  max( row-t, 1);
        rmax       =  min( row+t, h);
        cmin       =  max( col-t, 1);
        cmax       =  min( col+t, w);
        sup        =  pos(rmin:rmax, cmin:cmax);%滤波器模板行列上最小值与最大值。
        col_ind    =  sup(:);
        
        r1         =  row-rmin;
        r2         =  rmax-row;
        c1         =  col-cmin;
        c2         =  cmax-col;
        
        ker2       =  ker(cen-r1:cen+r2, cen-c1:cen+c2);%滤波器的形状
        ker2       =  ker2(:);

        nn         =  size(col_ind,1);
        
        R(cnt:cnt+nn-1)  =  row_idx;%对于滤波器的大小（一般为nn=49），存储当前处理模板中心点的索引值（小图）
        C(cnt:cnt+nn-1)  =  col_ind;%对于当前滤波器范围内，所有点的索引值。（大图）
        V(cnt:cnt+nn-1)  =  ker2/sum(ker2);%滤波器中各点的权值
        cnt              =  cnt + nn;
    end
end

R   =  R(1:cnt-1);
C   =  C(1:cnt-1);
V   =  V(1:cnt-1);
A   =  sparse(R, C, V, N, N);%M*N大小的稀疏矩阵，N为图像素点个数，其中（R,C）的值为V，R为滤波器对应小图中心点索引值，C为滤波器对应点在大图中的索引，V为权值这个值即DH