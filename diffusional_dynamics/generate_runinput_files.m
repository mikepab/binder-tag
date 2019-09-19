function generate_runinput_files(dateprefix)

rawdir = dir('vbspt_source/*mat');
input_files = {rawdir.name}';

% bashfilename = '180515_01.sh';
% 
% fbash = fopen(bashfilename,'w');
% fprintf(fbash,'#!/bin/bash\n\n');
% fclose(fbash);
nfiles = length(input_files);
runinputDirectory = 'runinput_files/';
mkdir(runinputDirectory)
for i=1:nfiles
    [~,base_name,~] = fileparts(input_files{i});
    
    for nhidden=2:2
        runinputFilename = ['runinput_' dateprefix '_' base_name '_hidden_' num2str(nhidden)];
        inputName = base_name;
        outputName = [base_name '_HMManalysis_hidden' num2str(nhidden)];
        jobID = ['Data from ' base_name '.mat :: vbspt_tracks :: ' dateprefix];

        writeToRuninput(runinputFilename,runinputDirectory,inputName,outputName,jobID,nhidden);
    
%         fbash = fopen(bashfilename,'a');
%         fprintf(fbash,'sbatch -p general -N 1 -n 12 -t 50:00:00 --wrap="matlab -nodisplay -nosplash -singleCompThread -r launch_vb3SPT_LL\\(\\''%s\\'',\\''//pine//scr//m//i//mikepab//vbSPT//180309_dyeResultsSingleCell//tempDir%i_%i\\''\\) -logfile vbSPT.%i_%i.log"\n',[runinputFilename '.m'],i,nhidden,i,nhidden);
%         fclose(fbash);
    end
end


end


function writeToRuninput(runinputFilename,runinputDirectory,inputName,outputName,jobID,maxHidden)
% Data properties are hardcoded here =====================================
timestep = 0.02; % [s]
dim = 2;
trjLmin = 2;
runs = 25;
%maxHidden = 3;
bootstrapNum = 100;
init_D = [0.0001,5]*1;
init_tD = [2,20]*timestep;
% ========================================================================
% This file layout is based on the vbSPTgui auto-generated runinput file.

fid=fopen([runinputDirectory runinputFilename '.m'],'w');

fprintf(fid,'%% VB-HMM analysis parameter file generated by generate_runinput_files()\n');
fprintf(fid,'%% Mike Pablo 2018-05-02\n\n');

fprintf(fid,'%% Inputs\n');
fprintf(fid,'inputfile = ''../vbspt_source/%s.mat'';\n',inputName);
fprintf(fid,'trajectoryfield = ''vbspt_tracks'';\n');

fprintf(fid,'%% Computing strategy\n');   % --> These are included to allow default parallel options, but my customized Longleaf
fprintf(fid,'parallelize_config = 1;\n'); % --> setup will ignore these options in favor of setup needed for the compute cluster.
fprintf(fid,'parallel_start = ''theVBpool=gcp'';\n');
fprintf(fid,'parallel_end = ''delete(theVBpool)'';\n');

fprintf(fid,'%% Saving options\n');
fprintf(fid,'outputfile = ''./%s.mat'';\n',outputName);
fprintf(fid,'jobID = ''%s'';\n',jobID);

fprintf(fid,'%% Data properties\n');
fprintf(fid,'timestep = %g;\n',timestep);
fprintf(fid,'dim = %i;\n',dim);
fprintf(fid,'trjLmin = %i;\n',trjLmin);

fprintf(fid,'%% Convergence and computation alternatives\n');
fprintf(fid,'runs = %i;\n',runs);
fprintf(fid,'maxHidden = %i;\n',maxHidden);

fprintf(fid,'%% Evaluate extra estimates including Viterbi paths\n');
fprintf(fid,'stateEstimate = 1;\n');

fprintf(fid,'maxIter = [];\n');
fprintf(fid,'relTolF = 1e-8;\n');
fprintf(fid,'tolPar = [];\n');

fprintf(fid,'%% Bootstrapping\n');
fprintf(fid,'bootstrapNum = %i;\n',bootstrapNum);
fprintf(fid,'fullBootstrap = 1;\n');

fprintf(fid,'%% Limits for initial conditions\n');
fprintf(fid,'init_D = [%g,%g];\n',init_D);
fprintf(fid,'init_tD = [%g,%g];\n',init_tD);

fprintf(fid,'%% Prior distributions\n');
fprintf(fid,'%% Diffusion constants\n');
fprintf(fid,'prior_type_D = ''mean_strength'';\n');
fprintf(fid,'prior_D = 1;\n');
fprintf(fid,'prior_Dstrength = 5;\n');

fprintf(fid,'%% Default prior choices (according to nat. meth. 2013 paper)\n');
fprintf(fid,'prior_type_Pi = ''natmet13'';\n');
fprintf(fid,'prior_piStrength = 5;\n');
fprintf(fid,'prior_type_A = ''natmet13'';\n');
fprintf(fid,'prior_tD = 10*timestep;\n');
fprintf(fid,'prior_tDstrength = 2*prior_tD/timestep;\n');

% <Ignored the new prior choices options>
fclose(fid);
end