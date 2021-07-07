function blkStruct = slblocks
    % This function specifies that the library should appear
    % in the Library Browser
    % and be cached in the browser repository
    
    Browser.Library = 'libF16AircraftSubSystemModels';
    % Main Library
    
    Browser.Name = 'F16 Aircraft Sub System Models';
    % Name of the main library apperas in the library browser
    
    blkStruct.Browser = Browser;
end % end of function