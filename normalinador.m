function tablaNormalizada = normalinador(tablaNormalizar,graficar)
% normalinador 
%   Normaliza los valores de corriennte, potencia y voltaje
%   de la tabla que tiempo que reciba.

    if nargin < 2
        graficar = true;
    end

    % Normalize Data
    tablaNormalizada = normalize(tablaNormalizar,...
        "DataVariables",["current","power","voltage"]);

    % Display results
    if graficar
        f = figure("Units","Normalized");
        dv = [1 3 4];
        N = numel(dv);
        f.Position = [0 0 1 N/3];
        tiledlayout(N,1,"Padding","compact");
        for k = 1:N
            nexttile
            plot(tablaNormalizar.timeCurrent,tablaNormalizada.(dv(k)),...
                "Color",[0 114 189]/255,"LineWidth",1.5,"DisplayName",...
                "Normalized data")
            legend("Location","EastOutside")
            ylabel(tablaNormalizar.Properties.VariableNames{dv(k)},...
                "Interpreter","none")
            if k == N
                xlabel("timeCurrent")
            end
        end
        f.NextPlot = "new";
        clear f dv N k
    end
end