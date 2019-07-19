classdef Hand < handle
    %HAND Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
        Fingers         %Matrix of fingers on hand
        Position        %(number of fingers) by 3 matrix which describes the coordinates of the beginning of each finger
        Origin          %1 by 3 Matrix describing center coordinate of coordinate frame
        PalmLimit       %Coordinate for limit of palm with respect to grasping objects
    end
    
    properties (SetAccess = private, Hidden = false)
        LineCoordinates = [0 0 0]     %n by 3 Matrix for coordinates of joints and end effector, three columns are x,y,z coordinates
       %FingerCoordinates = [0 0 0]
    end
    
    methods
        function obj = Hand(Fingers, Position, Origin, PalmLimit)
            %HAND Construct an instance of this class
            %   Detailed explanation goes here
            obj.Fingers = Fingers;
            obj.Position = Position;
            obj.Origin = Origin;
            obj.PalmLimit = PalmLimit;
            
            %{
            obj.LineCoordinates = [
                Origin
                PalmLimit
            ]
            %}
        end  
        
        
        %{
        function draw(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            scatter3(obj.Origin(1,1), obj.Origin(1,2), obj.Origin(1,3), '*', 'black');
            xlabel('x');
            ylabel('y');
            zlabel('z');
            hold on;
            scatter3(obj.P  almLimit(1,1), obj.PalmLimit(1,2), obj.PalmLimit(1,3), '*', 'red');
            for i = 1: size(obj.Fingers, 2) %i goes from 1 to the number of columns of fingers (i.e. i iterates through the fingers)
                scatter3(obj.Fingers(1, i).Coordinates(:, 1)+obj.Position(i, 1), obj.Fingers(1, i).Coordinates(:, 2)+obj.Position(i, 2), obj.Fingers(1, i).Coordinates(:, 3)+obj.Position(i, 3), 16, 'black', 'filled');
            end
        end
        %}
    end
end

