% helperEstimateRelativePose Robustly estimate relative camera pose
%  [orientation, location, inlierIdx] = helperEstimateRelativePose(
%    matchedPoints1, matchedPoints2, cameraParams) returns the pose of
%  camera 2 in camera 1's coordinate system. The function calls
%  estimateEssentialMatrix and cameraPose functions in a loop, until
%  a reliable camera pose is obtained.
%
%  Inputs:
%  -------
%  matchedPoints1 - points from image 1 specified as an M-by-2 matrix of
%                   [x,y] coordinates, or as any of the point feature types
%  matchedPoints2 - points from image 2 specified as an M-by-2 matrix of
%                   [x,y] coordinates, or as any of the point feature types
%  cameraParams   - cameraParameters object
%
%  Outputs:
%  --------
%  orientation - the orientation of camera 2 relative to camera 1
%                specified as a 3-by-3 rotation matrix
%  location    - the location of camera 2 in camera 1's coordinate system
%                specified as a 3-element vector
%  inlierIdx   - the indices of the inlier points from estimating the
%                fundamental matrix
%
%  See also estimateEssentialmatrix, estimateFundamentalMatrix,
%  relativeCameraPose

% Copyright 2016 The MathWorks, Inc.

function [orientation, location,isOK] = ...
    SFRMEstimateRelativePose(matchedPoints1, matchedPoints2, cameraParams)

if ~isnumeric(matchedPoints1)
    matchedPoints1 = matchedPoints1.Location;
end

if ~isnumeric(matchedPoints2)
    matchedPoints2 = matchedPoints2.Location;
end

K = cameraParams.IntrinsicMatrix;
K = K';

nPts = size(matchedPoints1,1);
pts1_ = K\[matchedPoints1';ones(1,nPts)];
pts2_ = K\[matchedPoints2';ones(1,nPts)];


%EcasdId = [1 8 11 4 7 10 13];
EcasdId = 2:1:14;
Emat = calEssentialFivePoints(pts1_(:,EcasdId),pts2_(:,EcasdId),K,K);
sovN = length(Emat);

if(sovN<1)
    orientation=0;
    location=0;
    isOK = 0;
    return;
end



tmpResi = zeros(sovN,nPts);
for j=1:sovN
    tmpResi(j,:) = (calDEFinal(pts2_,Emat{j},pts1_)+calDEFinal(pts1_,Emat{j}',pts2_))/2;
end
[~,mE] = min(sum(tmpResi.^2,2));
E = Emat{mE(1)};


inlierPoints1 = matchedPoints1;
inlierPoints2 = matchedPoints2;

% Compute the camera pose from the fundamental matrix. Use half of the
% points to reduce computation.
[orientation, location, ~] = ...
    relativeCameraPose(E, cameraParams, inlierPoints1(1:2:end, :),...
    inlierPoints2(1:2:end, :));

isOK = 1;

% validPointFraction is the fraction of inlier points that project in
