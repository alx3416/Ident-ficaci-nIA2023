function smoothedTable = suaveinador(table2smooth,graficar)
% suaveinador 
%   Suavisa y grafica una timetable con el metodo movmean en intervalos de
%   un minuto.

    if nargin < 2
        graficar = true;
    end
    
    % Smooth input data
    smoothedTable = smoothdata(table2smooth,"movmean",minutes(1));
    
    % Display results
    if graficar
        f = figure("Units","Normalized");
        N = 4;
        f.Position = [0 0 1 N/3];
        tiledlayout(N,1,"Padding","compact");
        for k = 1:N
            nexttile
            plot(table2smooth.timeCurrent,table2smooth.(k),...
                "Color",[77 190 238]/255,"DisplayName","Input data")
            hold on
            plot(table2smooth.timeCurrent,smoothedTable.(k),"Color",[0 114 189]/255,...
                "LineWidth",1.5,"DisplayName","Smoothed data")
            legend("Location","EastOutside")
            ylabel(table2smooth.Properties.VariableNames{k},"Interpreter","none")
            if k == N
                xlabel("timeCurrent")
            end
        end
        f.NextPlot = "new";
        clear f N k
    end
end