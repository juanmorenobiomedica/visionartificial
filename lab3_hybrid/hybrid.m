close all
clear all
clc
% Frecuencia de corte del filtro gausiano
sigma = 25; 
%dirección de las imágenes.
   path1 = strcat(pwd,'\arreglo.bmp');
   path2 = strcat(pwd,'\einstein.bmp');
%Lectura de las imágenes.
   I1 = imread(path1);
   I2 = imread(path2);
%Transformación de las imágens al dominio de fourier con fft2
   Imfft1 = fftshift(fft2(double(I1)));
   Imfft2 = fftshift(fft2(double(I2)));
  
%Generando el filtro gaussiano
  [m,n,z] = size(I1);
   h = fspecial('gaussian', [m n], sigma);
%Normalizando a 1 el filtro gaussiano
   h = h./max(max(h));

% Asignación previa del espacio de formación de la imágen hibrida
J_= zeros(m,n,z);

%Generando la imágen hibrida usando la ecuación en el dominio de fourier
%para las tres componentes de la imagen (RGB)
% I=I1*H+I2*(1-H) donde H es el filtro pasa baja y (1-H) el filtro pasa
% altas
    for colorI = 1:3
      J_(:,:,colorI) = Imfft1(:,:,colorI).*h +Imfft2(:,:,colorI).*(1-h);
   end
 % Transformada inversa de Fourier, devuelve las imágenes filtradas y
 % superpuestas al dominio original 
  J = uint8(ifft2(ifftshift(J_)));
  
    Ip0=impyramid(J, 'expand');
    Ip1=impyramid(J, 'reduce');
    Ip2=impyramid(Ip1, 'reduce');
    Ip3=impyramid(Ip2, 'reduce');
    
    subplot(2,3,1), image(Ip0)
    subplot(2,3,2), image(J)
    subplot(2,3,3), image(Ip1)
    subplot(2,3,4), image(Ip2)
    subplot(2,3,5), image(Ip3)
    print ('-dpng','piramide.png');
%     figure, imshow (Ip0)
%     print ('-dpng','piramide1.png');
%     figure, imshow (J)
%     print ('-dpng','piramide2.png');
%     figure, imshow (Ip1)
%     print ('-dpng','piramide3.png');
%     figure, imshow (Ip2)
%     print ('-dpng','piramide4.png');
%     figure, imshow (Ip3)
%     print ('-dpng','piramide5.png');
%     
% %Creación del archivo con la imagen hibrida
 imwrite(J,'hybrid.bmp','bmp');
 
%Código tomado de https://homes.cs.washington.edu/~duhao/Projects/HybridImage/HybridImage.html