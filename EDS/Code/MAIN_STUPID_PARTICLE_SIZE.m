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
 %tic;
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
    s2=serial('COM17','BaudRate', 115200);  % Defines the serial y axis % originally COM12
    fopen(s2)                               % Opens the serial
    pause(2)

  
   
    %% Home table
% This sends homing command to the stepper motors and homes the table in x
% and y by running steppers until table limit switches are hit.  

% home x
   movetablenewstupid(s1,5,0)
   pause(30);          %pauses because matlab sucks
    fclose(s1);
   pause(30);
   
% home y
   movetablenewstupid(s2,5,0)
   pause(30);          %pauses because matlab sucks
   movetablenewstupid(s2,5,0)
   pause(30);          %pauses because matlab sucks
   fclose(s2);
   pause(30);
    


%% Main Loop
%threshhold value choosen from using setlevel program
low_thresh = 0.3;
high_thresh = 1;
channel1 = 2;
channel2 = 0;
ParticleNums=zeros(100,67);
move_x = 10;
move_y = 10;
count = 0;

        %obs_vec = zeros(move_x,move_y); %preallocates the vector of obscuration data 
        obs_vec_no_lines = zeros(move_x,move_y); %preallocates the vector of obscuration data
        
        % This loop first takes image in intial row positions (j,1) and then
        % procedes to scan in x axis taking pictures at each stop. (j,i)
        % saving obscuration data to a coresponding matrix.
        for j = 1:1:move_x
             pause(2)
             fopen(s1)                               % Opens the serial   
             pause(2)
            
            sign = -(-1)^(j);  %tells weather row is even or odd.
            img = getsnapshot(vid); % gets intial image from microscope and saves as img
            %[img_lines obs] = imanal(img, high_thresh,channel1);  % passes img to imanal function gets back new image and obscuration data
            [img_no_lines obs_no_lines] = imanal_no_lines(img,high_thresh,low_thresh,channel1,channel2);
           
            
        
            
            if sign == 1
                %obs_vec(j,1) = obs;  % saves obs data to new
                obs_vec_no_lines(j,1) = obs_no_lines;
                imwrite(img,sprintf('raw%d%d.jpeg',j,1));
                imwrite(img_no_lines,sprintf('binary%d%d.jpeg',j,1));
                
                
            else
                %obs_vec(j,move_x) = obs;
                obs_vec_no_lines(j,move_x) = obs_no_lines;
                imwrite(img,sprintf('raw%d%d.jpeg',j,move_x));
                imwrite(img_no_lines,sprintf('binary%d%d.jpeg',j,move_x));
                
            end
            
            count = count + 1;
            ParticleNums(count,:) = OKAY_blob_size_two(img_no_lines);
            
            for i = 2:1:(move_y)
                pause(2);
                movetablenewstupid(s1,2,sign*1200) % tells arduino to move in x returns char string 'done' when it is finished.
                pause(5);
                img = getsnapshot(vid); % gets image from microscope and saves as img
                imshow(img)
                %[img_lines obs] = imanal(img, high_thresh,channel1);  % passes img to imanal function gets back new image and obscuration data
                [img_no_lines obs_no_lines] = imanal_no_lines(img,high_thresh,low_thresh,channel1,channel2);
                imshow(img_no_lines)
               
                if sign == 1
                    %obs_vec(j,i) = obs;  % saves obs data to new
                    obs_vec_no_lines(j,i) = obs_no_lines;
                    imwrite(img,sprintf('raw%d%d.jpeg',j,i));
                    imwrite(img_no_lines,sprintf('binary%d%d.jpeg',j,i));
                   
                    
                   
                else
                    %obs_vec(j,move_x + 1 - i) = obs;
                    obs_vec_no_lines(j,move_x + 1 - i) = obs_no_lines;
                    imwrite(img,sprintf('raw%d%d.jpeg',j,move_x));
                    imwrite(img_no_lines,sprintf('binary%d%d.jpeg',j,move_x));
                  
                end
                
                count = count + 1;
                ParticleNums(count,:) = OKAY_blob_size_two(img_no_lines);
                
            end
            
          
            
            fclose(s1);
            pause(10);
            fopen(s2);                               % Opens the serial
            pause(2);
            movetablenewstupid(s2,2,1000) % tells arduino to move in y returns char string 'done' when it is finished.
            pause(10)
            fclose(s2);
            pause(10);
            
            
        end
            numdust = sum(ParticleNums);
           
            
            
        
fclose(s1);                             % closing serial for x axis
delete(s1);                             % deletes serial for x axis
fclose(s2);                             % closing serial for y axis
delete(s2);                             % deletes serial for y axis

       
        fprintf('all done')
     
%toc;
        
        % saving data