function img=en_de_cryptMessage(img,key,imgSize)
%Function for encrypting and decrypting image
%It generates random 2D matrix based on a key which is used as seed
%Then bitwise XOR operation is done on the message image to excrypt it with
%the psuedorandom noisy data
rng(key);
Nonce=uint8(randi([0 1],imgSize));
img=bitxor(img,Nonce);
rng('default');
end
