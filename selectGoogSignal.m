function varargout = selectGoogSignal(varargin)
%SELECTGOOGSIGNAL MATLAB code file for selectGoogSignal.fig
%      SELECTGOOGSIGNAL, by itself, creates a new SELECTGOOGSIGNAL or raises the existing
%      singleton*.
%
%      H = SELECTGOOGSIGNAL returns the handle to a new SELECTGOOGSIGNAL or the handle to
%      the existing singleton*.
%
%      SELECTGOOGSIGNAL('Property','Value',...) creates a new SELECTGOOGSIGNAL using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to selectGoogSignal_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%

%      SELECTGOOGSIGNAL('CALLBACK') and SELECTGOOGSIGNAL('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SELECTGOOGSIGNAL.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help selectGoogSignal

% Last Modified by GUIDE v2.5 04-Jul-2020 15:59:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @selectGoogSignal_OpeningFcn, ...
                   'gui_OutputFcn',  @selectGoogSignal_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before selectGoogSignal is made visible.
function selectGoogSignal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for selectGoogSignal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes selectGoogSignal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = selectGoogSignal_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectFile.
function selectFile_Callback(hObject, eventdata, handles)
% hObject    handle to selectFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Fnameh,Pnameh]=uigetfile('/home/wangc/matlab_work/fatigue/useful_sig/*.mat');%Fnameh��ʾ���ļ����ƣ�Pnameh��ʾ���ļ�·��
filename=[Pnameh,Fnameh];%�洢�ļ���·��������
set(hObject,'String',filename);%��strh��ֵ���ݸ���̬�ı�



% --- Executes on button press in confirm.
function confirm_Callback(hObject, eventdata, handles)
% hObject    handle to confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filePath = get(handles.selectFile,'String');
global sig titles selected_idx cur_idx seg_num rBPM rBPM0

res = strsplit(filePath,'/');
res = res{end};
res = res(1:strfind(res,'-data'));
rBPM = importdata(['/home/wangc/matlab_work/fatigue/useful_sig/RR/rBPM/',res,'rBPM.mat']);
rBPM0 = importdata(['/home/wangc/matlab_work/fatigue/useful_sig/RR/rBPM0/',res,'rBPM0.mat']);

sig = importdata(filePath);
sig = sig(:,937:end); %��ȥǰ7.5s
sig=bandpass(sig',1,20,1/125)';
%%%%% ecg is a bit of noisy
bpArrayy = smooth(sig(5,:),7,'lowess');
sig(5,:)=sig(5,:)-bpArrayy';
%%%%%
titles={'acc1','acc2','acc3','band\_resp','ecg','ppg','modu\_resp','modu\_ecg'};
selected_idx=[];
cur_idx=1;
set(handles.cur_seg,'String',num2str(cur_idx));
set(handles.edit6,'String',num2str(abs(rBPM(cur_idx)-rBPM0(cur_idx))));
seg_num = floor(size(sig,2)/1875);
set(handles.seg_num,'String',num2str(seg_num));
plotsig(sig,titles,cur_idx,handles);



% --- Executes on button press in retain.
function retain_Callback(hObject, eventdata, handles)
% hObject    handle to retain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% fg = figure(...
%     'parent'
%     )
global cur_idx sig titles selected_idx seg_num rBPM rBPM0
if cur_idx<=seg_num
    selected_idx=[selected_idx,cur_idx];
    if cur_idx<seg_num
        cur_idx=cur_idx+1;
        set(handles.cur_seg,'String',num2str(cur_idx));
        set(handles.edit6,'String',num2str(abs(rBPM(cur_idx)-rBPM0(cur_idx))));
        plotsig(sig,titles,cur_idx,handles);
    end
end


% --- Executes on button press in discard.
function discard_Callback(hObject, eventdata, handles)
% hObject    handle to discard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cur_idx sig titles seg_num rBPM rBPM0
if cur_idx<seg_num
    cur_idx=cur_idx+1;
    set(handles.cur_seg,'String',num2str(cur_idx));
    set(handles.edit6,'String',num2str(abs(rBPM(cur_idx)-rBPM0(cur_idx))));
    plotsig(sig,titles,cur_idx,handles);
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global selected_idx
filePath = get(handles.selectFile,'String');
temp = strsplit(filePath,'/');
temp = temp{end};
temp = temp(1:strfind(temp,'-data'));
temp=[ temp 'selected_idx.mat' ];
save(['/home/wangc/matlab_work/fatigue/useful_sig/selected/idx/',temp],'selected_idx')

function seg_num_Callback(hObject, eventdata, handles)
% hObject    handle to seg_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seg_num as text
%        str2double(get(hObject,'String')) returns contents of seg_num as a double


% --- Executes during object creation, after setting all properties.
function seg_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seg_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','0');


function cur_seg_Callback(hObject, eventdata, handles)
% hObject    handle to cur_seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cur_seg as text
%        str2double(get(hObject,'String')) returns contents of cur_seg as a double


% --- Executes during object creation, after setting all properties.
function cur_seg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cur_seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','0');



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
% global Fnameh
% set(hObject,'String',Fnameh);



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
set(hObject,'String','0');
