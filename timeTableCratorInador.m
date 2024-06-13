function myTimeTable = timeTableCratorInador(file)
    if nargin < 1
        file = ".\Pool2\Sensor3-";
    end
    variables = ["corriente" "fp" "potencia" "voltage"];
    
    current = importarTabla(file+variables(1)+".csv","current");
    current = table2timetable(current);
    pf = importarTabla(file+variables(2)+".csv","pf");
    pf = table2timetable(pf);
    power = importarTabla(file+variables(3)+".csv","power");
    power = table2timetable(power);
    voltge = importarTabla(file+variables(4)+".csv","voltage");
    voltge = table2timetable(voltge);
    
    timeCurrent = current.time-current.time(1);
    corriente_1s = timetable(timeCurrent,current.current);
    corriente_1s = retime(corriente_1s,'regular',"fillwithmissing",'TimeStep',seconds(1));
    corriente_1s.Properties.VariableNames(1) = "current";
    corriente_1s = fillmissing(corriente_1s,'previous');
    
    timePf = pf.time-pf.time(1);
    pf_1s = timetable(timePf,pf.pf);
    pf_1s = retime(pf_1s,'regular',"fillwithmissing",'TimeStep',seconds(1));
    pf_1s.Properties.VariableNames(1) = "pf";
    pf_1s = fillmissing(pf_1s,'previous');
    
    timePower = power.time-power.time(1);
    power_1s = timetable(timePower,power.power);
    power_1s = retime(power_1s,'regular',"fillwithmissing",'TimeStep',seconds(1));
    power_1s.Properties.VariableNames(1) = "power";
    power_1s = fillmissing(power_1s,'previous');
    
    timevoltage = voltge.time-voltge.time(1);
    voltage_1s = timetable(timevoltage,voltge.voltage);
    voltage_1s = retime(voltage_1s,'regular',"fillwithmissing",'TimeStep',seconds(1));
    voltage_1s.Properties.VariableNames(1) = "power";
    voltage_1s = fillmissing(voltage_1s,'previous');
    
    microwave_3 = synchronize(corriente_1s,pf_1s,"union","fillwithmissing");
    microwave_3 = synchronize(microwave_3,power_1s,"union","fillwithmissing");
    microwave_3 = synchronize(microwave_3,voltage_1s,"union","fillwithmissing");
    microwave_3.Properties.VariableNames(3) = "power";
    microwave_3.Properties.VariableNames(4) = "voltage";
    microwave_3 = fillmissing(microwave_3,"previous");
    microwave_3.real_current = microwave_3.pf.*microwave_3.current;
    microwave_3.reactive_current = sqrt(microwave_3.current.^2-microwave_3.real_current.^2);
    microwave_3.real_power = microwave_3.pf.*microwave_3.power;
    microwave_3.reactive_power = sqrt(microwave_3.power.^2-microwave_3.real_power.^2);

    myTimeTable = microwave_3;

    function tablaImportada = importarTabla(filename,valueName,dataLines)
        %% Input handling
        
        % If dataLines is not specified, define defaults
        if nargin < 3
            dataLines = [2, Inf];
        end
        
        opts = delimitedTextImportOptions("NumVariables", 2);
        % Specify range and delimiter
        opts.DataLines = dataLines;
        opts.Delimiter = ",";
        
        % Specify column names and types
        opts.VariableNames = ["time", valueName];
        opts.VariableTypes = ["datetime", "double"];
        
        % Specify file level properties
        opts.ExtraColumnsRule = "ignore";
        opts.EmptyLineRule = "read";
        
        % Specify variable properties
        opts = setvaropts(opts, "time", "InputFormat", "yyy-MM-dd'T'HH:mm:ss.S'Z'");
        
        % Import the data
        tablaImportada = readtable(filename, opts);
    end
end