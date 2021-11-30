function StepHome(s)

% Outer loop with large steps - driving motor back home
out = LimitSwitch;

while out ==1
fprintf(s,'-80\n')
pause(0.1)
out = LimitSwitch;
end

% Bring motor forward once it has reached home
fprintf(s,'150\n')
pause(0.5)

% Inner loop with small steps - this will ensure the rest position is
% closer to the point where the limit switch is activated

out = LimitSwitch;

while out ==1

fprintf(s,'-10\n')
pause(0.1)
out = LimitSwitch;
end



%%%% This is the old, simplified code without the limit homing function
% out = LimitSwitch;
% while out ==1
% 
% fprintf(s,'-20\n')
% pause(0.1)
% out = LimitSwitch;
% end
