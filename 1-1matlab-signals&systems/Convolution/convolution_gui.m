function varargout = convolution_gui(varargin)
% CONVOLUTION_GUI M-file for convolution_gui.fig
%      CONVOLUTION_GUI, by itself, creates a new CONVOLUTION_GUI or raises the existing
%      singleton*.
%
%      H = CONVOLUTION_GUI returns the handle to a new CONVOLUTION_GUI or the handle to
%      the existing singleton*.
%
%      CONVOLUTION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVOLUTION_GUI.M with the given input arguments.
%
%      CONVOLUTION_GUI('Property','Value',...) creates a new CONVOLUTION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before convolution_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to convolution_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help convolution_gui

% Last Modified by GUIDE v2.5 20-Apr-2011 12:09:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @convolution_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @convolution_gui_OutputFcn, ...
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

global x;
global t;
global name;


% --- Executes just before convolution_gui is made visible.
function convolution_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to convolution_gui (see VARARGIN)

% Choose default command line output for convolution_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes convolution_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = convolution_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = round(get(handles.slider1, 'Value'));%obtains the slider value from the slider component
set(handles.slider_editText,'String', num2str(sliderValue)); %puts the slider value into the edit text componen
guidata(hObject, handles); % Update handles structure

[t, x, name] = convolution(sliderValue);
for k=1:length(t)
    gaussian(k) = 1/sqrt(2*pi)*exp(-(1/2)*t(k)*t(k));
end
axes(handles.axes1);
plot(t,[x;gaussian]);
ylim([-0.5 1.5]);
title(name);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function slider_editText_Callback(hObject, eventdata, handles)
% hObject    handle to slider_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slider_editText as text
%        str2double(get(hObject,'String')) returns contents of slider_editText as a double

%get the string for the editText component
sliderValue = get(handles.slider_editText,'String');
 
%convert from string to number if possible, otherwise returns empty
sliderValue = str2num(sliderValue);
 
%if user inputs something is not a number, or if the input is less than 0
%or greater than 100, then the slider value defaults to 0
if (isempty(sliderValue) || sliderValue < 1 || sliderValue > 20)
    set(handles.slider1,'Value',1);
    set(handles.slider_editText,'String','1');
else
    set(handles.slider1,'Value',sliderValue);
end


% --- Executes during object creation, after setting all properties.
function slider_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
% axis(handle.axis1);
% t = [-3,-3,-2.5,-2.5,-2,-2,-1.5,-1.5,-1,-1,-0.5,-0.5,0,0,0.5,0.5,1,1,1.5,1.5,2,2,2.5,2.5,3,3];
% x= [zeros(1,11) ones(1,4) zeros(1,11)];
% plot(t,x);


function [a,b,name] = convolution(NOC)
t = [-3,-3,-2.5,-2.5,-2,-2,-1.5,-1.5,-1,-1,-0.5,-0.5,0,0,0.5,0.5,1,1,1.5,1.5,2,2,2.5,2.5,3,3];
t_ = t;
intervall = 3;

unitPulse = ones(1,1);      % unit pulse as nutral element to initialize convolution
x= [zeros(1,11) ones(1,4) zeros(1,11)]; %rectangular function
name = 'x';

timeStep = 2*NOC*intervall / (NOC*length(t)-NOC);
t_ = -NOC*intervall:timeStep:NOC*intervall;
if NOC == 1
    t_ = t;
end
y_ = unitPulse;
for k = 1:NOC
    y_=conv(x, y_);
    if k ~= 1
        y_ = y_ / 4;
        name = strcat(name, '*x');
    end
end
[a, b] = reduceRange(y_, t_, 3);

function [a, b] = reduceRange(y_, t_, r) %reduce range of x_, y_ to r
c = 1;
for i=1:length(y_)
   if t_(i)>=-r && t_(i)<=r
       a(c) = t_(i);
       b(c) = y_(i);
       c = c+1;
   end
end
