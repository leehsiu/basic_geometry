function E = calEssentialEightPoints(kps1_,kps2_)
%CALESSENTIALEIGHTPOINTS Summary of this function goes here
%   Detailed explanation goes here
x1bar = mean(kps1_(1,:));
y1bar = mean(kps1_(2,:));
s1 = sqrt(2)/(mean(sqrt((kps1_(1,:)-x1bar).^2+(kps1_(2,:)-y1bar).^2)));
tx1 = -s1*x1bar;
ty1 = -s1*y1bar;
T1 = [s1 0 tx1;0 s1 ty1;0 0 1];

x2bar = mean(kps2_(1,:));
y2bar = mean(kps2_(2,:));
s2 = sqrt(2)/(mean(sqrt((kps2_(1,:)-x2bar).^2+(kps2_(2,:)-y2bar).^2)));
tx2 = -s2*x2bar;
ty2 = -s2*y2bar;
T2 = [s2 0 tx2;0 s2 ty2;0 0 1];

q1 = T1*kps1_;
q2 = T2*kps2_;


q = [q1(1,:)'.* q2(1,:)', q1(2,:)'.* q2(1,:)', q1(3,:)'.* q2(1,:)', ...
     q1(1,:)'.* q2(2,:)', q1(2,:)'.* q2(2,:)', q1(3,:)'.* q2(2,:)', ...
     q1(1,:)'.* q2(3,:)', q1(2,:)'.* q2(3,:)', q1(3,:)'.* q2(3,:)']; 
[~,~,Vq] = svd(q);
W = Vq(:,end);
mask = [1,2,3;4,5,6;7,8,9];
Wmat = W(mask);
[U,~,V] = svd(Wmat);
Wmat = U*diag([1 1 0])*V';
E = T2'*Wmat*T1;


%E = U*diag([1 1 0])*V';
end

