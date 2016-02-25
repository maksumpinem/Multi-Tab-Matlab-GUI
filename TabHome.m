function varargout = TabHome(varargin)
% TABHOME MATLAB code for TabHome.fig
%      TABHOME, by itself, creates a new TABHOME or raises the existing
%      singleton*.
%
%      H = TABHOME returns the handle to a new TABHOME or the handle to
%      the existing singleton*.
%
%      TABHOME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABHOME.M with the given input arguments.
%
%      TABHOME('Property','Value',...) creates a new TABHOME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TabHome_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TabHome_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TabHome

% Last Modified by GUIDE v2.5 05-Dec-2015 00:02:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TabHome_OpeningFcn, ...
                   'gui_OutputFcn',  @TabHome_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);

% h=gui_mainfcn3(gui_State, varargin);
% r=h.tabHome_container;
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before TabHome is made visible.
function TabHome_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TabHome (see VARARGIN)

% Choose default command line output for TabHome
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TabHome wait for user response (see UIRESUME)
% uiwait(handles.tabHome_figure);
Initialize(hObject, handles)

%setMainHandles(catstruct(Handles, handles));
function Initialize(hObject, handles)
C = imread('HomeBackground.jpg');
set(hObject,'CurrentAxes',handles.tabHome_Background);
image(C);

% --- Outputs from this function are returned to the command line.
function varargout = TabHome_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in tabHome_button1.
function tabHome_button1_Callback(hObject, eventdata, handles)
% hObject    handle to tabHome_button1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%handles = Handles;
set(handles.text_hello, 'string', 'Hello World!');
