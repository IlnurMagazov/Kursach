function varargout = sasa(varargin)
% SASA MATLAB code for sasa.fig
%      SASA, by itself, creates a new SASA or raises the existing
%      singleton*.
%
%      H = SASA returns the handle to a new SASA or the handle to
%      the existing singleton*.
%
%      SASA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SASA.M with the given input arguments.
%
%      SASA('Property','Value',...) creates a new SASA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sasa_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sasa_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sasa

% Last Modified by GUIDE v2.5 20-Apr-2015 00:23:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sasa_OpeningFcn, ...
                   'gui_OutputFcn',  @sasa_OutputFcn, ...
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


% --- Executes just before sasa is made visible.
function sasa_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sasa (see VARARGIN)

% Choose default command line output for sasa
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sasa wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sasa_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on button press in inform.
function inform_Callback(hObject, eventdata, handles)
% hObject    handle to inform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inform % îáúÿâëÿåì ãëîáàëüíî.         
[nombre direc]=uigetfile('*.xlsx','inform'); % create the way by function uigetfile.
inform=strcat(direc,nombre); % filename are called.


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inform 
M=xlsread(inform); % open Excel-file by function xlsread.
Signal=M(:,1);
FftL=length(Signal); % number of lines of the Foiriem spectrum
%% The spectral representation of the signal
FftS=abs(fft(Signal,FftL));% module of dpectrum lines
FftS=2*FftS./FftL;% Íîðìèðîâêà ñïåêòðà ïî àìïëèòóäå
Fd=str2double(get(handles.edit2,'String')); %÷àñòîòà äèñêðåòèçàöèè êîòîðóþ ÿ âûäóìàë à ìîæåò è íå âûäóìàë; %÷àñòîòà äèñêðåòèçàöèè êîòîðóþ ÿ âûäóìàë à ìîæåò è íå âûäóìàë
F=0:Fd/FftL:Fd/2-1/FftL;% Ìàññèâ ÷àñòîò âû÷èñëÿåìîãî ñïåêòðà Ôóðüå
plot(handles.axes2,F,FftS(1:length(F)));
ylabel('Àìïëèòóäà'); % ïîäïèñûâàåì îñü Àìïëèòóä.   
xlabel('×àñòîòà');
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inform 
M=xlsread(inform); % îòêðûâàåì ýêñåëåâñêèé ôàéë ñ ïîìîùüþ xlsread.
Signal=M(:,1);
FftL=length(Signal);       % Êîëè÷åñòâî ëèíèé Ôóðüå ñïåêòðà. Ðàâíî êîëè÷åñòâó îò÷åòîâ ñèãíàëà

%% Ñïåêòðàëüíîå ïðåäñòàâëåíèå ñèãíàëà
FftS=fft(Signal,FftL);     % Ïîëó÷åíè ñïåêòðà ïî ÄÏÔ (èëè ÁÏÔ, ïî âîçìîæíîñòè)
FftS=FftS.*conj(FftS)/FftL;% FftS - ñïåêòðàëüíàÿ ïëîòíîñòü ìîùíîñòè
FftS=FftS(1:(FftL/2));
%% Ïîñòðîåíèå ãðàôèêîâ ñèãíàëà è ñïåêòðà
plot(handles.axes1,Signal);    
ylabel('Àìïëèòóäà'); % ïîäïèñûâàåì îñü Àìïëèòóä.   
xlabel('Óñëîâíîå âðåìÿ');
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inform 
M=xlsread(inform); % îòêðûâàåì ýêñåëåâñêèé ôàéë ñ ïîìîùüþ xlsread.
Signal=M(:,1);
FftL=length(Signal); % Êîëè÷åñòâî ëèíèé Ôóðüå ñïåêòðà. Ðàâíî êîëè÷åñòâó îò÷åòîâ ñèãíàëà

%% Ñïåêòðàëüíîå ïðåäñòàâëåíèå ñèãíàëà
FftS=fft(Signal,FftL);     % Ïîëó÷åíè ñïåêòðà ïî ÄÏÔ (èëè ÁÏÔ, ïî âîçìîæíîñòè)
FftS=FftS.*conj(FftS)/FftL;% FftS - ñïåêòðàëüíàÿ ïëîòíîñòü ìîùíîñòè
FftS=FftS(1:(FftL/2));     % Áåðåì ïîëîâèíó ñïåêòðà

%% Íîðìèðîâêà ïî ìàñèìàëüíîìó çíà÷åíèþ
FftS=FftS./max(FftS);    
%% Ïîñòðîåíèå ãðàôèêà ñèãíàëà è íîðìèðîâàííîãî ñïåêòðà
Fd=str2double(get(handles.edit2,'String')); %÷àñòîòà äèñêðåòèçàöèè êîòîðóþ ÿ âûäóìàë à ìîæåò è íå âûäóìàë
F=0:Fd/FftL:Fd/2-1/FftL;% Ìàññèâ ÷àñòîò âû÷èñëÿåìîãî ñïåêòðà Ôóðüå         
plot(handles.axes3,F,FftS(1:length(F)));    
ylabel('Àìïëèòóäà'); % ïîäïèñûâàåì îñü Àìïëèòóä.   
xlabel('×àñòîòà');

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla (handles.axes1,'reset') % ñòèðàåì íàðèñîâàííûå ãðàôèêè. 
cla (handles.axes2,'reset') 
cla (handles.axes3,'reset')
set(handles.edit2,'String',[])
set(handles.uitable1,'String',[])





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


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inform 
M=xlsread(inform); % îòêðûâàåì ýêñåëåâñêèé ôàéë ñ ïîìîùüþ xlsread.
Signal=M(:,1);
FftL=length(Signal);% Êîëè÷åñòâî ëèíèé Ôóðüå ñïåêòðà. Ðàâíî êîëè÷åñòâó îò÷åòîâ ñèãíàëà

%% Ñïåêòðàëüíîå ïðåäñòàâëåíèå ñèãíàëà
FftS=fft(Signal,FftL);     % Ïîëó÷åíè ñïåêòðà ïî ÄÏÔ (èëè ÁÏÔ, ïî âîçìîæíîñòè)
FftS=FftS.*conj(FftS)/FftL;% FftS - ñïåêòðàëüíàÿ ïëîòíîñòü ìîùíîñòè
FftS=FftS(1:(FftL/2));     % Áåðåì ïîëîâèíó ñïåêòðà
Fd=str2double(get(handles.edit2,'String')); %÷àñòîòà äèñêðåòèçàöèè êîòîðóþ ÿ âûäóìàë à ìîæåò è íå âûäóìàë; %÷àñòîòà äèñêðåòèçàöèè êîòîðóþ ÿ âûäóìàë à ìîæåò è íå âûäóìàë
F=0:Fd/FftL:Fd/2-Fd/FftL;    %Ìàññèâ ÷àñòîò âû÷èñëÿåìîãî ñïåêòðà Ôóðüå
%% Íîðìèðîâêà ïî ìàñèìàëüíîìó çíà÷åíèþ
FftS=FftS./max(FftS);   
%% Îïðåäåëåíèå íåñóùèõ ÷àñòîò ïî ñïåêòðó ñèãíàëà
minpks=0.05;    %îïðåäåëÿåì ìèíèìàëüíîå çíà÷åíèå ïèêîâ, íèæå êîòîðûõ ïèèêè íå áåðåì 
distance=5;     %îïðåäåëÿåì ìèíèìàëüíîå ðàññòîÿíèå ìåæäó ïèêàìè
[pks,locs] = findpeaks(FftS,'MINPEAKHEIGHT',minpks,'MINPEAKDISTANCE',distance);%âûâîäèò ïèêè àìïëèäóä ñèíóñîäèò è çíà÷åíèÿ ÷àñòîò ïðè êîòîðûõ îíè äîñòèãàþòñÿ
%pks - çíà÷åíèå ïèêà, locs - çíà÷åíèå ÷àñòîòû
freequency=locs.*(Fd/FftL);
set(handles.uitable1,'data',freequency);
