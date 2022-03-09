function [M] = Means_Calculate(DatasetVal, j)
%Means_Calculate Summary of this function goes here
% Se calcula la media de los atributos de la clase 1
    if j <= 129
        M1 = mean(DatasetVal(1:128,1:end-1));
        % Se calcula la media de los atributos de la clase 2
        M2 = mean(DatasetVal(129:end,1:end-1));
    else
        M1 = mean(DatasetVal(1:129,1:end-1));
        % Se calcula la media de los atributos de la clase 2
        M2 = mean(DatasetVal(130:end,1:end-1));
    end
    % Se calcula la diferencia entre medias de ambas clases
    M = M1 - M2;
end

