 function DriftingBars(Subj, Stim, Emul)
%DriftingBars(Subj_ID, Stim, Emul)
%
% Drifting bars for mapping population receptive fields
%   Subj :  String with subject ID
%   Stim :  Stimulus file name e.g. 'Checkerboard'
%   Emul :  0 = Triggered by scanner, 1 = Trigger by keypress
%

if nargin == 0
    Subj = 66;
    Run = 1;
    Stim = 'Ripples.mat';
    Emul = 1;
    Debug = 1;
end

if isempty(Subj)
    Subj = input('Subject number? ');  
    Run = input('Retinotopic run number? ');    
end

addpath(genpath(fullfile(fileparts(mfilename('fullpath')), 'subfun')));

Task = 'retinotopydriftbar';

PARAMETERS = SetParameters(Subj, Run, Task, Stim);
PARAMETERS.EventCentral = true;

%% Experimental Parameters
PARAMETERS.Apperture = 'Bar';

PARAMETERS.VolsPerCycle = 6;

% Stimulus conditions in each block defined by number
PARAMETERS.Conditions = [90 45 0 135 270 225 180 315];  
 % Rotating movie back & forth by this angle
PARAMETERS.SineRotation = 10; 


%% Run the experiment
BarsMapping(PARAMETERS, Emul, Debug, 1)