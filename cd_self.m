% if application is compiled \ deployed = do not execute 'cd'
if(~isdeployed)
    
    % changing the working directory to the current file directory
    cd(fileparts(which(mfilename)));
end
