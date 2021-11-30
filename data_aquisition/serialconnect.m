function s =serialconnect(action)
    
    

    s = serial('COM3');
    set(s,'Baudrate',9600);
    fopen(s);

