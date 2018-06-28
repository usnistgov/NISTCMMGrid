%function CMMmap_interp(Xdata, Ydata)
%% CMMmap_interp.m Notes
%   authored by Michael Braine, Physical Science Technician, NIST,
%   Gaithersburg, MD
%   PHONE: 301 975 8746
%   EMAIL: michael.braine@nist.gov
%   correct provided CMM data based on a machine map. Linear interpolation

%% References

%% Inputs

%% Outputs

%% Change Log from v0.001 to v0.001
%////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%   ver 0.001   -initial version
%               
%////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

%% Main Start
    load('map_data.mat'); %load machine map
    
    %map spacing
    map_xspace = inc_X(2)-inc_X(1);
    map_yspace = inc_Y(2)-inc_Y(1);
    [no_rows, no_cols] = size(Xdata);
    for ci = 1:no_cols
        for ri = 1:no_rows
            %determine map interval
            indices = Xdata(ri,ci)<map.inc_X;                                   %lookup map interval where point taken is greater than
                index = find(indices == 1); Xhighindex = index(1);              %first index where logical 0 -> 1, indicating end of interval
                Xmaplow = map.inc_X(Xhighindex-1); Xmaphigh = map.inc_X(Xhighindex); %lookup high and low of interval
                clear indices index
            indices = Ydata(ri,ci)<map.inc_Y;                                   %lookup map interval where point taken is greater than
                index = find(indices == 1); Yhighindex = index(1);              %first index where logical 0 -> 1, indicating end of interval
                Ymaplow = map.inc_Y(Yhighindex-1); Ymaphigh = map.inc_Y(Yhighindex); %lookup high and low of interval
                clear indices index

            %lookup errors
            error_Xlow = map.error_X(Yhighindex-1, Xhighindex-1);
            error_Ylow = map.error_Y(Yhighindex-1, Xhighindex-1);
            error_Xhigh = map.error_X(Yhighindex, Xhighindex);
            error_Yhigh = map.error_Y(Yhighindex, Xhighindex);
            
            
            clear error_Xlow error_Ylow error_Xhigh error_Yhigh
        end
    end
%end %end function CMMmap_interp