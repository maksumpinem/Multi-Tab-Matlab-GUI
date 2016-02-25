function varargout = tab_simulasiKanal_UI(varargin)
% TAB_SIMULASIKANAL_UI MATLAB code for tab_simulasiKanal_UI.fig
%      TAB_SIMULASIKANAL_UI, by itself, creates a new TAB_SIMULASIKANAL_UI or raises the existing
%      singleton*.
%
%      H = TAB_SIMULASIKANAL_UI returns the handle to a new TAB_SIMULASIKANAL_UI or the handle to
%      the existing singleton*.
%
%      TAB_SIMULASIKANAL_UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAB_SIMULASIKANAL_UI.M with the given input arguments.
%
%      TAB_SIMULASIKANAL_UI('Property','Value',...) creates a new TAB_SIMULASIKANAL_UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tab_simulasiKanal_UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tab_simulasiKanal_UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tab_simulasiKanal_UI

% Last Modified by GUIDE v2.5 07-Dec-2015 18:27:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tab_simulasiKanal_UI_OpeningFcn, ...
                   'gui_OutputFcn',  @tab_simulasiKanal_UI_OutputFcn, ...
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


% --- Executes just before tab_simulasiKanal_UI is made visible.
function tab_simulasiKanal_UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tab_simulasiKanal_UI (see VARARGIN)

% Choose default command line output for tab_simulasiKanal_UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tab_simulasiKanal_UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function Initialize(hObject, handles)

% --- Outputs from this function are returned to the command line.
function varargout = tab_simulasiKanal_UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in btn_Clear.
function btn_Clear_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.btn_Save, 'Enable', 'Off');
set(handles.output,'currentaxes',handles.axes1);
set(handles.table_Hasil, 'Data', []);
cla reset;

% --- Executes on button press in btn_Save.
function btn_Save_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(handles.tab_simKanal_saveDialog, 'visible', 'on');
simKanal = handles.btn_Mulai.UserData;
saveDialog = util_saveDialog;
if(saveDialog.IsValid)
    fileName = saveDialog.String;
    simKanal.saveHasilSimulasi(fileName);
end

% --- Executes on button press in btn_Mulai.
function btn_Mulai_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Mulai (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.output,'currentaxes',handles.axes1)
    
    simKanal         = SimulasiKanal;
    jumlahBit        = str2double(handles.edit_JumlahBit.String);
    frekuensiDoppler = str2double(handles.edit_FrekuensiDoppler.String);
    lajuBit          = str2double(handles.edit_LajuBit.String);

    simKanal.startSimulation(jumlahBit, frekuensiDoppler, lajuBit, 0);
    set(handles.table_Hasil, 'Data', simKanal.dataHasil);
    set(handles.edit_Ts, 'String', simKanal.Ts);
    set(handles.edit_Tc, 'String', simKanal.Tc);
    set(handles.btn_Clear, 'Enable', 'On');
    set(handles.btn_Save, 'Enable', 'On');
    set(handles.panel_UjiDistribusi, 'Visible', 'on');

   %Membuat grafik hasil simulasi 
    semilogy(simKanal.SNR, simKanal.BER, 'b--*');
    hold on;
    t = 0:0.5:25;
                      
    %Membuat grafik SNR vs BER dari hasil perhitungan secara teori
    semilogy(t, simKanal.Pe, 'red');
    set(handles.axes1,...
        'xgrid','on',...
        'ygrid','on',...  
        'xcolor',[.1 .0 .4],...
        'ycolor',[.1 .0 .4],...    
        'fontsize',8,...    
        'color',[1 1 1],...
        'nextplot','replace');
    set(get(handles.axes1,'XLabel'),'String','SNR')
    set(get(handles.axes1,'YLabel'),'String','BER')
    legend('Hasil Simulasi','teori');
    title(handles.axes1,'Grafik SNR Vs BER pada kanal Rayleigh fading');
    
    set(handles.btn_Mulai, 'UserData', simKanal);


% --- Executes when panel_Hasil is resized.
function panel_Hasil_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to panel_Hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles)
    handles.table_Hasil.Units = 'pixel';
    handles.panel_inputContainer.Parent.Units = 'pixels';
    
    width = handles.table_Hasil.Position(3)/8;
    handles.table_Hasil.ColumnWidth = {width width width width width width width width};
    handles.table_Hasil.Units = 'normalized';
    
    handles.panel_inputContainer.Position(2) = handles.panel_inputContainer.Parent.Position(4) - handles.panel_inputContainer.Position(4) - 10;
    handles.panel_inputContainer.Parent.Units = 'normalized';
end


% --- Executes on selection change in popupmenu_Type.
function popupmenu_Type_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_Type
if(handles.popupmenu_Type.Value == 1)
    set(handles.popupmenu_dB, 'Visible', 'off');
    display('1');
elseif(handles.popupmenu_Type.Value == 2)
    set(handles.popupmenu_dB, 'Visible', 'off');
    display('2');
else
    set(handles.popupmenu_dB, 'Visible', 'on');
    display('3');
end


% --- Executes on selection change in popupmenu_dB.
function popupmenu_dB_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_dB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_dB



% --- Executes on button press in btn_UjiDistribusi.
function btn_UjiDistribusi_Callback(hObject, eventdata, handles)
% hObject    handle to btn_UjiDistribusi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
simKanal = handles.btn_Mulai.UserData;
if(handles.popupmenu_Type.Value == 1)
    simKanal.ujiDistribusiUniform;
    
elseif(handles.popupmenu_Type.Value == 2)
    simKanal.ujiDistribusiRayleight;
    
elseif(handles.popupmenu_Type.Value == 3) 
    pilihdB = get(handles.popupmenu_dB,'Value');
    simKanal.ujiDistribusiNormal(pilihdB);
end


% --- Executes on button press in btn_DisplayInNewWindow.
function btn_DisplayInNewWindow_Callback(hObject, eventdata, handles)
% hObject    handle to btn_DisplayInNewWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes = handles.axes1;
newFig = figure;
axesNew = copyobj(axes, newFig);
set(axesNew,'Position','default');
