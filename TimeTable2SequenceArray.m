function [currentArray, pfArray, powerArray, voltageArray, outputLabelsArray] = TimeTable2SequenceArray(inputTimeTable, sample_size)
%jointApplianceInador suma los parametros de dos electrodomésticos
%y recalcula los valores aparentes y factor de potencia.
%   
currentArray = [];
pfArray = [];
powerArray = [];
voltageArray = [];
outputLabelsArray = [];
[rows, ~] = size(inputTimeTable);
iteration = 1;
while sample_size * iteration <= rows
    currentArray = [currentArray; inputTimeTable.current(((iteration-1)*sample_size)+1:iteration*sample_size)'];
    pfArray = [pfArray; inputTimeTable.pf(((iteration-1)*sample_size)+1:iteration*sample_size)'];
    powerArray = [powerArray; inputTimeTable.power(((iteration-1)*sample_size)+1:iteration*sample_size)'];
    voltageArray = [voltageArray; inputTimeTable.voltage(((iteration-1)*sample_size)+1:iteration*sample_size)'];
    outputLabelsArray = [outputLabelsArray; categorical(inputTimeTable.appliances(((iteration-1)*sample_size)+1))];
    iteration = iteration + 1;
end
end