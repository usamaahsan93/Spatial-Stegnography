%%% DECRYPT %%%%
[R,Rdir,~]=uigetfile({'*.jpg;*.png'},'Pick Source Image');
img=strcat(Rdir,R);
img=imread(img);
[iRow,iCol]=size(img(:,:,1));
key=input('Enter Key for Decrypt : ');

getImg=bitget(img(:,:,1),1);

decryptMsg=en_de_cryptMessage(getImg,key,[iRow,iCol]);

figure,imshow(decryptMsg,[]);
