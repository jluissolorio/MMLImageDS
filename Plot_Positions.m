function [] = Plot_Positions(Sortedstd_DS_C1, Sortedmean_DS_C1, Sortedstd_DS_C2, Sortedmean_DS_C2, k, hyp, correcto)
%Plot_Positions Summary of this function goes here
%   Detailed explanation goes here
    figure
    grid on
    hold on

    plot(Sortedstd_DS_C1, Sortedmean_DS_C1,'r', 'LineWidth',1.25)
    plot(Sortedstd_DS_C2, Sortedmean_DS_C2,'b', 'LineWidth',1.25)
    
%     line([0 127],[ max(Sortedmean_DS_C1),  max(Sortedmean_DS_C1) ],'Color','red');
%     line([0 127],[ min(Sortedmean_DS_C2),  min(Sortedmean_DS_C2) ],'Color','blue');
    
%     line([0,127],[hyp, hyp],'Color','red')
%     line([0,127],[hyp, hyp],'Color','blue')
    
    yline(hyp, '-.m', 'LineWidth', 2.25);
    % Etiquetado de ejes y título 
    xlabel('Desviación Estándar(x)', 'FontSize', 16)
    ylabel('Media(x)', 'FontSize', 16)
    title(['Gráfica de std vs mean aplicando D-Means (', num2str(k) ,' posiciones) '] , 'FontSize', 18)
end

