% Shaobing Gao, Wangwang Han, Kaifu Yang, Chaoyi Li, and Yongjie Li: Efficient Color 
% Constancy with Local Surface Reflectance Statistics. In: Proceedings of European Conference on 
% Computer Vision (ECCV), pp. 158¨C173 (2014)
% 
% Any questions, please contact: 
% Email: gao_shaobing@163.com (Shaobing Gao) or liyj@uestc.edu.cn (Yongjie Li)
%
% Visual Cognition and Computation Lab (VCCL),
% Key Laboratory for Neuroinformation of Ministry of Education,
% School of Life Science and Technology,
% University of Electronic Science and Technology of China,
% North Jianshe Road,
% Chengdu, 610054, China



%%demo 
clear all
close all
load('groundtruth_illuminant.mat'); %The groundtruth illuminant of orginal color-biased iamge

%input image
inputpicture=imread('demo_image284.tif');  

% The size of local patch, which is the only parameter in our model.
% Ideally, this parameter is image dependent, and you can set it an optimal value for each image.
% In the work of ECCV2014, we set optimal patch sizes for each datasets.
%
patchsize=100;  

% local estimated surface reflectance
[temporary]=spatial_adaption_edge(double(inputpicture),patchsize);

% illuminant estimation
Estimatedillum(1,1)=sum(sum(double(inputpicture(:,:,1))))./sum(sum(temporary(:,:,1)));
Estimatedillum(2,1)=sum(sum(double(inputpicture(:,:,2))))./sum(sum(temporary(:,:,2)));
Estimatedillum(3,1)=sum(sum(double(inputpicture(:,:,3))))./sum(sum(temporary(:,:,3)));

% With this estimated illuminant, you can correct the original color-biased image to
% the canonical image under white light source 
%

% normalizing the illuminant 
norma=Estimatedillum(1,1)+Estimatedillum(2,1)+Estimatedillum(3,1);
Estimatedillum(1,1)=Estimatedillum(1,1)./norma;
Estimatedillum(2,1)=Estimatedillum(2,1)./norma;
Estimatedillum(3,1)=Estimatedillum(3,1)./norma;

%color-biased image correction with estimated illuminant

corrected_picture(:,:,1)=(1/3)*(double(inputpicture(:,:,1))./Estimatedillum(1,1));
corrected_picture(:,:,2)=(1/3)*(double(inputpicture(:,:,2))./Estimatedillum(2,1));
corrected_picture(:,:,3)=(1/3)*(double(inputpicture(:,:,3))./Estimatedillum(3,1));


% angular error 
Angularerror=angerr(Estimatedillum,groundtruth_illuminant); 
% you should offer the canonical illuminant 
%of input color-biased image for angular error computation


% image display
subplot(1,2,1);
imshow(inputpicture);
title('color-biased image','fontsize',13);
subplot(1,2,2);
imshow(uint16(corrected_picture));
title(['corrected image (angular error=' num2str(roundn(Angularerror,-1)) '^o)'],'fontsize',13);







