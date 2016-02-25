function varargout = util_saveDialogUI(varargin)
% UTIL_SAVEDIALOGUI MATLAB code for util_saveDialogUI.fig
%      UTIL_SAVEDIALOGUI, by itself, creates a new UTIL_SAVEDIALOGUI or raises the existing
%      singleton*.
%
%      H = UTIL_SAVEDIALOGUI returns the handle to a new UTIL_SAVEDIALOGUI or the handle to
%      the existing singleton*.
%
%      UTIL_SAVEDIALOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UTIL_SAVEDIALOGUI.M with the given input arguments.
%
%      UTIL_SAVEDIALOGUI('Property','Value',...) creates a new UTIL_SAVEDIALOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before util_saveDialogUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to util_saveDialogUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help util_saveDialogUI

% Last Modified by GUIDE v2.5 06-Dec-2015 20:40:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @util_saveDialogUI_OpeningFcn, ...
                   'gui_OutputFcn',  @util_saveDialogUI_OutputFcn, ...
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


% --- Executes just before util_saveDialogUI is made visible.
function util_saveDialogUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to util_saveDialogUI (see VARARGIN)

% Choose default command line output for util_saveDialogUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes util_saveDialogUI wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = util_saveDialogUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output.UserData;
delete(handles.output);


function editFileName_Callback(hObject, eventdata, handles)
% hObject    handle to editFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFileName as text
%        str2double(get(hObject,'String')) returns contents of editFileName as a double


% --- Executes during object creation, after setting all properties.
function editFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonSave.
function pushbuttonSave_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~isempty(handles.editFileName.String))
    handles.output.UserData = struct('String', handles.editFileName.String, 'Valid', true);
    close(handles.output);
else
    set(handles.textWarning, 'Visible', 'on');
end


% --- Executes on button press in pushbuttonCancel.
function pushbuttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output.UserData = struct('String', 0, 'Valid', false);
close(handles.output);


% --- Executes on key press with focus on editFileName and none of its controls.
function editFileName_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to editFileName (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(handles.output.WaitStatus, 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    if(isempty(handles.output.UserData))
        handles.output.UserData = struct('String', 0, 'Valid', false);
    end
    uiresume(handles.output);
else
    % The GUI is no longer waiting, just close it
    delete(handles.output);
end
