
%% Image analyzer code written, badly, by Noah Hudelson jnhudel@bu.edu 3/7/14

% This code runs controls a x-y stage to move sample under a digital
% microscope.  It then reads in digital images from the microscope and
% analyses them for particle size distribution and total area.  
%
% This Main loop initializes the video controls and runs main loop.  Table
% is moved with the serialcom command.  The serialcom command returns
% char string "done" when movement is complete.  Main loop takes image and
% sends image to imageanal for processing.  Image analysis returns particle
% size data and 

%% Initialize
    clear %clears variables
    clc % clears command window
    imaqreset % resets all video objets

    % Initialize camera
    vid = videoinput('winvideo',1,  'YUY2_640x480');   %assigns variable "vid" to video object
    set(vid,'ReturnedColorSpace','rgb');    % Turns video output to rgb
    preview(vid);   % Opens preview screen of video

 
    s1=serial('COM17','BaudRate', 115200);  % Defines the serial x axis
    fopen(s1)                               % Opens the serial   
    pause(2)
    s2=serial('COM11','BaudRate', 115200);  % Defines the serial y axis
    fopen(s2)                               % Opens the serial
    pause(2)


%% Home table
% This sends homing command to the stepper motors and homes the table in x
% and y by running steppers until table limit switches are hit.  

% home x
   movetablenewstupid(s1,5,0)
   pause(30);          %pauses because matlab sucks
% home y
   movetablenewstupid(s2,5,0)
   pause(30);          %pauses because matlab sucks

    
        
    


%% Main Loop

%     %initialize loop variables
%         % use plate dimensions to create vector of moves
%         plate_height = 101.6;   % IN MM
%         plate_width = 101.6;    % IN MM
%         move_size_x = 6.35;  % IN MM  step size set on the arduino
%         move_size_y = 6.35;  % IN MM  step size set on the arduino
%         moves_x = ceil(plate_width/(move_size_x));   % number of steps in x given step size 
%         move_y = ceil(height_width/(move_size_y));  % number of steps in y given plate size
%        

%threshhold value choosen from using setlevel program
thresh = 0.64

move_x = 10;
move_y = 10;

        obs_vec = zeros(move_x,move_y); %preallocates the vector of obscuration data 
       
        % This loop first takes image in intial row positions (j,1) and then
        % procedes to scan in x axis taking pictures at each stop. (j,i)
        % saving obscuration data to a coresponding matrix.
        for j = 1:1:move_x
            sign = -(-1)^(j);  %tells weather row is even or odd.
            img = getsnapshot(vid); % gets intial image from microscope and saves as img
            % imshow(img)
            [imgnew obs] = imanal(img,thresh);  % passes initial img to imanal function gets back new image and obscuration data
            imshow(imgnew);
            if sign == 1
                obs_vec(j,1) = obs  % saves obs data to new
            else
                obs_vec(j,move_x) = obs
            end
            
            for i = 2:1:(move_y)
                movetablenewstupid(s1,2,sign*1400) % tells arduino to move in x returns char string 'done' when it is finished.
                pause(5);
                img = getsnapshot(vid); % gets image from microscope and saves as img
                %imshow(img)
                [imgnew obs] = imanal(img, thresh);  % passes img to imanal function gets back new image and obscuration data
                imshow(imgnew);
                if sign == 1
                    obs_vec(j,i) = obs  % saves obs data to new
                else
                    obs_vec(j,move_x + 1 - i) = obs
                end
            end
            pause(1);
            movetablenewstupid(s2,2,1400) % tells arduino to move in y returns char string 'done' when it is finished.
            pause(5)
            
            
        end
        
  
fclose(s1);                             % closing serial for x axis
delete(s1);                             % deletes serial for x axis
fclose(s2);                             % closing serial for y axis
delete(s2);                             % deletes serial for y axis

        fprintf('all done')
        
        % saving data
        