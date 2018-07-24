function  A   =  Set_sample_matrix()  
%对图像下采样，取N个点的平均值，图像尺寸和下采样倍数需要变动，2011.12.13
s          =   2;%采样放大倍数
%[lh lw] =   size(LR);
lh=144;
lw=144;
hh         =   lh*s; %超分后图像放大s倍
hw         =   lw*s;
M          =   lh*lw;%低分图像像素
N          =   hh*hw;%高分图像像素
psf        =   ones(s,s)./(s*s);
ws         =   size(psf, 1 );

ker        =   psf;

nv         =   ws*ws;
nt         =   (nv)*M;
R          =   zeros(nt,1);
C          =   zeros(nt,1);
V          =   zeros(nt,1);
cnt        =   1;

pos     =  (1:hh*hw);
pos     =  reshape(pos, [hh hw]);

for lrow = 1:lh
    for lcol = 1:lw
        
        row        =   (lrow-1)*s + 1;
        col        =   (lcol-1)*s + 1;
        
        row_idx    =   (lcol-1)*lh + lrow;
        
        
        rmin       =  row;
        rmax       =  row+s-1;
        cmin       =  col;
        cmax       =  col+s-1;
        sup        =  pos(rmin:rmax, cmin:cmax);%滤波器模板行列上最小值与最大值。
        col_ind    =  sup(:);
        

        
        ker2       =  ker;%滤波器的形状
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
A   =  sparse(R, C, V, M, N);%M*N大小的稀疏矩阵，，M为小图像素点个数，N为大图像素点个数，其中（R,C）的值为对应的权值