function  A   =  Set_blur_matrix( psf )
%��ͼ�����ģ����������psfΪģ�壬������h,w��������ͼ��ĳߴ���Ҫ�䶯��2011.12.13
%s          =   4;
%[lh lw] =   size(LR);
h=288;
w=288;
% hh         =   lh*s; %���ֺ�ͼ��Ŵ�s��
% hw         =   lw*s;
%M          =   lh*lw;%�ͷ�ͼ������
N          =   h*w;%�߷�ͼ������

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
        sup        =  pos(rmin:rmax, cmin:cmax);%�˲���ģ����������Сֵ�����ֵ��
        col_ind    =  sup(:);
        
        r1         =  row-rmin;
        r2         =  rmax-row;
        c1         =  col-cmin;
        c2         =  cmax-col;
        
        ker2       =  ker(cen-r1:cen+r2, cen-c1:cen+c2);%�˲�������״
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
A   =  sparse(R, C, V, N, N);%M*N��С��ϡ�����NΪͼ���ص���������У�R,C����ֵΪV��RΪ�˲�����ӦСͼ���ĵ�����ֵ��CΪ�˲�����Ӧ���ڴ�ͼ�е�������VΪȨֵ���ֵ��DH