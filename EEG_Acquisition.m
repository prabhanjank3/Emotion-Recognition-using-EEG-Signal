function varargout = EEG_Acquisition(varargin)
% EEG_ACQUISITION M-file for EEG_Acquisition.fig
%      EEG_ACQUISITION, by itself, creates a new EEG_ACQUISITION or raises the existing
%      singleton*.
%
%      H = EEG_ACQUISITION returns the handle to a new EEG_ACQUISITION or the handle to
%      the existing singleton*.
%
%      EEG_ACQUISITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EEG_ACQUISITION.M with the given input arguments.
%
%      EEG_ACQUISITION('Property','Value',...) creates a new EEG_ACQUISITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EEG_Acquisition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EEG_Acquisition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EEG_Acquisition

% Last Modified by GUIDE v2.5 22-Jan-2015 12:37:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EEG_Acquisition_OpeningFcn, ...
                   'gui_OutputFcn',  @EEG_Acquisition_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before EEG_Acquisition is made visible.
function EEG_Acquisition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EEG_Acquisition (see VARARGIN)

% Choose default command line output for EEG_Acquisition
handles.output = hObject;
%     close all;
%     clear all;
%     clc;

    a=imread('eeg.jpg');
    axes(handles.axes1)
    imshow(a);
 
     axes(handles.axes2)
     grid on;
     axis([0 100 0 100])
     hold on;
     
     axes(handles.axes3)
     grid on;
     xlim([0 100]);
     hold on;
%    axis([0 100 0 8388607]) 
    
     axes(handles.axes4)
     grid on;
     xlim([0 100]);
     hold on;
%      axis([0 100 0 16777215])

     axes(handles.axes5)
     grid on;
     xlim([0 100]);
     hold on;
%      axis([0 100 0 16777215])

     axes(handles.axes6)
     grid on;
     xlim([0 100]);
     hold on;
%      axis([0 100 0 8388607])

     axes(handles.axes7)
     grid on;
     xlim([0 100]);
     hold on
%      axis([0 100 0 8388607])
     
     axes(handles.axes8)
     grid on;
     xlim([0 100]);
     hold on;
%      axis([0 100 0 8388607])

     axes(handles.axes9)
     grid on;
     xlim([0 100]);
     hold on;
%      axis([0 100 0 8388607])
     
     axes(handles.axes10)
     grid on;
     xlim([0 100]);
     hold on;
%      axis([0 100 0 8388607])

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EEG_Acquisition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EEG_Acquisition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    data_med = zeros(1,256);
    data_att = zeros(1,256);
    data_raw = zeros(1,256);
    data_delta = zeros(1,256);
    data_theta = zeros(1,256);
    data_alphalow = zeros(1,256);
    data_alphahigh = zeros(1,256);
    data_betalow = zeros(1,256);
    data_betahigh = zeros(1,256);
    data_gammalow = zeros(1,256);
    data_gammahigh = zeros(1,256);
    poorsignal=0;
    
    portnum1 = 4;   %COM Port #
    comPortName1 = sprintf('\\\\.\\COM%d', portnum1);

    % Baud rate for use with TG_Connect() and TG_SetBaudrate().
    TG_BAUD_115200  =   115200;
    TG_BAUD_57600 = 57600;
    TG_BAUD_9600 = 9600;
 
    % Data format for use with TG_Connect() and TG_SetDataFormat().
    TG_STREAM_PACKETS =     0;

    % Data type that can be requested from TG_GetValue().
    TG_DATA_BATTERY = 0;
    TG_DATA_POOR_SIGNAL = 1;
    TG_DATA_ATTENTION = 2;
    TG_DATA_MEDITATION = 3;
    TG_DATA_RAW = 4;
    TG_DATA_DELTA = 5;
    TG_DATA_THETA = 6;
    TG_DATA_ALPHA1 = 7;
    TG_DATA_ALPHA2 = 8;
    TG_DATA_BETA1 = 9;
    TG_DATA_BETA2 = 10;
    TG_DATA_GAMMA1 = 11;
    TG_DATA_GAMMA2 = 12;
    TG_DATA_BLINK_STRENGTH = 37;
    TG_DATA_READYZONE = 38;

    %load thinkgear dll
    loadlibrary('Thinkgear.dll');
    fprintf('Thinkgear.dll loaded\n');
    Str1='Thinkgear.dll loaded';
    set(handles.edit2,'String',Str1);
    pause(1)
    
    %get dll version
    dllVersion = calllib('Thinkgear', 'TG_GetDriverVersion');
    fprintf('ThinkGear DLL version: %d\n', dllVersion );
    
    % Get a connection ID handle to ThinkGear
    connectionId1 = calllib('Thinkgear', 'TG_GetNewConnectionId');
    if ( connectionId1 < 0 )
        error( sprintf( 'ERROR: TG_GetNewConnectionId() returned %d.\n', connectionId1 ) );
        Str1='ERROR: TG_GetNewConnectionId()';
        set(handles.edit2,'String',Str1);
        pause(1)
    end;

    % Set/open stream (raw bytes) log file for connection
    errCode = calllib('Thinkgear', 'TG_SetStreamLog', connectionId1, 'streamLog.txt' );
    if( errCode < 0 )
        error( sprintf( 'ERROR: TG_SetStreamLog() returned %d.\n', errCode ) );
        Str1='ERROR: TG_SetStreamLog()';
        set(handles.edit2,'String',Str1);
        pause(1)
    end;

    % Set/open data (ThinkGear values) log file for connection
    errCode = calllib('Thinkgear', 'TG_SetDataLog', connectionId1, 'dataLog.txt' );
    if( errCode < 0 )
        error( sprintf( 'ERROR: TG_SetDataLog() returned %d.\n', errCode ) );
        Str1='ERROR: TG_SetDataLog()';
        set(handles.edit2,'String',Str1);
        pause(1)
    end;

    % Attempt to connect the connection ID handle to serial port "COM3"
    errCode = calllib('Thinkgear', 'TG_Connect',  connectionId1,comPortName1,TG_BAUD_57600,TG_STREAM_PACKETS );
    if ( errCode < 0 )
        error( sprintf( 'ERROR: TG_Connect() returned %d.\n', errCode ) );
    end

    fprintf( 'Connected.  Reading Packets...\n' );
    int(sym('status')) ;
    if(calllib('Thinkgear','TG_EnableZoneCalculation',connectionId1,2)==0)
        Str1='EnableZoneCalculation';
        set(handles.edit2,'String',Str1);
        pause(1)
    end

    if(calllib('Thinkgear','TG_EnableBlinkDetection',connectionId1,1)==0)
    disp('blinkdetectenabled');
    end
    
    i=0;
    j=0;
    k=0;
    l=0;
    m=0;
    n=0;
    o=0;
    p=0;
    q=0;
    r=0;
    s=0;
    t=0;
    
    Str1='Reading Brainwaves';
    set(handles.edit2,'String',Str1);
    pause(1)
    
    while i < 100
        if (calllib('Thinkgear','TG_ReadPackets',connectionId1,1) == 1)   %if a packet was read...
            if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_ATTENTION ) ~= 0) 
                i = i + 1;
                k = k + 1;
                data_att(k) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ATTENTION );
                data_value=data_att(k);
                data_value=num2str(data_value);
                set(handles.edit3,'String',data_value);
                axes(handles.axes2);
                grid on;
                axis([0 100 0 100]);
                plot(data_att);
                drawnow;
            end
%             if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_MEDITATION ) ~= 0)
%                 l = l + 1;
%                 data_med(l) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_MEDITATION );
%                 data_value=data_med(l);
%                 data_value=num2str(data_value);
%                 set(handles.edit4,'String',data_value);
%                 axes(handles.axes3);
%                 grid on;
%                 axis([0 100 0 100]);
%                 plot(data_med);
%                 drawnow;
%             end
            if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_DELTA ) ~= 0)
                m = m + 1;
                data_delta(m) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_DELTA );
                data_value=data_delta(m);
                data_value=num2str(data_value);
                set(handles.edit5,'String',data_value);
                axes(handles.axes4);
                grid on;
                axis([0 100 0 16777215]);
                plot(data_delta);
                drawnow;
            end
            if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_THETA ) ~= 0)
                n = n + 1;
                data_theta(n) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_THETA );
                data_value=data_theta(n);
                data_value=num2str(data_value);
                set(handles.edit6,'String',data_value);
                axes(handles.axes5);
                grid on;
                axis([0 100 0 16777215]);
                plot(data_theta);
                drawnow;
            end
            if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_ALPHA1 ) ~= 0)
                o = o + 1;
                data_alphalow(o) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ALPHA1 );
                data_value=data_alphalow(o);
                data_value=num2str(data_value);
                set(handles.edit7,'String',data_value);
                axes(handles.axes6);
                grid on;
                axis([0 100 0 8388607]);
                plot(data_alphalow);
                drawnow;
            end
            if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_ALPHA2 ) ~= 0)
                p = p + 1;
                data_alphahigh(p) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ALPHA2 );
                data_value=data_alphahigh(p);
                data_value=num2str(data_value);
                set(handles.edit8,'String',data_value);
                axes(handles.axes7);
                grid on;
                axis([0 100 0 8388607]);
                plot(data_alphahigh);
                drawnow;
            end
            if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_BETA1 ) ~= 0)
                q = q + 1;
                data_betalow(q) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_BETA1 );
                data_value=data_betalow(q);
                data_value=num2str(data_value);
                set(handles.edit9,'String',data_value);
                axes(handles.axes8);
                grid on;
                axis([0 100 0 8388607]);
                plot(data_betalow);
                drawnow;
            end
            if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_BETA2 ) ~= 0)
                r = r + 1;
                data_betahigh(r) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_BETA2 );
                data_value=data_betahigh(r);
                data_value=num2str(data_value);
                set(handles.edit10,'String',data_value);
                axes(handles.axes9);
                grid on;
                axis([0 100 0 8388607]);
                plot(data_betahigh);
                drawnow;
            end
            if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_GAMMA1 ) ~= 0)
                s = s + 1;
                data_gammalow(s) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_GAMMA1 );
                data_value=data_gammalow(s);
                data_value=num2str(data_value);
                set(handles.edit11,'String',data_value);
                axes(handles.axes10);
                grid on;
                axis([0 100 0 8388607]);
                plot(data_gammalow);
                drawnow;
            end
            if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_GAMMA2 ) ~= 0)
                t = t + 1;
                data_gammahigh(t) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_GAMMA2 );
                data_value=data_gammahigh(r);
                data_value=num2str(data_value);
                set(handles.edit4,'String',data_value);
                axes(handles.axes3);
                grid on;
                axis([0 100 0 8388607]);
                plot(data_gammahigh);
                drawnow;
            end
            
            if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_POOR_SIGNAL ) ~= 0)
                poorsignal = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_POOR_SIGNAL );
                data_value=poorsignal;
                data_value=num2str(data_value);
                set(handles.edit1,'String',data_value);
                if(poorsignal>0)
                    Str1='Fix the Headset';
                    set(handles.edit2,'String',Str1);
                else
                    Str1='Reading Brainwaves';
                    set(handles.edit2,'String',Str1);
                end
            end
        end
    end
    disp('exitt')
    Str1='Completed Reading';
    set(handles.edit2,'String',Str1);
    pause(1)
    calllib('Thinkgear', 'TG_FreeConnection', connectionId1 );


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
