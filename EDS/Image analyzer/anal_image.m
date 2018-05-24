function  anal_image(thresh, plate_width,plate_height, rows, columns)
%% Image analyzer code written, badly, by Noah Hudelson jnhudel@bu.edu 3/7/14
%
% This code runs controls a x-y stage to move sample under a digital
% microscope.  It then reads in digital images from the microscope and
% analyses them for particle size distribution and total area.  
%
% This Main loop initializes the video controls and runs main loop.  Table
% is moved with the serialcom command.  The serialcom command returns
% char string "done" when movement is complete.  Main loop takes image and
% sends image to imageanal for processing.  Image analysis returns particle
% size data and 


    imaqreset % resets all video objets to take control of camera from IAGUI
    % vid = imaqhwinfo('winvideo') %gets video input
    % Initialize camera
    vid = videoinput('winvideo',1,  'YUY2_640x480');
    set(vid,'ReturnedColorSpace','rgb');
%     preview(vid);

%  
    s1=serial('COM17','BaudRate', 115200);  % Defines the serial x axis
    fopen(s1)                               % Opens the serial   
    pause(1)
    s2=serial('COM11','BaudRate', 115200);  % Defines the serial y axis
    fopen(s2)                               % Opens the serial
    pause(1)


%% Home table
% This sends homing command to the stepper motors and homes the table in x
% and y by running steppers until table limit switches are hit.  

% home x
    result = movetablenew(s1,5,0);
% home y
    result = movetablenew(s2,5,0);


%% Main Loop

%     %initialize loop variables
        % use plate dimensions to create vector of moves
        
        move_x = (ceil(plate_width/columns)/.025) ;  % IN MM  step size set on the arduino
        move_y = (ceil(plate_height/rows)/.025);  % IN MM  step size set on the arduino
      
        
        % trouble shooting inputs
%         fprintf('Information passed anal_image: \n thresh  %d \n plate  width  %d \n plate  height %d \n rows  %d \n columns %d \n',...
%             thresh, plate_width, plate_height, rows, columns);
%         fprintf('I''ve calculated %d moves for x and %d for y \n',move_x, move_y);

%threshhold value choosen from using setlevel program


        obs_vec = zeros(move_x,move_y); %preallocates the vector of obscuration data 
       
        % This loop first takes image in intial row positions (j,1) and then
        % procedes to scan in x axis taking pictures at each stop. (j,i)
        % saving obscuration data to a coresponding matrix.
        for j = 1:1:columns
                 img = getsnapshot(vid); % gets intial image from microscope and saves as img 
%                  imshow(img)
                 [imgnew obs] = imanal(img,thresh);  % passes initial img to imanal function gets back new image and obscuration data
                 imshow(imgnew);
                 obs_vec(j,1) = obs  % saves obs data to new
            for i = 2:1:rows
                 result = movetablenew(s1,2,move_x); % tells arduino to move in x returns char string 'done' when it is finished.
                 img = getsnapshot(vid); % gets image from microscope and saves as img
%                 imshow(img)
                 [imgnew obs] = imanal(img, thresh);  % passes img to imanal function gets back new image and obscuration data
                 imshow(imgnew);
                 obs_vec(j,i) = obs  % saves obs data to new
            end
               result = movetablenew(s1,5,0); % returns tabe to  it's x axis home position so that the cycle of hate can start over again.
               result = movetablenew(s2,2,move_y); % tells arduino to move in y returns char string 'done' when it is finished.
        end
       
        
fclose(s1);                             % closing serial for x axis
delete(s1);                             % deletes serial for x axis
fclose(s2);                             % closing serial for y axis
delete(s2);                             % deletes serial for y axis


%save data to filename
tstamp = clock;  %saves clock output to be used as data file name
filename = sprintf('obsmat_%s_%s_%s',date,num2str(tstamp(4)),num2str(tstamp(5))); % constructs file name of form obsmat_date_hour:min
save(sprintf('%s',filename),obs_vec) %saves data to file

        
% %         fprintf('all done')

end
