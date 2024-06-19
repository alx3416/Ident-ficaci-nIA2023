function tablaSinOutliers = remueveOutliersInador(tablaConOutliers,graficar)
    if nargin < 2
        graficar = true;
    end
    
    % remueveOutliersInador Summary
    %   remueveOutliers de una tabla con outliers
    
    % Outliers remotion
    [tablaSinOutliers,outlierIndices,thresholdLow,thresholdHigh] = ...
        filloutliers(tablaConOutliers,"previous","movmedian",minutes(1));
    if graficar
        % Display results
        f = figure("Units","Normalized");
        N = 4;
        f.Position = [0 0 1 N/3];
        tiledlayout(N,1,"Padding","compact");
        for k = 1:N
            nexttile
            plot(tablaConOutliers.time,tablaConOutliers.(k),...
                "Color",[77 190 238]/255,"DisplayName","Input data")
            hold on
            plot(tablaConOutliers.time,tablaSinOutliers.(k),"Color",[0 114 189]/255,...
                "LineWidth",1.5,"DisplayName","Cleaned data")
        
            % Plot outliers
            plot(tablaConOutliers.time(outlierIndices(:,k)),tablaConOutliers.(k)(outlierIndices(:,k)),...
                "x","Color",[64 64 64]/255,"DisplayName","Outliers")
        
            % Plot filled outliers
            plot(tablaConOutliers.time(outlierIndices(:,k)),tablaSinOutliers.(k)(outlierIndices(:,k)),".",...
                "MarkerSize",12,"Color",[217 83 25]/255,"DisplayName","Filled outliers")
        
            % Plot outlier thresholds
            plot([tablaConOutliers.time(:); missing; tablaConOutliers.time(:)],...
                [thresholdHigh.(k)(:); missing; thresholdLow.(k)(:)],...
                "Color",[145 145 145]/255,"DisplayName","Outlier thresholds")
        
            title("Number of outliers cleaned: " + nnz(outlierIndices(:,k)))
            legend("Location","EastOutside")
            ylabel(tablaConOutliers.Properties.VariableNames{k},"Interpreter","none")
            if k == N
                xlabel("time")
            end
        end
        f.NextPlot = "new";
        clear thresholdLow thresholdHigh f N k
    end
end