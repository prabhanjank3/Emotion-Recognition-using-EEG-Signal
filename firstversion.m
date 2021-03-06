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


portnum=5;
comPortName1=sprintf('\\\\.\\COM%d', portnum);
TG_BAUD=115200;
TG_BAUD_57600 = 57600;
TG_BAUD_9600 = 9600;
TG_STREAM_PACKETS=0;
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
loadlibrary('Thinkgear.dll');
fprintf('Thinkgear.dll loaded\n');
dllVersion = calllib('Thinkgear', 'TG_GetDriverVersion');
fprintf('ThinkGear DLL version: %d\n', dllVersion );
connectionId1 = calllib('Thinkgear', 'TG_GetNewConnectionId');
if ( connectionId1 < 0 )
error( sprintf( 'ERROR: TG_GetNewConnectionId() returned %d.\n', connectionId1 ) );
end
errCode = calllib('Thinkgear', 'TG_Connect',  connectionId1,comPortName1,TG_BAUD_57600,TG_STREAM_PACKETS );
if ( errCode < 0 )
error( sprintf( 'ERROR: TG_Connect() returned %d.\n', errCode ) );
end
fprintf( 'Connected.  Reading Packets...\n' );
if(calllib('Thinkgear','TG_EnableZoneCalculation',connectionId1,2)==0)
Str1='EnableZoneCalculation';
fprintf('EnableZoneCalculations..');
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
disp(Str1);

while i < 100
    i=i+1;
    if (calllib('Thinkgear','TG_ReadPackets',connectionId1,1) == 1)   %if a packet was read...
        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_ATTENTION ) ~= 0) 
            k = k + 1;
            data_att(k) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ATTENTION );
        end

        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_DELTA ) ~= 0)
            m = m + 1;
            data_delta(m) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_DELTA );
        end

        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_THETA ) ~= 0)
            n = n + 1;
            data_theta(n) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_THETA );
        end

        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_ALPHA1 ) ~= 0)
            o = o + 1;
            data_alphalow(o) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ALPHA1 );
            disp(data_alphalow);
        end

        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_ALPHA2 ) ~= 0)
            p = p + 1;
            data_alphahigh(p) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_ALPHA2 );
        else
            disp('Not read');
        end

        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_BETA1 ) ~= 0)
        q = q + 1;
        data_betalow(q) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_BETA1 );
        end

        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_BETA2 ) ~= 0)
            r = r + 1;
            data_betahigh(r) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_BETA2 );
        end
        
        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_GAMMA1 ) ~= 0)
            s = s + 1;
            data_gammalow(s) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_GAMMA1 );
        end
        
        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_GAMMA2 ) ~= 0)
            t = t + 1;
            data_gammahigh(t) = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_GAMMA2 );
        end
        if (calllib('Thinkgear','TG_GetValueStatus',connectionId1,TG_DATA_POOR_SIGNAL ) ~= 0)
            poorsignal = calllib('Thinkgear','TG_GetValue',connectionId1,TG_DATA_POOR_SIGNAL );
            if(poorsignal>0)
                Str1='Fix the Headset';
                disp(Str1);
            end
        end

        N=[i data_alphalow(o) data_alphahigh(p) data_delta(m) data_theta(n) data_betalow(q) data_betahigh(r) data_gammalow(s) data_gammahigh(t) ];
        dlmwrite('record.csv',N,'delimiter',',','-append');

    end
end

alpha_mean = mean(mean(data_alphalow),mean(data_alphahigh));
beta_mean = mean(mean(data_betalow),mean(data_betahigh));
delta_mean = mean(data_delta);
gamma_mean = mean(mean(data_gammalow),mean(data_gammahigh));
theta_mean = mean(data_theta);
alpha_std = std(data_alphalow);
beta_std = std(data_betalow);
delta_std = std(data_deltalow);
gamma_std = std(data_gammalow);
theta_std = std(data_thetalow);

disp(alpha_mean,beta_mean,delta_mean,gamma_mean,theta_mean,alpha_std,beta_std,delta_std,gamma_std,theta_std);
disp('exit')
disp('Completed Reading');
calllib('Thinkgear', 'TG_FreeConnection', connectionId1 );