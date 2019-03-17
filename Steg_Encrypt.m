%Stegnography Encryption

%m is used for message
%i is used for Image
close all
%Taking two file directories for input
% 1) Image 2) Message
[I,Rdir,~]=uigetfile({'*.jpg;*.png'},'Pick Main Image');
[M,Mdir,~]=uigetfile({'*.jpg;*.png'},'Pick Message Image');
img=strcat(Rdir,I);
msg=strcat(Mdir,M);
%REading the images from the recieved directories
img=imread(img);
msg=imread(msg);

%Sizing of the message is handle, the msg is resized to the lowest
%dimension of the image and the remaing side is padded to make it complete
%with the dimensions of img
[iRow,iCol]=size(img(:,:,1));

if(iRow>iCol)
    msg=imresize(msg,[NaN iCol]);
    [mRow,mCol]=size(msg(:,:,1));
    msg=padarray(msg,[iRow-mRow 0],'post');

elseif(iRow<iCol)
    msg=imresize(msg,[iRow NaN]);
    [mRow,mCol]=size(msg(:,:,1));
    msg=padarray(msg,[0 iCol-mCol],'post');
    
else
    [mRow,mCol]=size(msg(:,:,1));
    if(mRow<mCol)
    msg=imresize(msg,[iRow NaN]); 
    msg=padarray(msg,[0 iCol-mCol],'post');
    
    else
    msg=imresize(msg,[iRow NaN]);
    [mRow,mCol]=size(msg(:,:,1));
    msg=padarray(msg,[0 iCol-mCol],'post');
    end
    
end
   
%Taking Key for encrypting the message
key=input('Enter Key for Encrypt : ');
%Message is converted to binary image and then send to another function for
%encryption
msg=uint8(im2bw(msg));
encryptMsg=en_de_cryptMessage(msg,key,[iRow,iCol]);
%last bit from the img image is cleared and added with the msg image. 
maskedImg=bitand(img(:,:,1),uint8(254));
img(:,:,1)=maskedImg+encryptMsg;
%Final image displayed
figure, imshow(img);
%Saved in .png format because .jpeg compresses the image and the message is
%lost where as .png does not compress it so its size is also greater in
%comparision with jpeg
imwrite(img,'ImageCarryingMessage.png');
