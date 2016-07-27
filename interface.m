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

% Last Modified by GUIDE v2.5 27-Jul-2016 10:15:10

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

cd_self;

% assigning variables to handles variables make it possible for us to use
% them in the different functions

% load the frame
feed = imread('exm2.jpg');

% handler of $feed
h_feed = imagesc(feed);

% setting a click handles when ever a click occurs on $feed
set(h_feed, 'ButtonDownFcn', {@click, handles});

% set axes
axes(handles.current_ball);

% display $feed
imshow(feed);


% initialize handle variables

% selected color from color list (0 - 8)
handles.selected_code = 0;

% a problem with this; check
handles.feed = feed;

% average rgb value of the surface or a ball
handles.avg_rgb = [0, 0, 0];


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

% getrect(handles.table) returns a vector that contains the starting points
% and the width and height (ending points)
surface = getrect(handles.table);

% ceil $surface and assign it to handles variable
handles.surface = ceil(surface);

% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in codes_list.
function codes_list_Callback(hObject, eventdata, handles)

% get color codes from select list
codes = cellstr(get(hObject, 'String'));

% get the selected color and convert it to color code (0-8)
selected_code = codes{get(hObject, 'Value')}(1) - 48;

% consider using codes = [0:8] and this code for faster performances
% selected_code = codes(str2num(get(hObject, 'Value')(1)));

% assign $selected_code to handles variable
handles.selected_code = selected_code;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function codes_list_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)

% temporary - problem with handles.feed
img2 = imread('exm2.jpg');

load('codeX.mat');

% if user have selected to configure the table surface color
if handles.selected_code == 8

    % set average rgb value to surface average rgb value instead of a ball
    % average rgb value, using $surface
    handles.avg_rgb = average_rgb(img2, handles.surface);
end

codeX(handles.selected_code + 1, :) = handles.avg_rgb;
save('codeX.mat', 'codeX');

set(handles.selected, 'string', interpret_code(handles.selected_code));

% Update handles structure
guidata(hObject, handles);


function click(hObject, eventdata, handles)

% temporary - problem with handles.feed
exm32 = imread('exm2.jpg');

% get the position of the cursor
pos = get(handles.table, 'CurrentPoint');

% isolate and ceil only the x and y location of the cursor
pos = ceil(pos(1, 1:2));

% get the ball identity that is on $pos
ball_identity = identify_ball(exm32, pos);

% isolate the crop area from $ball_identity and modify it to have the
% starting points and width and height (not the ending points);
% consider changing the mechanics of identify_ball(img, point) so it will
% return the width and height instead of the ending points
crop_area = ball_identity(1:4);
crop_area(3:4) = crop_area(3:4) - crop_area(1:2);

% crop the area of the ball
img_ball = imcrop(exm32, crop_area);

% interpret the rgb value of the selected ball into color code (0-8)
color_code = interpret_rgb(ball_identity(5:7))

% if the user have already configured the color of the selected ball
if configured(color_code)
    
    % do more things here after a ball has confirmed (maybe not here?)
    
    % update text box $selected to the new color
    set(handles.selected, 'string', interpret_code(color_code));
end
    
% set axes
axes(handles.current_ball);

% display the selected ball
imshow(img_ball);

% assign the average rgb of the ball so we could retrieve it after the user
% clicks submit and letting the user configure it to his own needs
handles.avg_rgb = ball_identity(5:7);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in clear_config.
function clear_config_Callback(hObject, eventdata, handles)

% create a new matrix so we could reset the old one
codeX = zeros(9, 3);

% save it as the new one
save('codeX.mat', 'codeX');



function selected_Callback(hObject, eventdata, handles)
% hObject    handle to selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selected as text
%        str2double(get(hObject,'String')) returns contents of selected as a double


% --- Executes during object creation, after setting all properties.
function selected_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
