function readerGUI()
% EK127 SP2014 Project 3
% Boston University
%
% Gregory Maniatis, Samuel Nichols, Connor Cantelmo, Chris Mullen
%
% The texts for the four books included in this demonstration,
% Alice's Adventure's in Wonderland, Pride and Prejudice, On the Orgin of
% Species, & The Scarlet Letter, were copied from:
% http://www.gutenberg.org
% and used with permission under the terms of the Project Gutenberg License.
%
%

F.MAIN = figure('Name','SpeedReader','units','normalized',...
                        'position',[0.3 0.3 0.4 0.5]);

F.DISPLAY = uicontrol(F.MAIN,...
                        'style','text',...
                        'units','norm',...
                        'position',[0.10 .7 0.1 0.1],...
                        'fontsize',18);

F.GETBOOK_BUTTON = uicontrol(F.MAIN,...
                        'style','push',...
                        'fontsize', 5,...
                        'string','Select a Book',...
                        'units','norm',...
                        'position',[0.2,0.5,0.2,0.1],...
                        'callback',@getbook);

F.SHOWBOOK_TEXT = uicontrol(F.MAIN,...
                        'style','text',...
                        'string','No Book Selected',...
                        'units','norm',...
                        'position',[0.65,0.35,0.3,0.04],...
                        'fontsize',20);
                        
F.CHAPTERS_POPUP = uicontrol(F.MAIN,...
                        'style','popupmenu',...
                        'units','norm',...
                        'position',[0.65 0.001 0.1 0.1],...
                        'string',{''});

F.LOADCHAPTER_BUTTON = uicontrol(F.MAIN,...
                        'style','push',...
                        'units','norm',...
                        'position',[0.7 0.1 0.2 0.1],...
                        'string','Load Chapter',...
                        'callback',@loadChapter);

F.BEGIN_BUTTON = uicontrol(F.MAIN,...
                        'style','push',...
                        'units','norm',...
                        'position',[0.05 0.05 0.2 0.1],...
                        'string','Begin Playback',...
                        'Foregroundcolor', [0.4 0.5 0],...
                        'callback',@readGo);
                   
F.PARA = uicontrol(F.MAIN,...
                        'style','text',...
                        'string','Starting Paragraph:',...
                        'units','norm',...
                        'FontSize', 5,...
                        'position',[0.05 0.3 0.25 0.035]);
 
F.PARA_COUNT = uicontrol(F.MAIN,...
                        'style','text',...
                        'string','Select a Paragraph',...
                        'units','norm',...
                        'FontSize', 30,...
                        'position',[0.05 0.215 0.25 0.035]);
                              
F.PARA_START = uicontrol(F.MAIN,...
                        'style','edit',...
                        'units','norm',...
                        'String','1',...
                        'position',[0.05 0.25 0.25 0.05]);
                    
F.IMAGE = axes('Parent',F.MAIN,...
                        'units','normalized',...
                        'position',[0.5 0.52 0.45 0.45]);

F.WMP_POPUP = uicontrol(F.MAIN,...
    'style','popupmenu',...
    'units','norm',...
    'position',[0.1 0.1 0.5 0.5]);
    

                    
    function getbook(varargin)
        
        % opens ui box for user to select the folder containing the book
        fullPathBook = uigetdir([],'Select a Book');
        set(F.SHOWBOOK_TEXT,'tag',fullPathBook)
        
        if ispc
            slashVec = strfind(fullPathBook,'\');
        else
            slashVec = strfind(fullPathBook,'/');
        end
        
        titleBookRaw = fullPathBook(slashVec(end)+1:end);
        titleBook = strrep(titleBookRaw,'_',' ');
        
        set(F.SHOWBOOK_TEXT,'string',titleBook)
        
        % opens the folder and counts the number of chapters
        tempStruct = dir(fullPathBook);
        
        LEN = length(tempStruct);
        index = zeros(1,LEN);
        for ii = 1:LEN
            if tempStruct(ii).name(1) ~= '.'
                index(ii) = ii;
            end
        end
        index = index(logical(index));
        structBook = tempStruct(index);
        
        cellBook = struct2cell(structBook);
        cellTitles = cellBook(1,:);
        set(F.CHAPTERS_POPUP,'string',cellTitles)
        
        set(F.DISPLAY,'userdata',[])
        
        set(F.CHAPTERS_POPUP,'value', 1)
     
    end

    function loadChapter(varargin)
        set(F.BEGIN_BUTTON,'string','Begin Playback')
        
        chapNum = get(F.CHAPTERS_POPUP,'value');
        chapCell = get(F.CHAPTERS_POPUP,'string');
        
        if strcmp(chapCell{1},'No Book Selected')
            % ut oh.
        else
            fileName = chapCell{chapNum};
            fullPath = [get(F.SHOWBOOK_TEXT,'tag') '/' fileName];
            
            % 'load' the chapter into a cell array
            rawParagraphCellArray = importdata(fullPath,' ');
            
            numOfParagraphs = length(rawParagraphCellArray);
            
            paragraphCellArray = cell(1,numOfParagraphs);
            
            for i = 1:numOfParagraphs
                tempCell = textscan(rawParagraphCellArray{i},'%s');
                paragraphCellArray{i} = tempCell{1};
            end
            
            set(F.DISPLAY,'userdata',paragraphCellArray)
            
            if ~isempty(get(F.DISPLAY,'userdata'))
                set(F.DISPLAY,'string','Load Successful')
            else
                set(F.DISPLAY,'string','Load Error')
            end
        end

    end

    function readGo(varargin)
        
    end

    function stoptext(varargin)
        set(F.STOP_BUTTON, 'tag', 'stop')
    end
end
