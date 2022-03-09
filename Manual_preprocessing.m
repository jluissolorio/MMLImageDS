%% PREPROCESAMIENTO DEL BANCO DE IMÁGENES
    %  Función dedicada a redimensionar el conjunto de imágenes del banco de
    %  datos, de tal manera que se mantengan todas estas, en una dimensión
    %  constante, además de poder ser tomadas cada una desde una carpeta que
    %  contenga a los ejemplos de las dos clases
 
    %  El conjunto de datos fue tomado de:
    %  https://www.kaggle.com/navoneel/brain-mri-images-for-brain-tumor-detection
 
    %  El banco de datos consiste en 253 imágenes tomadas mediante el proceso 
    %  de Resonancia Magnética.
    %  Son imágenes en escala de grises, en donde se pueden encontrar dos 
    %  clases particulares:  Datos sin Hemorragia / Datos de Hemorragia.
    %  Training: 70 imágenes (Negative) / 70 imágenes (Positive)
    clc
    clear all
    close all
    tic
    % Se establece el directorio desde el cual se encuentran las imágenes
    Non_Hemmo_srcFiles = dir('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Classes2\Non_HemmorhageData\*.png');
    Hemmo_srcFiles = dir('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Classes2\HemmorhageData\*.png');
 
    % Ciclo de lectura, redimensionamiento y guardado de las nuevas imágenes
    for i = 1 : 129
        Hemmo_filename = strcat('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Classes2\HemmorhageData\', Hemmo_srcFiles(i).name);
        
        Hemmo_im = imread(Hemmo_filename);
        [rows, columns, numberOfColorChannels] = size(Hemmo_im);
        if numberOfColorChannels > 1
            % It's a true color RGB image.  We need to convert to gray scale.
            Hemmo_im = rgb2gray(Hemmo_im);
        else
            % It's already gray scale.  No need to convert.
            Hemmo_im = Hemmo_im;
        end

        Hemmo_k = imresize(Hemmo_im,[300,300]);   % Dimensión redefinida 150 x 150 pixeles

        %% Redimensionado de imágenes a 30x30
        Hemmo_k = imresize(Hemmo_k,[300,300]);   % Dimensión redefinida 30 x 30 pixeles
        
        Hemmo_k = imadjust(Hemmo_k);
        
        
        for r = 1 : 300
            for s = 1 : 300
                if (Hemmo_k(r,s) > 0.72*255) && (Hemmo_k(r,s) < 0.86*255)
                    Hemmo_k(r,s) = 255;
                else
                    Hemmo_k(r,s) = 0;
                end
            end
        end
        
        % Filtro Media de 9x9
        Hemmo_k = imfilter(Hemmo_k, ones(10)/81, 'symmetric');
        
        % Operación morfológica de erosión y dilatación
        se_er = offsetstrel('ball',5,5);
        se_dil = offsetstrel('ball',7,7);
        se_clo = offsetstrel('ball',7,7);
        Hemmo_k = imclose(imdilate(imerode(Hemmo_k, se_er), se_dil), se_clo);
        %% Obtención de histograma de cada imagen
%         figure
% 
%         subplot(2,2,1); [C1, x1] = imhist(NH_imhist); 
%         bar(C1, 'r')
%         grid minor
%         ylabel('Intensidad');
%         subplot(2,2,2); imshow(NH_imhist); 
%         xlabel('Clase Non Hemmorrhage');
% 
%         subplot(2,2,3); [C2, x2] = imhist(H_imhist);
%         bar(C2, 'b')
%         grid minor
%         ylabel('Intensidad');
%         subplot(2,2,4); imshow(H_imhist); 
%         xlabel('Clase Hemmorrhage'); 
          Hemmo_k = imresize(Hemmo_k,[128,128]);   % Dimensión redefinida 30 x 30 pixeles
          media_NH(i,1) = std(double(Hemmo_k(:)),0,1);
%%      Guardado de imágenes en carpeta predefinida
        Hemmo_newfilename = strcat('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Segmented_Dataset\', Hemmo_srcFiles(i).name);
 
        imwrite(Hemmo_k, Hemmo_newfilename, 'png');   % Escritura en nueva carpeta
 
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    for i = 1 : 123
        Non_Hemmo_filename = strcat('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Classes2\Non_HemmorhageData\', Non_Hemmo_srcFiles(i).name);
                
        Non_Hemmo_im = imread(Non_Hemmo_filename);
        [rows, columns, numberOfColorChannels] = size(Non_Hemmo_im);
        if numberOfColorChannels > 1
            % It's a true color RGB image.  We need to convert to gray scale.
            Non_Hemmo_im = rgb2gray(Non_Hemmo_im);
        else
            % It's already gray scale.  No need to convert.
            Non_Hemmo_im = Non_Hemmo_im;
        end
         
        Non_Hemmo_k = imresize(Non_Hemmo_im,[300,300]);   % Dimensión redefinida 150 x 150 pixeles
        
        %% Redimensionado de imágenes a 30x30
        Non_Hemmo_k = imresize(Non_Hemmo_k,[300,300]);   % Dimensión redefinida 30 x 30 pixeles
                
        Non_Hemmo_k = imadjust(Non_Hemmo_k);
        
        for r = 1 : 300
            for s = 1 : 300
                if (Non_Hemmo_k(r,s) > 0.72*255) && (Non_Hemmo_k(r,s) < 0.91*255)
                    Non_Hemmo_k(r,s) = 255;
                else
                    Non_Hemmo_k(r,s) = 0;
                end
            end
        end
        
        % Filtro Media de 9x9
        Non_Hemmo_k = imfilter(Non_Hemmo_k, ones(10)/81, 'symmetric');
        
        % Operación morfológica de erosión y dilatación
        se_er = offsetstrel('ball',5,5);
        se_dil = offsetstrel('ball',7,7);
        se_clo = offsetstrel('ball',7,7);
        Non_Hemmo_k = imclose(imdilate(imerode(Non_Hemmo_k, se_er), se_dil), se_clo);

        %% Obtención de histograma de cada imagen
%         figure
% 
%         subplot(2,2,1); [C1, x1] = imhist(NH_imhist); 
%         bar(C1, 'r')
%         grid minor
%         ylabel('Intensidad');
%         subplot(2,2,2); imshow(NH_imhist); 
%         xlabel('Clase Non Hemmorrhage');
% 
%         subplot(2,2,3); [C2, x2] = imhist(H_imhist);
%         bar(C2, 'b')
%         grid minor
%         ylabel('Intensidad');
%         subplot(2,2,4); imshow(H_imhist); 
%         xlabel('Clase Hemmorrhage'); 
          Non_Hemmo_k = imresize(Non_Hemmo_k,[128,128]);   % Dimensión redefinida 30 x 30 pixeles
          media_NH(i,2) = std(double(Non_Hemmo_k(:)),0,1);
%%      Guardado de imágenes en carpeta predefinida
        NHemmo_newfilename = strcat('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Segmented_Dataset\', Non_Hemmo_srcFiles(i).name);
         
        imwrite(Non_Hemmo_k, NHemmo_newfilename, 'png');   % Escritura en nueva carpeta
         
    end
toc
media_NH
hold on
title('Niveles de Media ordenados - Con Procs')
xlabel('Número de Imagen')
ylabel('Nivel de Media')
grid on
plot(1:129,sort(media_NH(:,1)), 'b')
plot(1:129,sort(media_NH(:,2)), 'r')