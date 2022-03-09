%% Ejemplo de aplicación D-Means en BD Brain Cancer Dataset %%
%  Fecha: 15 de octubre de 2020
tic
clc; clear all; close all;

% [Dataset, m, n, Class1, Class2, Total_Classes] = Load_Dataset();
[Dataset, Count_px] = Load_Images_atts();

% for r = 1 : size(Dataset,1)
%     if r <= 129
%         Dataset(r,:) = Dataset(r,:)*mean(Count_px(1:129));
%     else
%         Dataset(r,:) = Dataset(r,:)*mean(Count_px(130:end));
%     end 
% end
% %%
% % Adición de clases al banco de datos
% Dataset(1:129,901) = 1;
% Dataset(130:end,901) = 0;
% 
% Class1 = [1:129];    % Clase MPM
% Class2 = [130:252];   % Clase AD
% Total_Classes = length(Class1) + length(Class2);    % Total de clases
% 
% % d-Means aplicado al banco de datos
% 
% % Aplicación de la función Means_Calculate, para calcular la media de cada
% % atributo de cada clase, y realizar la diferencia entre pares
% DatasetVal = Dataset;
% 
% parfor k =1:900 
%     DatasetVal = Dataset;
%     acert = 0;
%     tp = 0; fp = 0; tn = 0; fn = 0;
%     
%     for j = 1 : 252
%  
%         Test = DatasetVal(j,1:end-1);
%         DatasetVal(j,:) = [];
%         M = Means_Calculate(DatasetVal,j);
%         
%         % Función de aplicación de la metodología D-Means
%         [Sortedstd_DS, Sortedmean_DS, Sortedstd_DS_C1, Sortedmean_DS_C1, Sortedstd_DS_C2, Sortedmean_DS_C2, index] = DMeans(DatasetVal, M, k, j);
%         
%         % Definición de recta hipótesis mediante la media
%         maximumC1 = max(Sortedmean_DS_C2);
%         minimumC2 = min(Sortedmean_DS_C1);
%        
%         hyp = ((maximumC1 + minimumC2)/2); % + ((max(Sortedmean_DS_C1) + max(Sortedmean_DS_C2))/2);
%         
%         Test_std = std(Test,0,2);
%         Test_mean = mean(Test,2); % + ((max(Sortedmean_DS_C1) + max(Sortedmean_DS_C2))/2);
% 
%         % Cálculo de Accuracy
%         if j <= 129
%             if Test_mean >= hyp
%                 acert = acert + 1;
%                 correcto = 'TP';
%                 tp = tp + 1;
%             else
%                 correcto = 'FP';
%                 fp = fp + 1;
%             end
%         else
%             if Test_mean <= hyp
%                 acert = acert + 1;
%                 correcto = 'TN';
%                 tn = tn + 1;
%             else
%                 correcto = 'FN';
%                 fn = fn + 1;
%             end
%         end
%         DatasetVal = Dataset;
%     end
%     acc(k,1) = 100*(acert/252);
% end
% % index
% [best_acc idx_best] = max(acc)
% % Conf_Mat = [tp fp ; fn tn]
% toc
% 
% %%
% % El mejor 
% % idx_best = 893;
% % %%%%%%%%% Graficación
% % for k = idx_best:idx_best  
% %     DatasetVal = Dataset;
% %     acert = 0;
% %     tp = 0; fp = 0; tn = 0; fn = 0;
% %     
% %     for j = 100 : 100 :200
% %  
% %         Test = DatasetVal(j,1:end-1);
% %         DatasetVal(j,:) = [];
% %         M = Means_Calculate(DatasetVal,j);
% %         
% %         % Función de aplicación de la metodología D-Means
% %         [Sortedstd_DS, Sortedmean_DS, Sortedstd_DS_C1, Sortedmean_DS_C1, Sortedstd_DS_C2, Sortedmean_DS_C2, index] = DMeans(DatasetVal, M, k, j);
% %         
% %         % Definición de recta hipótesis mediante la media
% %         maximumC1 = max(Sortedmean_DS_C2);
% %         minimumC2 = min(Sortedmean_DS_C1);
% %         
% %         hyp = ((maximumC1 + minimumC2)/2); % + ((max(Sortedmean_DS_C1) + max(Sortedmean_DS_C2))/2);
% %         
% %         Test_std = std(Test,0,2);
% %         Test_mean = mean(Test,2); % + ((max(Sortedmean_DS_C1) + max(Sortedmean_DS_C2))/2);
% % 
% %         % Cálculo de Accuracy
% %         if j <= 129
% %             if Test_mean >= hyp
% %                 acert = acert + 1;
% %                 correcto = 'TP';
% %                 tp = tp + 1;
% %             else
% %                 correcto = 'FP';
% %                 fp = fp + 1;
% %             end
% %         else
% %             if Test_mean <= hyp
% %                 acert = acert + 1;
% %                 correcto = 'TN';
% %                 tn = tn + 1;
% %             else
% %                 correcto = 'FN';
% %                 fn = fn + 1;
% %             end
% %         end
% %         %  Graficación de la separación de clases mediante D-Means
% %         Plot_Positions(Sortedstd_DS_C1, Sortedmean_DS_C1, Sortedstd_DS_C2, Sortedmean_DS_C2, k, hyp, correcto)
% %         %plot(Test_std, Test_mean, '-s', 'MarkerSize', 12,'MarkerEdgeColor','black','MarkerFaceColor',[0.1 0.1 0.1])
% % %         legend('Clase HIV', 'Clase normal', 'Fcn.  Hipótesis', 'Patrón de prueba','FontSize', 14)
% %         legend('Clase HIV', 'Clase normal', 'Fcn.  Hipótesis','FontSize', 14)
% %         set(gca,'FontSize',14)
% %         DatasetVal = Dataset;
% %     end
% % end
% % Conf_Mat = [tp fp ; fn tn]
