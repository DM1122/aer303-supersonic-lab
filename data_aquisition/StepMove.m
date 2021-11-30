function StepMove(s,steps,dir)

if strncmp(dir,'forward',3)
   fprintf(s,[num2str(steps),'\n'])
elseif strncmp(dir,'backward',3)
    fprintf(s,['-',num2str(steps),'\n'])  
end

