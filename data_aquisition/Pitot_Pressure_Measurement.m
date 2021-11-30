function [] = Pitot_Pressure_Measurement(varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                    GUI setup                       %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

F.fh = figure('units','pixels',...
    'position',[300 200 466 181],...
    'menubar','none',...
    'name','Pitot Location Control',...
    'numbertitle','off',...
    'resize','off',...
    'color',[0.94 0.94 0.94]);

%%%%%%%%%%%%%%%%%  Title   %%%%%%%%%%%%%%%%%

F.footer = uicontrol('style','text',...
    'unit','pix',...
    'position',[15 8 50 15],...
    'fontsize',6,...
    'string','v.1.1');

%%%%%%%%%%%%%%%%%  Main Panel   %%%%%%%%%%%%%%%%%
F.pan1=uipanel('Title','Pitot Tube Position Control','FontSize',8,...
    'units','pix',...
    'Position',[7 2 459 177],...
    'BorderType','etchedin' ,...
    'BorderWidth',1);



F.txt_currentlocationtitle = uicontrol('Parent',F.pan1,'style','text',...
    'unit','pix',...
    'position',[50 110 120 15],...
    'fontsize',8,...
    'string','Current Pitot Location:');
F.txt_currentlocation = uicontrol('Parent',F.pan1,'style','text',...
    'unit','pix',...
    'position',[170 100 50 30],...
    'fontsize',12,...
    'string','Home');


%%%%%%%%%%%%%%%%%  Sampling rate edit boxes %%%%%%%%%%%%%%%%%%
F.txt_SampleRate = uicontrol('Parent',F.pan1,'style','text',...
    'unit','pix',...
    'position',[250 135 100 15],...
    'fontsize',8,...
    'string','Sampling Rate:');
F.edt_SampleRate = uicontrol('Parent',F.pan1,'style','edit',...
    'unit','pix',...
    'position',[355 135 52 15],...
    'fontsize',8,...
    'string','500',...
    'backgroundcolor','white');

F.txt_SampleTime = uicontrol('Parent',F.pan1,'style','text',...
    'unit','pix',...
    'position',[250 110 100 15],...
    'fontsize',8,...
    'string','Sampling Time:');
F.edt_SampleTime = uicontrol('Parent',F.pan1,'style','edit',...
    'unit','pix',...
    'position',[355 110 52 15],...
    'fontsize',8,...
    'string','2',...
    'backgroundcolor','white');



%%%%%%%%%%%%%%%%%  Push Button   %%%%%%%%%%%%%%%%%
F.pb_port1 = uicontrol('Parent',F.pan1,'style','push',...
    'position',[55 70 40 20],...
    'string','Port 1');
F.pb_port2 = uicontrol('Parent',F.pan1,'style','push',...
    'position',[105 70 40 20],...
    'string','Port 2');
F.pb_port3 = uicontrol('Parent',F.pan1,'style','push',...
    'position',[155 70 40 20],...
    'string','Port 3');
F.pb_port4 = uicontrol('Parent',F.pan1,'style','push',...
    'position',[205 70 40 20],...
    'string','Port 4');
F.pb_port5 = uicontrol('Parent',F.pan1,'style','push',...
    'position',[255 70 40 20],...
    'string','Port 5');
F.pb_port6 = uicontrol('Parent',F.pan1,'style','push',...
    'position',[305 70 40 20],...
    'string','Port 6');
F.pb_port7 = uicontrol('Parent',F.pan1,'style','push',...
    'position',[355 70 40 20],...
    'string','Home');

F.pb_DataCollect = uicontrol('Parent',F.pan1,'style','push',...
    'position',[255 10 100 50],...
    'string','Collect Data');


currentlocation = 7;
PortPos = [5848 4848 3830 2763 1716 689 0];  % These are the step counts for each port, measured from home position
s = serialconnect('open');


    


set(F.pb_port1,'callback',{@pb_port1_call,F})
set(F.pb_port2,'callback',{@pb_port2_call,F})
set(F.pb_port3,'callback',{@pb_port3_call,F})
set(F.pb_port4,'callback',{@pb_port4_call,F})
set(F.pb_port5,'callback',{@pb_port5_call,F})
set(F.pb_port6,'callback',{@pb_port6_call,F})
set(F.pb_port7,'callback',{@pb_port7_call,F})
set(F.pb_DataCollect,'callback',{@pb_DataCollect_call,F})
set(F.fh,'CloseRequestFcn',@my_closereq)


start_up()



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                    Callbacks                       %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function start_up(varargin)
      
         pause(1.5)
         % check to see if probe is already at limit, if so move it forward
         % away from limit
         if LimitSwitch == 0
             StepMove(s,500,'forward')
         end
         
         pause(1)
         % reset to limit
         StepHome(s)
                 
        set(F.txt_currentlocation, 'string','Home')
        
        currentlocation = 7;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    function pb_port1_call(varargin)
        
        Oldlocation = currentlocation;
        currentlocation = 1;
        shift = PortPos(Oldlocation) - PortPos(currentlocation);
        
        move_stepper(shift)
        
        set(F.txt_currentlocation, 'string',['Port ',num2str(currentlocation)]);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function pb_port2_call(varargin)
        
        Oldlocation = currentlocation;
        currentlocation = 2;
        shift = PortPos(Oldlocation) - PortPos(currentlocation);
        
        move_stepper(shift)
        
        set(F.txt_currentlocation, 'string',['Port ',num2str(currentlocation)]);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function pb_port3_call(varargin)
        
        Oldlocation = currentlocation;
        currentlocation = 3;
        shift = PortPos(Oldlocation) - PortPos(currentlocation);
        
        move_stepper(shift)
        
        set(F.txt_currentlocation, 'string',['Port ',num2str(currentlocation)]);
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function pb_port4_call(varargin)
        
        Oldlocation = currentlocation;
        currentlocation = 4;
        shift = PortPos(Oldlocation) - PortPos(currentlocation);
        
        move_stepper(shift)
        
        set(F.txt_currentlocation, 'string',['Port ',num2str(currentlocation)]);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function pb_port5_call(varargin)
        
        Oldlocation = currentlocation;
        currentlocation = 5;
        shift = PortPos(Oldlocation) - PortPos(currentlocation);
        
        move_stepper(shift)
        
        set(F.txt_currentlocation, 'string',['Port ',num2str(currentlocation)]);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function pb_port6_call(varargin)
        
        Oldlocation = currentlocation;
        currentlocation = 6;
        shift = PortPos(Oldlocation) - PortPos(currentlocation);
        
        move_stepper(shift)
        
        set(F.txt_currentlocation, 'string',['Port ',num2str(currentlocation)]);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function pb_port7_call(varargin)
        
        StepHome(s)
        
        set(F.txt_currentlocation, 'string','Home')
        
        currentlocation = 7;
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function move_stepper(shift)
        
        if shift < 0
            StepMove(s,abs(shift),'forward')
        elseif shift > 0
            StepMove(s,abs(shift),'backwards')
        end
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function pb_DataCollect_call(varargin)
        disp(['Collecting Data: Pitot Probe at Port ', num2str(currentlocation)])
        
        % Get Settings from edit boxes
        t_s = str2num(get(F.edt_SampleTime,'string')); % sampling time in seconds
        f_s = str2num(get(F.edt_SampleRate,'string')); % sampling frequency
        
        % Check settings are within valid range
        if t_s >= 24
            warndlg('Sampling time beyond limit of 24s, it has been reset to this limit')
            t_s = 24;
            set
            set(F.edt_SampleTime, 'string','24')
        end
        if f_s > 4166
            warndlg('Sampling frequency beyond limit of 4166Hz, it has been reset to this limit')
            f_s = 4166;
            set(F.edt_SampleRate, 'string','4166')
        end
        
        % Acquire Data
        numScans = t_s*f_s;
        
        
        [dataV, ActualScanRate] = LabJack_ReadData (f_s, numScans);
        
        
        cd Data
        load('191028_Group1_StaticTapData_supersonic_7.mat','v_offset_mean')
        cd ../
        %v_offset_mean = [6.9213, 6.8523, 6.8006, 6.7822, 6.7379, 6.8803, 6.8281, 6.7447, 6.8171, 6.7404, 6.7506, 6.7415];
        
        % Convert Voltage to Pressure
        dataP           = (dataV - repmat(v_offset_mean,numScans,1)).* 1.7838e4 + 101325;
        dataP_mean      = mean(dataP);
        dataP_std       = std(dataP);
        totalP          = dataP_mean(12);
        cd Data
        save(['191028_Group1_TotalPressure_Port',num2str(currentlocation),'.mat'])
        cd ../
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function my_closereq(src,callbackdata)
        selection = questdlg('Close This Figure?',...
            'Close Request Function',...
            'Yes','No','Yes');
        switch selection,
            case 'Yes',
                delete(gcf)
                serialdisconnect(s);
            case 'No'
                return
        end
    end

end





