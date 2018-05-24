function result = movetablenewstupid(var,mode,distance);

if(mode == 5)                           % determines mode
    fprintf(var,'%c','5');                   % Sends signal to uC telling it home

elseif(mode == 2)
    fprintf(var,'%c','2');                   % Sends signal to uC telling it to move
    pause(1);                               % Adds a delay for lag
    fprintf(var,'%c',num2str(distance));     % Sends signal to uC specifying number of 25 micron steps  NOTE has to send it as a fucking character
   
end