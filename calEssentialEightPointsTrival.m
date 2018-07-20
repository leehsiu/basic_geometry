function E = calEssentialEightPointsTrival(kps1_,kps2_)
%CALESSENTIALEIGHTPOINTS Summary of this function goes here
%   Detailed explanation goes here

q1 = kps1_;
q2 = kps2_;


q = [q1(1,:)'.* q2(1,:)', q1(2,:)'.* q2(1,:)', q1(3,:)'.* q2(1,:)', ...
     q1(1,:)'.* q2(2,:)', q1(2,:)'.* q2(2,:)', q1(3,:)'.* q2(2,:)', ...
     q1(1,:)'.* q2(3,:)', q1(2,:)'.* q2(3,:)', q1(3,:)'.* q2(3,:)']; 
[~,~,Vq] = svd(q);
W = Vq(:,end);
mask = [1,2,3;4,5,6;7,8,9];
Wmat = W(mask);
[U,D,V] = svd(Wmat);
E = U*diag([D(1,1) D(2,2) 0])*V';



%E = U*diag([1 1 0])*V';
end

