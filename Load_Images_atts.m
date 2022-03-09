function [Dataset, Count_px] = Load_Images_atts()
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

    Img_Dataset = dir('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Resized_Dataset\*.png');
    Segmented_Img_Dataset = dir('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Segmented_Dataset\*.png');
    tic
    for i = 1 : 252
        Dataset_elemnt = strcat('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Resized_Dataset\', Img_Dataset(i).name);
        Dataset_elemnt = imread(Dataset_elemnt);
        
        Dataset_seg = strcat('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Segmented_Dataset\', Segmented_Img_Dataset(i).name);
        Dataset_seg = imread(Dataset_seg);
        
%         Dataset_img_full = ((Dataset_elemnt));
        Dataset_img = 255*((im2double((Dataset_elemnt))));
        Count_px(i,:) = sum(Dataset_seg(:))/1e5;
        Dataset(i,:) = Dataset_img(:);
    end
    toc
%     for i = 130 : 252
%         Dataset_elemnt = strcat('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Resized_Dataset\', Img_Dataset(i).name);
%         Dataset_elemnt = imread(Dataset_elemnt);
%         
%         Dataset_seg = strcat('C:\Users\the_p\OneDrive\Documentos\B20_MASTER\BrainHemmorhage_Dataset\Brain Tumor Images Dataset\Segmented_Dataset\', Segmented_Img_Dataset(i).name);
%         Dataset_seg = imread(Dataset_seg);
%         
% %         Dataset_img_full = ((Dataset_elemnt));
%         Dataset_img = 255*((im2double((Dataset_elemnt))));
%         Count_px(i,:) = sum(Dataset_seg(:))/1e5;
%         Dataset(i,:) = Dataset_img(:);
%     end
end
