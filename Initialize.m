classdef Initialize
    %INITIALIZE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        loadSuccess
    end
    
    methods
        function obj = Initialize()
            %INITIALIZE Construct an instance of this class
            %   Detailed explanation goes here
            run startup_rvc.m
            loadSuccess = true;
        end
    end
end

