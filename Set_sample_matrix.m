function  A   =  Set_sample_matrix()  
%��ͼ���²�����ȡN�����ƽ��ֵ��ͼ��ߴ���²���������Ҫ�䶯��2011.12.13
s          =   2;%�����Ŵ���
%[lh lw] =   size(LR);
lh=144;
lw=144;
hh         =   lh*s; %���ֺ�ͼ��Ŵ�s��
hw         =   lw*s;
M          =   lh*lw;%�ͷ�ͼ������
N          =   hh*hw;%�߷�ͼ������
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
        sup        =  pos(rmin:rmax, cmin:cmax);%�˲���ģ����������Сֵ�����ֵ��
        col_ind    =  sup(:);
        

        
        ker2       =  ker;%�˲�������״
        ker2       =  ker2(:);

        nn         =  size(col_ind,1);
        
        R(cnt:cnt+nn-1)  =  row_idx;%�����˲����Ĵ�С��һ��Ϊnn=49�����洢��ǰ����ģ�����ĵ������ֵ��Сͼ��
        C(cnt:cnt+nn-1)  =  col_ind;%���ڵ�ǰ�˲�����Χ�ڣ����е������ֵ������ͼ��
        V(cnt:cnt+nn-1)  =  ker2/sum(ker2);%�˲����и����Ȩֵ
        cnt              =  cnt + nn;
    end
end

R   =  R(1:cnt-1);
C   =  C(1:cnt-1);
V   =  V(1:cnt-1);
A   =  sparse(R, C, V, M, N);%M*N��С��ϡ����󣬣�MΪСͼ���ص������NΪ��ͼ���ص���������У�R,C����ֵΪ��Ӧ��Ȩֵ