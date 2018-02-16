function c = cal_c(md, cd, ms, i, superpixels)
%Caculate c for Gauss-Seidel iterations function
    up = zeros(3,1);
    low = 0.0;
    for j=1:length(superpixels{i})
        x = superpixels{i}(j,1);
        y = superpixels{i}(j,2);
        cl_ij = [superpixels{i}(j,3);superpixels{i}(j,4);superpixels{i}(j,5)];
        cd_ij = [cd(y,x,1);cd(y,x,2);cd(y,x,3)];
        md_ij = md(y,x);
        ms_ij = ms(y,x);
        up = up + ms_ij*(cl_ij-md_ij*cd_ij);
        low = low + ms_ij*ms_ij;
    end
    c = up/low;
end
