function [md, ms, cd, cs] = GS_iter(superpixels, md, ms, cd, cs, n)
% Using Gauss-Seidel iterations to caculate the ms md cd and cs

md_new = zeros(size(md), 'like', md);
ms_new = zeros(size(ms), 'like', ms);
cd_new = zeros(size(cd), 'like', cd);
cs_new = zeros(size(cs), 'like', cs);

n_sp = length(superpixels);
iter = 0;
while(iter<n)
    iter = iter + 1;
    % the solving is performed for each super pixel individually
    for i=1:n_sp
        % step1: calculate cd_new for each super pixel
        cd_i = cal_c(ms, cd, md, i, superpixels);
        
        for j = 1 : length(superpixels{i})
            x = superpixels{i}(j,1);
            y = superpixels{i}(j,2);
            cd_new (y,x,:) = cd_i;
        end
        
%         step2: calculate md_k1 for each pixel
        for j=1:length(superpixels{i})
            x = superpixels{i}(j,1);
            y = superpixels{i}(j,2);
            cl_ij = [superpixels{i}(j,3); superpixels{i}(j,4); superpixels{i}(j,5)];
            ms_ij = ms(y,x);
            cd_ij = [cd_new(y,x,1); cd_new(y,x,2); cd_new(y,x,3)];
            md_new (y,x) = cal_m(ms_ij, cd_ij, cs, cl_ij);
        end
        
        % step3: calculate ms_k1 for each pixel
        for j=1:length(superpixels{i})
            x = superpixels{i}(j,1);
            y = superpixels{i}(j,2);
           cl_ij = [superpixels{i}(j,3);superpixels{i}(j,4);superpixels{i}(j,5)];
            cd_ij = [cd_new(y,x,1); cd_new(y,x,2); cd_new(y,x,3)];
            md_ij = md_new (y,x);
            ms_new (y,x) = cal_m(md_ij, cs, cd_ij, cl_ij);
        end
        % step4: calculate Cs_k1 via all the pixels
            cs_new  = cal_c(md_new , cd_new , ms_new , i, superpixels);
    end
    % step5: update the new values
    md = md_new ;
    ms = ms_new ;
    cd = cd_new ;
    cs = cs_new ;
end

