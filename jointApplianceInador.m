function myNewMiniTable = jointApplianceInador(miniTable1,miniTable2)
%jointApplianceInador suma los parametros de dos electrodomésticos
%y recalcula los valores aparentes y factor de potencia.
%   
if height(miniTable1)<=height(miniTable2)
    n = height(miniTable1);
    newMiniTable = miniTable1;
    newAddMiniTable = miniTable2(1:n,:);
else
    n = height(miniTable2);
    newMiniTable = miniTable2;
    newAddMiniTable = miniTable1(1:n,:);
end

newMiniTable.real_current = newMiniTable.real_current...
    + newAddMiniTable.real_current;
newMiniTable.real_power = newMiniTable.real_power...
    + newAddMiniTable.real_power;
newMiniTable.reactive_current = newMiniTable.reactive_current...
    + newAddMiniTable.reactive_current;
newMiniTable.reactive_power = newMiniTable.reactive_power...
    + newAddMiniTable.reactive_power;

newMiniTable.current = sqrt(newMiniTable.real_current.^2 ...
    + newMiniTable.reactive_current.^2);
newMiniTable.power = sqrt(newMiniTable.real_power.^2 ...
    + newMiniTable.reactive_power.^2);

newMiniTable.pf = newMiniTable.real_current./newMiniTable.current;
newMiniTable.voltage = (newMiniTable.voltage + newAddMiniTable.voltage)./2;

myNewMiniTable = newMiniTable;
end