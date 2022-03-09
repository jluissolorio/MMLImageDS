function [Sortedstd_DS, Sortedmean_DS, Sortedstd_DS_C1, Sortedmean_DS_C1, Sortedstd_DS_C2, Sortedmean_DS_C2, index] = DMeans(DatasetVal, M, k, j)
%DMeans Summary of this function goes here
    % Se ordenan de mayor a menor relevancia las media M calculada y se extrae
    % el valor del atributo de cada media calculada
    [ordered_dmeans1, index]= sort(M, 'descend');
    
    % Tomar los primeros k elementos del conjunto ordenado
%     k = input('Elija el número de atributos de relevancia: ');
%     k = 200;

    % De nueva cuenta se realizará ese ordenamiento para cada clase, para
    % verificar que se consigue la separación paulatina de las clases mediante
    % la observación en la gráfica
    
    if j <= 129
        ClassOne_M = DatasetVal(1:128, index(1:k));
        ClassTwo_M = DatasetVal(129:end, index(1:k));
    else
        ClassOne_M = DatasetVal(1:129, index(1:k));
        ClassTwo_M = DatasetVal(130:end, index(1:k));
    end

    % Cálculo de la desviación estándar de los primeros k atributos relevantes
    % para la clase 1
    std_DS_C1 = std(ClassOne_M,0,2);
    mean_DS_C1 = mean(ClassOne_M, 2);
    % Cálculo de la desviación estándar de los primeros k atributos relevantes
    % para la clase 2
    std_DS_C2 = std(ClassTwo_M,0,2);
    mean_DS_C2 = mean(ClassTwo_M, 2);
    
    % Ordenamiento de la Desviación Estándar de los atributos de mayor
    % relevancia para clase 1 y 2 respectivamente.
    [Sortedstd_DS_C1, idx_sortC1] = sort(std_DS_C1, 'ascend');
    Sortedmean_DS_C1 = mean_DS_C1(idx_sortC1);
    
    [Sortedstd_DS_C2, idx_sortC2] = sort(std_DS_C2, 'ascend');
    Sortedmean_DS_C2 = mean_DS_C2(idx_sortC2);
    
    % Concatenación para generación de un par de arreglos
    Sortedstd_DS = cat(1, Sortedstd_DS_C1, Sortedstd_DS_C2);
    Sortedmean_DS = cat(1, Sortedmean_DS_C1, Sortedmean_DS_C2);
end

