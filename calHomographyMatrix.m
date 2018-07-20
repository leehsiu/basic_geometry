function [Hret] = calHomographyMatrix(kps1_,kps2_)
%kps in film plane
if ~isequal(size(kps1_), size(kps2_))
    error('Points matrices different sizes');
end
n = size(kps1_, 2);
if n < 4
    error('Need at least 4 matching points');
end
% Solve equations using SVD
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

kps1n_ = T1*kps1_;
kps2n_ = T2*kps2_;
A = zeros(n*2,9);
for i=1:n
    A(i*2-1,:)=[-kps1n_(:,i)' 0 0 0 kps2n_(1,i)*kps1n_(:,i)'];
    A(i*2,:)= [0 0 0  -kps1n_(:,i)' kps2n_(2,i)*kps1n_(:,i)'];
end

[~, ~, Va] = svd(A);
Hmat = (reshape(Va(:,9), 3, 3))';
Hret = T2\Hmat*T1;

kpr = Hret*kps1_;
c = mean(1./(kpr(3,:)));
Hret = c*Hret;




end

