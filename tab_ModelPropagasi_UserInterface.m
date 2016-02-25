function varargout = tab_ModelPropagasi_UserInterface(varargin)
% TAB_MODELPROPAGASI_USERINTERFACE MATLAB code for tab_ModelPropagasi_UserInterface.fig
%      TAB_MODELPROPAGASI_USERINTERFACE, by itself, creates a new TAB_MODELPROPAGASI_USERINTERFACE or raises the existing
%      singleton*.
%
%      H = TAB_MODELPROPAGASI_USERINTERFACE returns the handle to a new TAB_MODELPROPAGASI_USERINTERFACE or the handle to
%      the existing singleton*.
%
%      TAB_MODELPROPAGASI_USERINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAB_MODELPROPAGASI_USERINTERFACE.M with the given input arguments.
%
%      TAB_MODELPROPAGASI_USERINTERFACE('Property','Value',...) creates a new TAB_MODELPROPAGASI_USERINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tab_ModelPropagasi_UserInterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tab_ModelPropagasi_UserInterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tab_ModelPropagasi_UserInterface

% Last Modified by GUIDE v2.5 29-Nov-2015 01:28:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tab_ModelPropagasi_UserInterface_OpeningFcn, ...
                   'gui_OutputFcn',  @tab_ModelPropagasi_UserInterface_OutputFcn, ...
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


% --- Executes just before tab_ModelPropagasi_UserInterface is made visible.
function tab_ModelPropagasi_UserInterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tab_ModelPropagasi_UserInterface (see VARARGIN)

% Choose default command line output for tab_ModelPropagasi_UserInterface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tab_ModelPropagasi_UserInterface wait for user response (see UIRESUME)
% uiwait(handles.figure1);
Initialize(hObject, handles);

function Initialize(hObject, handles)
initializeTab1Tabel(handles);

function initializeTab1Tabel(handles)
tab1TabelData = zeros(4,5);
for i=1:4
    tab1TabelData(i,1) = i;
end
set(handles.tab1_tabel,'data',tab1TabelData);

% --- Outputs from this function are returned to the command line.
function varargout = tab_ModelPropagasi_UserInterface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function menu_help_Callback(hObject, eventdata, handles)
% hObject    handle to menu_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.output,'CurrentAxes',handles.tab_ModelPropagasi_axesOutput);
cla(subplot (3,2,[5 6]));
cla(subplot (3,2,2));
cla(subplot (3,2,[3 4]));
cla(subplot (3,2,1));

%handles = Handles;
distance=str2double(get(handles.tab1_edit_jarak,'string'));
frekuensi=str2double(get(handles.tab1_edit_frekuensi,'string'));
tab_ModelPropagasi_Source(distance, frekuensi, handles.tab1_tabel.Data, handles.checkbox_tab1.Value);


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t=1:0.1:100;
y=sin(2*pi*t/60);
plot(y);


function tab1_edit_jarak_Callback(hObject, eventdata, handles)
% hObject    handle to tab1_edit_jarak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tab1_edit_jarak as text
%        str2double(get(hObject,'String')) returns contents of tab1_edit_jarak as a double


% --- Executes during object creation, after setting all properties.
function tab1_edit_jarak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tab1_edit_jarak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tab1_edit_frekuensi_Callback(hObject, eventdata, handles)
% hObject    handle to tab1_edit_frekuensi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tab1_edit_frekuensi as text
%        str2double(get(hObject,'String')) returns contents of tab1_edit_frekuensi as a double


% --- Executes during object creation, after setting all properties.
function tab1_edit_frekuensi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tab1_edit_frekuensi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in tab1_tabel.
function tab1_tabel_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tab1_tabel (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
row=eventdata.Indices(1);
currentData=get(handles.tab1_tabel,'data');
handles.tab1_tabel.Data(row,5) = (currentData(row,2)+currentData(row,3)+currentData(row,4))./3;
pushbutton13_Callback(hObject, eventdata, handles);
drawnow();


% --- Executes on button press in pushbutton_tab1_increaseRow.
function pushbutton_tab1_increaseRow_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tab1_increaseRow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (str2double(handles.tab1_edit_jarak.String)>=1)
    dataTemp = handles.tab1_tabel.Data;
    sizes=size(dataTemp);
    handles.tab1_tabel.Data(sizes(1)+1, 1)=str2num(handles.tab1_edit_jarak.String)+1;
    set(handles.tab1_edit_jarak,'string',num2str(sizes(1)+1));
end
pushbutton13_Callback(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_tab1_decreaseRow.
function pushbutton_tab1_decreaseRow_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tab1_decreaseRow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (str2double(handles.tab1_edit_jarak.String)>1)
    dataTemp = get(handles.tab1_tabel,'data');
    sizes=size(dataTemp);
    handles.tab1_tabel.Data(sizes(1),:) = [];
    if(sizes(1)-1 > 0)
        set(handles.tab1_edit_jarak,'string',num2str(sizes(1)-1));
    end
end
pushbutton13_Callback(hObject, eventdata, handles);


% --- Executes on button press in checkbox_tab1.
function checkbox_tab1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_tab1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_tab1
dataTemp = get(handles.tab1_tabel,'data');
sizes=size(dataTemp);
if(get(handles.checkbox_tab1,'value')==1)
    set(handles.tab1_tabel,'enable','on');
    set(handles.tab1_edit_jarak,'enable','off');
    set(handles.pushbutton_tab1_increaseRow,'enable','on');
    set(handles.pushbutton_tab1_decreaseRow,'enable','on');
    set(handles.tab1_edit_jarak,'string',num2str(sizes(1)));
else
    set(handles.tab1_tabel,'enable','off');
    set(handles.tab1_edit_jarak,'enable','on');
    set(handles.pushbutton_tab1_increaseRow,'enable','off');
    set(handles.pushbutton_tab1_decreaseRow,'enable','off');
end


