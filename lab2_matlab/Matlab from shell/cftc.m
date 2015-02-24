close all
clear all
clc
carpeta = dir(strcat(pwd,'\*.tiff'));
format = 'jpg';
for k = 1:length(carpeta) 
imagen = carpeta(k).name; 
I = imread(strcat(pwd,'\',imagen));
nombre = strcat(imagen,' a jpg','.',format);
imwrite(I,nombre,format)
end


