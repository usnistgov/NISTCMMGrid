%function nistgrid

%% nistgrid.m Notes
%   authored by Michael Braine, Physical Science Technician, NIST,
%   Gaithersburg, MD
%   PHONE: 301 975 8746
%   EMAIL: michael.braine@nist.gov
%   calculate and correct offsets of a gridplate, among other artifacts, in a machine mapped environment

%% References

%% Inputs

%% Outputs

%% Change Log from v0.001 to v0.001
%////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%   ver 0.001   -initial version
%               
%////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

%% Global Variable Initialization and Main Start
    %initialize global variables
    version = 0.001; fprintf('\nNIST grid v%1.3f\n', version)                   %store and print version number
    mag_vis.X = 0.00001;                                                           %vision system magnification in X, um/px, NIST qualified
    mag_vis.Y = 0.00001;                                                           %vision system magnification in Y, um/px, NIST qualified
    
    %set up data file retrieval directory strings
%     user = getenv('USERNAME');
%     %!!dump data to common directory to simplify this
%     if strcmp(user, 'strang')
%         data_directory = 'G:\MATLAB\NISTgrid\GridDataHere';                     %strang
%     elseif strcmp(user, 'Braine')
%         data_directory = 'I:\GridDataHere';                                     %MB@home
%     elseif strcmp(user, 'braine')
%         data_directory = ['C:\Users\' user '\Documents\GridDataHere'];          %MB@NIST
%     end
    
    %add directories
%    addpath(data_directory)
    nistgrid_directory = pwd;                                                   %get current path of nistgrid directory
    addpath([nistgrid_directory '\nistgrid_functions'])                         %add fringefinder_functions directory to search path for support functions
    addpath([nistgrid_directory '\GridDataHere'])                               %specify where griddata goes, temporary
    
    %display analysis options
    disp('Analysis Options List')
    disp(' '); disp('Enter 1 for Gridplate - Corner reference')
               disp('      2 for Gridplate - Center reference')
               disp('      3 for linescale - 1D (incomplete)')
               disp('      4 for Brunson scale (incomplete)')
    disp(' '); type_analysis = input('Analysis selection: ');                   %ask for analysis selection
    
    %data file inputs
    %data is a text file list of (x,y) coordinates, tab delimited between x and y
    cd GridDataHere;
    disp(' '); disp('List of files in GridDataHere'); ls
    datafile.CMM = input('Filename of CMM position data: ', 's');               %string for CMM position data
        rawdata.CMM = importdata(datafile.CMM);                                    %load vision data
        [no_grids, ~] = size(rawdata.CMM);                                         %length of data list is total number of grids
    datafile.vis = input('Filename of vision system measurement data: ', 's');  %string for vision system measurement data
        rawdata.vis = importdata(datafile.vis);                                    %load vision data
    cd ..
        
    %number of rows in x-direction to parse data
    no_cols = input('Number of rows of gridplate in X-direction of machine: '); %prompt for number of columns in x-direction
        no_rows = no_grids/no_cols;                                             %calculate number of columns in y-direction based on N rows and number of gridpoints
    %parse data
    rawdata.CMMparseX = []; rawdata.CMMparseY = [];                                   %define parse variables for CMM x and y data
    rawdata.visparseY = []; rawdata.visparseY = [];                                   %define parse variables for vision x and y data
    grid_no = 1;
    for i = 1 : no_rows
        rawdata.CMMparseX(i,:) = rawdata.CMM(grid_no:i*no_cols, 1)';
        rawdata.CMMparseY(i,:) = rawdata.CMM(grid_no:i*no_cols, 2)';
        rawdata.visparseX(i,:) = rawdata.vis(grid_no:i*no_cols, 1)';
        rawdata.visparseY(i,:) = rawdata.vis(grid_no:i*no_cols, 2)';

        grid_no = grid_no + no_cols;
    end
    
    %Convert vision pixel data to um and process into CMM positions
    %origin of vision data is bottom left, temporary
    rawdata.visXum = rawdata.visparseX.*mag_vis.X;                              %px * um/px = um
    rawdata.visYum = rawdata.visparseY.*mag_vis.Y;
    data.CMMvisX = rawdata.visXum + rawdata.CMMparseX;
    data.CMMvisY = rawdata.visYum + rawdata.CMMparseY;

    %size of gridplate, mm
    gsize.X = input('Size of gridplate along X-direction of machine, mm: ');    %prompt for size of plate in X, mm
    gsize.Y = input('Size of gridplate along Y-direction of machine, mm: ');    %prompt for size of plate in X, mm
    
    %map correct CMM data

    %set origin
    switch type_analysis
        case 1 %gridplate with corner reference
            %convert data to polar using bottom corner as origin
            %determine angular offset from machine
            %rotate to machine x-axis

        case 2 %gridplate with center reference
            
    end %end switch case analysis type

    %make corrections
%end %end function nistgrid