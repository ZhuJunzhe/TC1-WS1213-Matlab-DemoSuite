function varargout = convolution_ani_gui(varargin)
% CONVOLUTION_ANI_GUI M-file for convolution_ani_gui.fig
%      CONVOLUTION_ANI_GUI, by itself, creates a new CONVOLUTION_ANI_GUI or raises the existing
%      singleton*.
%
%      H = CONVOLUTION_ANI_GUI returns the handle to a new CONVOLUTION_ANI_GUI or the handle to
%      the existing singleton*.
%
%      CONVOLUTION_ANI_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVOLUTION_ANI_GUI.M with the given input arguments.
%
%      CONVOLUTION_ANI_GUI('Property','Value',...) creates a new CONVOLUTION_ANI_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before convolution_ani_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to convolution_ani_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help convolution_ani_gui

% Last Modified by GUIDE v2.5 21-Apr-2011 11:18:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @convolution_ani_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @convolution_ani_gui_OutputFcn, ...
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

%global scale definition
global c;
c = -3:.02:3; %sampling scale

%global function definitions
global block;
global triangle;
global sine;
global cosine;
global deltaPeak;
global deltaComb50;
global deltaComb100;
global deltaComb150;
global gaussian;

block = [zeros(1,125) ones(1,51) zeros(1,125)];
triangle = conv(block, block); triangle = triangle(150:450)/50;
sine = sin(c);
cosine = cos(c);
deltaPeak = [zeros(1, 150) 50 zeros(1,150)]; %note: trapz integration over 50 peak is one!
deltaComb50 = [100 zeros(1, 49) 50 zeros(1, 49) 50 zeros(1, 49) 50 zeros(1, 49) 50 zeros(1, 49) 50 zeros(1, 49) 100];
deltaComb100 = [100 zeros(1, 99) 50 zeros(1, 99) 50 zeros(1, 99) 100];
deltaComb150 = [100 zeros(1, 149) 50 zeros(1, 149) 100];
for k=1:length(c)
    gaussian(k) = 1/sqrt(2*pi)*exp(-(1/2)*c(k)*c(k));
end



% --- Executes just before convolution_ani_gui is made visible.
function convolution_ani_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to convolution_ani_gui (see VARARGIN)

% Choose default command line output for convolution_ani_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes convolution_ani_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%init functions
global function1;
global function2;
global block;
function1 = block;
function2 = block;

global positive1;
global positive2;
positive1 = 1;
positive2 = 1;



% --- Outputs from this function are returned to the command line.
function varargout = convolution_ani_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

%gets the selected option
global function1;
global block;
global triangle;
global sine;
global cosine;
global deltaPeak;
global deltaComb50;
global deltaComb100;
global deltaComb150;
global gaussian;

global positive1;

switch get(handles.popupmenu1,'Value')
    case 1 % Box
        function1 = block;
        positive1 = 1;
    case 2 % Triangle
        function1 = triangle;
        positive1 = 1;
    case 3 % Sine
        function1 = sine;
        positive1 = 0;
    case 4 % Cosine
        function1 = cosine;
        positive1 = 0;
    case 5 % Delta Comb
        function1 = deltaPeak;
        positive1 = 1;
    case 6 % Delta Peak 50
        function1 = deltaComb50;
        positive1 = 1;
    case 7 % Delta Peak 100
        function1 = deltaComb100;
        positive1 = 1;
    case 8 % Delta Peak 150
        function1 = deltaComb150;
        positive1 = 1;
    case 9 % Gaussian
        function1 = gaussian;
        positive1 = 1;
    otherwise
end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

%gets the selected option
global function2;
global block;
global triangle;
global sine;
global cosine;
global deltaPeak;
global deltaComb50;
global deltaComb100;
global deltaComb150;
global gaussian;

global positive2;

switch get(handles.popupmenu2,'Value')   
    case 1 % Box
        function2 = block;
        positive2 = 1;
    case 2 % Triangle
        function2 = triangle;
        positive2 = 1;
    case 3 % Sine
        function2 = sine;
        positive2 = 0;
    case 4 % Cosine
        function2 = cosine;
        positive2 = 0;
    case 5 % Delta Comb
        function2 = deltaPeak;
        positive2 = 1;
    case 6 % Delta Peak 50
        function2 = deltaComb50;
        positive2 = 1;
    case 7 % Delta Peak 100
        function2 = deltaComb100;
        positive2 = 1;
    case 8 % Delta Peak 150
        function2 = deltaComb150;
        positive2 = 1;
    case 9 % Gaussian
        function2 = gaussian;
        positive2 = 1;
    otherwise
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
convolute(hObject, eventdata, handles);


% --- The convolution function from file convolution_animation.m ---
function convolute(hObject, eventdata, handles)
global c;
global function1;
global function2;

global min;

global x;
global y;
global p;
global i;
%------------------------
% Set Functions here:
funct1 = function1;
funct2 = function2;

%-------------------------
% Adjust visible scale here
% def: min = -0.2, max = 1.2
global positive1;
global positive2;
if(positive1+positive2 == 2)
    min = -0.2;
else
    min = -1.2;
end
max = 1.2;

%--------------------------
% Plot 1: Two Block Functions
unitPulse = [1 zeros(1,length(c)-1)];
xl = conv(unitPulse, funct1);
x = xl(150:450);
y = funct2;

axes(handles.axes1);
[ax,h1,h2] = plotyy(c,x,c,y);
set(ax(1), 'ylim',[min max]);
set(ax(2), 'ylim',[min max]);
set(h1, 'YDataSource', 'x');
set(h2, 'YDataSource', 'y');
title('f(t) and g(t - \tau) for -3<\tau<3');
xlabel('t');
ylabel('Amplitude');
guidata(hObject, handles);


%--------------------------
% Plot 2: Produkt of two functions
for k=1:length(x)
    p(k) = x(k) * y(k);
end

axes(handles.axes2);
ht2 = plot(c,p);
ylim([min max]);
set(ht2, 'YDataSource', 'p');
title('h(t) = f(t) \cdot g(t - \tau) for -3<\tau<3');
xlabel('t');
ylabel('Amplitude');
guidata(hObject, handles);


%--------------------------
% Plot 3: Integral over Produkt

i = zeros(1,length(x));

axes(handles.axes3);
ht3 = plot(c,i);
ylim([min max]);
set(ht3, 'YDataSource', 'i');
title('\int^3_{-3}h(t)d\tau');
xlabel('\tau');
ylabel('Amplitude');
guidata(hObject, handles);


for l=1:length(c)
    %update plot 1 graph
    shiftPulse = [zeros(1, l) 1 zeros(1,length(c)-(l+1))];
    xl = conv(shiftPulse, funct1);
    x = xl(150:450);
    
    %update plot 2 graph
    for k=1:length(c)
        p(k) = x(k) * y(k);
    end
    
    %update plot 3 graph
    i(l) = trapz(c,p);
    
    refreshdata
    drawnow
end
