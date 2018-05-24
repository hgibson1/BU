
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

 
    s1=serial('COM11','BaudRate', 115200);  % Defines the serial x axis
    fopen(s1)                               % Opens the serial   
    pause(2)
    s2=serial('COM12','BaudRate', 115200);  % Defines the serial y axis
    fopen(s2)                               % Opens the serial
    pause(2)

  
   
    %% Home table
% This sends homing command to the stepper motors and homes the table in x
% and y by running steppers until table limit switches are hit.  

% home x
   movetablenewstupid(s1,5,0)
   pause(30);          %pauses because matlab sucks
    fclose(s1);
   
% home y
   movetablenewstupid(s2,5,0)
   pause(30);          %pauses because matlab sucks
 fclose(s2);
    


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
filename = 'raw';
low_thresh = 0.32;
high_thresh = 1;
channel1 = 2;
channel2 = 0;

move_x = 10;
move_y = 10;

        obs_vec = zeros(move_x,move_y); %preallocates the vector of obscuration data 
        obs_vec_no_lines = zeros(move_x,move_y); %preallocates the vector of obscuration data
        
        % This loop first takes image in intial row positions (j,1) and then
        % procedes to scan in x axis taking pictures at each stop. (j,i)
        % saving obscuration data to a coresponding matrix.
        for j = 1:1:move_x
             fopen(s1)                               % Opens the serial   
             pause(2)
            
            sign = -(-1)^(j);  %tells weather row is even or odd.
            img = getsnapshot(vid); % gets intial image from microscope and saves as img
            [img_lines obs] = imanal(img, high_thresh,channel1);  % passes img to imanal function gets back new image and obscuration data
            [img_no_lines obs_no_lines] = imanal_no_lines(img,high_thresh,low_thresh,channel1,channel2);
            imshow(img_no_lines); 
            
        
            
            if sign == 1
                obs_vec(j,1) = obs;  % saves obs data to new
                obs_vec_no_lines(j,1) = obs_no_lines
                imwrite(img,sprintf('%s%d%d.jpeg',filename,j,1),'jpeg');
                imwrite(img_no_lines,sprintf('no_lines_%s%d%d.jpeg',filename,j,i));
                
            else
                obs_vec(j,move_x) = obs;
                obs_vec_no_lines(j,move_x) = obs_no_lines
                imwrite(img,sprintf('%s%d%d.jpeg',filename,j,move_x),'jpeg');
            end
            
            for i = 2:1:(move_y)
                movetablenewstupid(s1,2,sign*1200) % tells arduino to move in x returns char string 'done' when it is finished.
                pause(5);
                img = getsnapshot(vid); % gets image from microscope and saves as img
                %imshow(img)
                [img_lines obs] = imanal(img, high_thresh,channel1);  % passes img to imanal function gets back new image and obscuration data
                [img_no_lines obs_no_lines] = imanal_no_lines(img,high_thresh,low_thresh,channel1,channel2);
                imshow(img_no_lines);
                if sign == 1
                    obs_vec(j,i) = obs;  % saves obs data to new
                    obs_vec_no_lines(j,i) = obs_no_lines
                    imwrite(img,sprintf('%s%d%d.jpeg',filename,j,i),'jpeg');
                else
                    obs_vec(j,move_x + 1 - i) = obs;
                    obs_vec_no_lines(j,move_x + 1 - i) = obs_no_lines
                    imwrite(img,sprintf('%s%d%d.jpeg',filename,j,move_x + 1 - i),'jpeg');
                end
            end
            fclose(s1);
            fopen(s2);                               % Opens the serial
            pause(2);
            movetablenewstupid(s2,2,1400) % tells arduino to move in y returns char string 'done' when it is finished.
            pause(5)
            fclose(s2);
            
            
        end
        
  
fclose(s1);                             % closing serial for x axis
delete(s1);                             % deletes serial for x axis
fclose(s2);                             % closing serial for y axis
delete(s2);                             % deletes serial for y axis

        fprintf('all done')
        load handel;
        %sound(y,Fs);
        
        % saving data
        