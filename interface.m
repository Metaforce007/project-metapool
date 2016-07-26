function varargout = interface(varargin)
% INTERFACE MATLAB code for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 26-Jul-2016 23:50:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
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


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

feed = imread('exm2.jpg');
h_feed = imagesc(feed);
set(h_feed, 'ButtonDownFcn', {@click, handles});
axes(handles.current_ball);
imshow(feed);



handles.selected_code = 0;
handles.feed = feed;
handles.avg_rgb = [0, 0, 0];
colors_submitted = 0;
handles.colors_submitted = colors_submitted;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select_area.
function select_area_Callback(hObject, eventdata, handles)

surface = getrect(handles.table);
handles.surface = ceil(surface);

guidata(hObject, handles);

% hObject    handle to select_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in codes_list.
function codes_list_Callback(hObject, eventdata, handles)

codes = cellstr(get(hObject, 'String'));
selected_code = codes{get(hObject, 'Value')}(1) - 48;
handles.selected_code = selected_code;
guidata(hObject, handles);


% hObject    handle to codes_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns codes_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from codes_list


% --- Executes during object creation, after setting all properties.
function codes_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to codes_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)

avg_rgb_surface = average_rgb(handles.feed, handles.surface);
handles.avg_rgb = avg_rgb_surface;

assignin('base', strcat('code', num2str(handles.selected_code)), [handles.selected_code, handles.avg_rgb]);

guidata(hObject, handles);

% hObject    handle to submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function click(hObject, eventdata, handles)

exm32 = imread('exm2.jpg');
pos = get(handles.table, 'CurrentPoint');
pos = ceil(pos(1, 1:2));

ball_identity = identify_ball(exm32, pos);

crop_area = ball_identity(1:4);
crop_area(3:4) = crop_area(3:4) - crop_area(1:2);

img_ball = imcrop(exm32, crop_area);

axes(handles.current_ball);
imshow(img_ball);

avg_rgb = ball_identity(5:7);
handles.avg_rgb = avg_rgb;
guidata(hObject, handles);
