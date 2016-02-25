function varargout = UserInterfaceMain(varargin)
% USERINTERFACEMAIN MATLAB code for UserInterfaceMain.fig
%      USERINTERFACEMAIN, by itself, creates a new USERINTERFACEMAIN or raises the existing
%      singleton*.
%
%      H = USERINTERFACEMAIN returns the handle to a new USERINTERFACEMAIN or the handle to
%      the existing singleton*.
%
%      USERINTERFACEMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USERINTERFACEMAIN.M with the given input arguments.
%
%      USERINTERFACEMAIN('Property','Value',...) creates a new USERINTERFACEMAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UserInterfaceMain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UserInterfaceMain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UserInterfaceMain

% Last Modified by GUIDE v2.5 07-Dec-2015 18:27:52

% Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @UserInterfaceMain_OpeningFcn, ...
                       'gui_OutputFcn',  @UserInterfaceMain_OutputFcn, ...
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

% --- Executes just before UserInterfaceMain is made visible.
function UserInterfaceMain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UserInterfaceMain (see VARARGIN)
% Choose default command line output for UserInterfaceMain
    handles.output = hObject;
    
    % Update handles structure
    handles = initializeAllTabs(handles);
    guidata(hObject, handles);
    
    % UIWAIT makes UserInterfaceMain wait for user response (see UIRESUME)
    % uiwait(handles.UserInterfaceMain);
    %display(guidata(hObject));
    btnHelpJobj = findjobj(handles.main_btnHelp);
    btnHelpJobj.borderPainted = 0;
    
    
% --- Outputs from this function are returned to the command line.
function varargout = UserInterfaceMain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;
    
% --- Letakkan 'handles = initializeAllTabs(handles);' di fungsi
% ---_OpeningFcn satu baris sebelum baris 'guidata(hObject, handles);'
function newHandles = initializeAllTabs(parentHandles)
% To do untuk menambahkan tab baru:
% 1. Buat gui baru dari guide. Jika penambahan dilakukan dengan script
%    lanjut ke langkah 2.
%
% 2. Buat sebuah panel, tambahkan kata _Container pada
%    ujung tagnya agar lebih informatif. Isi tab harus berada dibawah panel
%    container dan pastikan nama tag setiap isi tab tidak sama dengan nama 
%    tag komponen pada figure parentnya.
%    TIPS: Tambahkan nama tab sebelum nama tag dari setiap isi container,
%          contoh: pushbutton1 menjadi tab1_pushbutton1.
%
% 3. Buat sebuah toggle button pada figure ini sebagai tombol 
%    yang akan digunakan untuk mengakses tab yang akan ditambahkan.
%
% 4. Daftarkan figure, panel, dan toggle button yang dibuat pada langkah
%    sebelumnya ke array cell yang sesuai dibawah ini.
    ParentContainerTag = 'main_container';
    
    % Daftarkan semua figure dari tab disini, setiap figure yang didaftarkan
    % disini akan akan di-run secara otomatis
    visibility = 'off';
    tabFigures = { TabHome('visible', visibility), ...
                   tab_ModelPropagasi_UserInterface('visible', visibility), ...
                   tab_simulasiKanal_UI('visible', visibility), ...
                   tab3('visible', visibility)};

    % Daftarkan semua panel container semua tab disini.
    % Saat gui parent menjadikan panel container maka child dari
    % panel kontainer itu juga akan menjadi child dari parent
    tabContainerTags = { 'tabHome_container' ...
                         'tab_ModelPropagasi_Container' ...
                         'simKanal_Container' ...
                         'tab3_container' };  

    % Daftarkan semua tombol tab disini
    tabButtons = { parentHandles.main_tabHome ...
                   parentHandles.main_tab1 ...
                   parentHandles.main_tab2 ...
                   parentHandles.main_tab3} ;   
    
    % Daftarkan nama documentation semua tab disini
    % Tuliskan 'none' jika tidak ada
    tabDocumentations = { 'none', ...
                          'none', ...
                          'simulasi kanal', ...
                          'none' };
    
    % Warna dari tab yang sedang dipilih dan yang sedang tidak dipilih           
    selectedTabColor    = [ .937 .941 .941 ];
    notSelectedTabColor = [ 0.16470588235294117647058823529412 ...
                             0.34117647058823529411764705882353 ...
                             0.6039215686274509803921568627451 ];
    % --------------------------------------------------------------------%                     
    % Membuat object TabStrip ( Navigation Bar ) baru yang disimpan di dalam structure
    % tabstrip untuk di merge-kan dengan handles.
    tabStrip = struct('MainTabStrip', TabStrip(parentHandles, ParentContainerTag, tabFigures, tabContainerTags,...
                                tabButtons, selectedTabColor, notSelectedTabColor, tabDocumentations));  
    for i=1:numel(tabFigures)
        tabStrip.MainTabStrip.Tabs{i}.LocalHandles = catstruct(tabStrip.MainTabStrip.Tabs{i}.LocalHandles, tabStrip);
    end
    
    newHandles = tabStrip.MainTabStrip.Tabs{1}.LocalHandles;                                                    
% END - initializeAllTabs

% --- Executes when UserInterfaceMain is resized.
function UserInterfaceMain_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to UserInterfaceMain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fheight = hObject.Position(4);
Fwidth  = hObject.Position(3);
%mainContainerHeight = handles.main_container.Position(4);
tabGroupHeight = handles.main_tabGroup.Position(4);
statusStrigHeight = handles.main_statusStrip.Position(4);

handles.main_tabGroup.Position(2)  = Fheight - tabGroupHeight;
handles.main_container.Position(2) = statusStrigHeight;
handles.main_container.Position(3) = hObject.Position(3)+0.25;
handles.main_container.Position(4) = Fheight - tabGroupHeight - statusStrigHeight;

handles.main_btnHelp.Position(1)   = Fwidth - handles.main_btnHelp.Position(3) - 5;


% --- Executes on button press in main_tabHome.
function main_tabHome_Callback(hObject, eventdata, handles)
% hObject    handle to main_tabHome (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MainTabStrip.ShowTab(1);

function main_tab1_Callback(hObject, eventdata, handles)
% hObject    handle to main_tab1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_tab1
handles.MainTabStrip.ShowTab(2);
    
function main_tab2_Callback(hObject, eventdata, handles)
% hObject    handle to main_tab2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_tab2
handles.MainTabStrip.ShowTab(3);

    
function main_tab3_Callback(hObject, eventdata, handles)
% hObject    handle to main_tab3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_tab3
handles.MainTabStrip.ShowTab(4);


% --- Executes during object deletion, before destroying properties.
function UserInterfaceMain_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to UserInterfaceMain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if isappdata(hObject,'GUIOnScreen')
%     tab = handles.(handles.mainTabsFieldName);
%     for i=1:numel(tab)
%         if isvalid(tab(i).properties.figure)
%             close(tab(i).properties.figure);
%         end
%     end
% end


% --- Executes on button press in main_btnHelp.
function main_btnHelp_Callback(hObject, eventdata, handles)
% hObject    handle to main_btnHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
documentation = handles.MainTabStrip.Tabs{handles.MainTabStrip.LastSelectedTab}.Documentation;
if(~strcmp(documentation, 'none'))
    doc (documentation);
else
    uiwait(msgbox('Tidak ada dokumentasi untuk bagian ini','Documentation','modal'));
end
