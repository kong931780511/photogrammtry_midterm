function m = cal_m(ms, cd, cs, cl_ij)
% cauculate the m in Gauss-Seidel iterations function
    m = (cd'*(cl_ij-ms*cs))/(cd'*cd);
end
