function [ output_args ] = relativePoseWithEssential(kps1,kps2)
%RELATIVEPOSEWITHESSENTIAL Summary of this function goes here
%helperEstimateRelativePose(...
%                clocP, clocC, cameraParams);
%   Detailed explanation goes here
nKps = size(kps1,2);
E_all =  calEssentialFivePoints(kps1,kps2,eye(3),eye(3));
nE = length(E_all);
cdE = zeros(nE,nKps);
for i=1:nE
    cdE(i,:) = calDEFinal(kps2,E_all{i},kps1)+calDEFinal(kps1,E_all{i}',kps2);    
end

function algNorm = calDEFinal(kps1_,Emat,kps2_)
%CALALGEBRAERROR Summary of this function goes here
%   Detailed explanation goes here
epl1 = Emat*kps2_;
alg = abs(diag(epl1'*kps1_))';
algNorm = alg./sqrt((epl1(1,:).^2+epl1(2,:).^2));
end


end

