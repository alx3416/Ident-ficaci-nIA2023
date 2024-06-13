function vector1_0 = separadorEnCasosInador(numero,longitud)
% separadorEnCasosInador regresara un vector de tamaño longitud
% con un uno en la posición numero y ceros en los demas.
vector1_0 = zeros(longitud,1);
    vector1_0(numero) = 1;
end