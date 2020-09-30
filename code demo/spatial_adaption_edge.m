function   [temporary]=spatial_adaption_edge(input_picture,Size)

% this is a simple algorithm for locally estimating the reflectance of image
% with the fast implementation, if you have better method to optimize this
% algorithm please tell me.

% contact email: gao_shaobing@163.com

% inputs:
%       input_picture:the RGB picture
%       Size: the size of local region
%outputs: 
%       output_picture:the picture's locally estimated reflectance
% 
% 2014.09.21 ---- by Gao Shaobing
%=========================================================================%
if nargin < 2
    Size=15; 
end
if rem(Size,2)==0
    Size=Size+1; 
end
[a b c]=size(input_picture);
if (Size>min(a,b));
    % disp('the Size should be smaller than the size of original image'); 
    temporary(:,:,1)=input_picture(:,:,1)./max(max(input_picture(:,:,1)));
    temporary(:,:,2)=input_picture(:,:,2)./max(max(input_picture(:,:,2)));
    temporary(:,:,3)=input_picture(:,:,3)./max(max(input_picture(:,:,3)));
    %temporary=[];
    
else
% center_gao=fspecial('gaussian',Size,radius);
% input_picture=double(input_picture);
% input_picture(:,:,1)=conv2(input_picture(:,:,1),center_gao,'same');
% input_picture(:,:,2)=conv2(input_picture(:,:,2),center_gao,'same');
% input_picture(:,:,3)=conv2(input_picture(:,:,3),center_gao,'same');
if (Size<=1)
    temporary=ones(a,b,c);   % equal to grey world
else
    
x_lable=floor(a/Size);%floor
y_lable=floor(b/Size);
% Determine the Block size of the region according the image size;
center_start_label=(Size+1)/2;
for i=1:x_lable
    for j=1:y_lable
    chnannel1(:,:,1)=double(input_picture(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),((center_start_label+(j-1)*Size)-(Size+1)/2+1):((center_start_label+(j-1)*Size)+(Size+1)/2-1),1));
    chnannel1(:,:,2)=double(input_picture(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),((center_start_label+(j-1)*Size)-(Size+1)/2+1):((center_start_label+(j-1)*Size)+(Size+1)/2-1),2));
    chnannel1(:,:,3)=double(input_picture(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),((center_start_label+(j-1)*Size)-(Size+1)/2+1):((center_start_label+(j-1)*Size)+(Size+1)/2-1),3));
    if (max(max(chnannel1(:,:,1)))~=0)
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),((center_start_label+(j-1)*Size)-(Size+1)/2+1):((center_start_label+(j-1)*Size)+(Size+1)/2-1),1)=chnannel1(:,:,1)./max(max(chnannel1(:,:,1)));%%
    else
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),((center_start_label+(j-1)*Size)-(Size+1)/2+1):((center_start_label+(j-1)*Size)+(Size+1)/2-1),1)=0;
    end
    
    if (max(max(chnannel1(:,:,2)))~=0)                
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),((center_start_label+(j-1)*Size)-(Size+1)/2+1):((center_start_label+(j-1)*Size)+(Size+1)/2-1),2)=chnannel1(:,:,2)./max(max(chnannel1(:,:,2)));%%
    else
         temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),((center_start_label+(j-1)*Size)-(Size+1)/2+1):((center_start_label+(j-1)*Size)+(Size+1)/2-1),2)=0;
    end

    if (max(max(chnannel1(:,:,3)))~=0)
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),((center_start_label+(j-1)*Size)-(Size+1)/2+1):((center_start_label+(j-1)*Size)+(Size+1)/2-1),3)=chnannel1(:,:,3)./max(max(chnannel1(:,:,3)));%%spatial contrast picture;
    else
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),((center_start_label+(j-1)*Size)-(Size+1)/2+1):((center_start_label+(j-1)*Size)+(Size+1)/2-1),3)=0;
    end

    end
    
    chnannel2(:,:,1)=double(input_picture(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),(y_lable*Size+1):b,1));
    chnannel2(:,:,2)=double(input_picture(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),(y_lable*Size+1):b,2));
    chnannel2(:,:,3)=double(input_picture(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),(y_lable*Size+1):b,3));
    if (max(max(chnannel2(:,:,1)))~=0)
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),(y_lable*Size+1):b,1)=chnannel2(:,:,1)./max(max(chnannel2(:,:,1)));%%
    else
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),(y_lable*Size+1):b,1)=0;
    end
 if (max(max(chnannel2(:,:,2)))~=0)
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),(y_lable*Size+1):b,2)=chnannel2(:,:,2)./max(max(chnannel2(:,:,2)));%%
    else
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),(y_lable*Size+1):b,2)=0;
 end
   if (max(max(chnannel2(:,:,3)))~=0)
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),(y_lable*Size+1):b,3)=chnannel2(:,:,3)./max(max(chnannel2(:,:,3)));%%
    else
    temporary(((center_start_label+(i-1)*Size)-(Size+1)/2+1):((center_start_label+(i-1)*Size)+(Size+1)/2-1),(y_lable*Size+1):b,3)=0;
    end  
end
for jj=1:y_lable
 chnannel3(:,:,1)=double(input_picture((x_lable*Size+1):a,((center_start_label+(jj-1)*Size)-(Size+1)/2+1):((center_start_label+(jj-1)*Size)+(Size+1)/2-1),1));
 chnannel3(:,:,2)=double(input_picture((x_lable*Size+1):a,((center_start_label+(jj-1)*Size)-(Size+1)/2+1):((center_start_label+(jj-1)*Size)+(Size+1)/2-1),2));
 chnannel3(:,:,3)=double(input_picture((x_lable*Size+1):a,((center_start_label+(jj-1)*Size)-(Size+1)/2+1):((center_start_label+(jj-1)*Size)+(Size+1)/2-1),3));
 if (max(max(chnannel3(:,:,1)))~=0)
    temporary((x_lable*Size+1):a,((center_start_label+(jj-1)*Size)-(Size+1)/2+1):((center_start_label+(jj-1)*Size)+(Size+1)/2-1),1)=chnannel3(:,:,1)./max(max(chnannel3(:,:,1)));%%
    else
    temporary((x_lable*Size+1):a,((center_start_label+(jj-1)*Size)-(Size+1)/2+1):((center_start_label+(jj-1)*Size)+(Size+1)/2-1),1)=0;
 end
 if (max(max(chnannel3(:,:,2)))~=0)
    temporary((x_lable*Size+1):a,((center_start_label+(jj-1)*Size)-(Size+1)/2+1):((center_start_label+(jj-1)*Size)+(Size+1)/2-1),2)=chnannel3(:,:,2)./max(max(chnannel3(:,:,2)));%%
    else
    temporary((x_lable*Size+1):a,((center_start_label+(jj-1)*Size)-(Size+1)/2+1):((center_start_label+(jj-1)*Size)+(Size+1)/2-1),2)=0;
 end
   if (max(max(chnannel3(:,:,3)))~=0)
    temporary((x_lable*Size+1):a,((center_start_label+(jj-1)*Size)-(Size+1)/2+1):((center_start_label+(jj-1)*Size)+(Size+1)/2-1),3)=chnannel3(:,:,3)./max(max(chnannel3(:,:,3)));%%
    else
    temporary((x_lable*Size+1):a,((center_start_label+(jj-1)*Size)-(Size+1)/2+1):((center_start_label+(jj-1)*Size)+(Size+1)/2-1),3)=0;
    end  
end
 chnannel4(:,:,1)=double(input_picture((x_lable*Size+1):a,(y_lable*Size+1):b,1));
 chnannel4(:,:,2)=double(input_picture((x_lable*Size+1):a,(y_lable*Size+1):b,2));
 chnannel4(:,:,3)=double(input_picture((x_lable*Size+1):a,(y_lable*Size+1):b,3));
if (max(max(chnannel4(:,:,1)))~=0)
    temporary((x_lable*Size+1):a,(y_lable*Size+1):b,1)=chnannel4(:,:,1)./max(max(chnannel4(:,:,1)));%%
    else
    temporary((x_lable*Size+1):a,(y_lable*Size+1):b,1)=0;
 end
 if (max(max(chnannel4(:,:,2)))~=0)
    temporary((x_lable*Size+1):a,(y_lable*Size+1):b,2)=chnannel4(:,:,2)./max(max(chnannel4(:,:,2)));%%
    else
    temporary((x_lable*Size+1):a,(y_lable*Size+1):b,2)=0;
 end
   if (max(max(chnannel4(:,:,3)))~=0)
    temporary((x_lable*Size+1):a,(y_lable*Size+1):b,3)=chnannel4(:,:,3)./max(max(chnannel4(:,:,3)));%%
    else
    temporary((x_lable*Size+1):a,(y_lable*Size+1):b,3)=0;
    end  
end
end
end
