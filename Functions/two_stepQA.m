function two_stepQA = two_stepQA(ref, dis)

% Input
% ref         -  reference image
% dis         -  distorted version of reference image

%% NIQE score computation of reference image

 load modelparameters.mat
 
 blocksizerow    = 96;
 blocksizecol    = 96;
 blockrowoverlap = 0;
 blockcoloverlap = 0;

niqe = computequality(ref,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
    mu_prisparam,cov_prisparam);

%% MS-SSIM score computation of distorted image with reference image

img1 = double(rgb2gray(ref));
img2 = double(rgb2gray(dis));

K = [0.01 0.03];
winsize = 11;
sigma = 1.5;
window = fspecial('gaussian', winsize, sigma);
level = 5;
weight = [0.0448 0.2856 0.3001 0.2363 0.1333];
method = 'product';

msssim = ssim_mscale_new(img1, img2, K, window, level, weight, 'product');

%% 2stepQA score computation

two_stepQA = msssim*(1-niqe/100);

end
