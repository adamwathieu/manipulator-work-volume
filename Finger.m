classdef Finger < handle
    %FINGER Basic finger object for robotic hands, using SDH as PoC
    %   This class is an object which is used by the hand class to describe
    %   the fingers of the hand. Further work on this class could include
    %   the use of the triangle system found in v_002.m, generalized enough
    %   so that it is easy and intuitive for a user to describe the
    %   thickness and geometry of the finger. Currently, this class only
    %   represents fingers as lines.
    
    properties
        Links           %number of links 
        LinkLength      %Matrix with lengths of links
        LinkDirection   %character matrix of form 'xxyz...' which describes direction of links in default position
       %LinkPlanes      %a Links*4 size array describing where on link line touch plane should be on
       %PlanesDirection %a 1*1 array desribing orientation of touch planes
        
        Joints          %number of joints
        JointDirection  %Matrix of form 'xxyz...' which describes the axis around which the joints revolve
    end
    
    properties (SetAccess = private, Hidden = false)
        LineCoordinates = [0 0 0]     %n by 3 Matrix for coordinates of joints and end effector, three columns are x,y,z coordinates
       %FingerCoordinates = [0 0 0]
    end
    
    methods
        function obj = Finger(Links, LinkLength, LinkDirection, Joints, JointDirection) %add this when ready: LinkPlanes, PlanesDirection,
            %FINGER Default constructor of Finger class
            %   User creates instance of class, inputting the number of
            %   links, the length of each link, the direction of each link,
            %   the number of joints, and the direction in which the joints
            %   revolve around. A finger always starts with a joint, and
            %   ends with a link.
            obj.Links = Links;
            obj.LinkLength = LinkLength;
            obj.LinkDirection = LinkDirection;
           %obj.LinkPlanes = LinkPlanes;
           %obj.PlanesDirection = PlanesDirection;
            
            obj.Joints = Joints;
            obj.JointDirection = JointDirection;           
            obj.LineCoordinates = getLineCoordinates(obj, zeros(1, Joints));
           %obj.FingerCoordinates = getFingerCoordinates(obj, zeros(1, Joints));
        end
        
        function Configure(obj, JointAngles)
            %CONFIGURE Updates the coordinates of the finger based off of
            %JointAngles matrix passed in by parameter
            %   This function uses the getLineCoordinates function to get
            %   the coordinates for the joints and end effector of the
            %   hand. In this way, this function essentially updates the
            %   position of the hand and its lineCoordinates. Parameters:
            %   obj - the finger being configured, JointAngles - a 1xJoints
            %   matrix with angles, in radians, of the new joints
            %   configuration.
            
            %Call funtion with trchain and 

            inputSize = size(JointAngles, 2);
            assert (inputSize == obj.Joints);
            obj.LineCoordinates = getLineCoordinates(obj, JointAngles);
           %obj.FingerCoordinates = getFingerCoordinates(obj, JointAngles);
        end
        
        
        %{
        function coordinates = getFingerCoordinates(obj)
           coordinates = obj.FingerCoordinates; 
        end 
        %}
         
        function draw(obj)
            scatter3(obj.LineCoordinates(:,1), obj.LineCoordinates(:,2), obj.LineCoordinates(:,3), 16, 'black', 'filled')
           %scatter3(obj.FingerCoordinates(:,1), obj.FingerCoordinates(:,2), obj.FingerCoordinates(:,3), 16, 'red', 'filled')
            xlabel('x');
            ylabel('y');
            zlabel('z');
            hold on;
        end
    end
end

function criticalCoordinates = getLineCoordinates(obj, JointAngles)
    %CRITICALCOORDINATES computes the coordinates of the finger with the
    %given joint angles in the JointAngles matrix
    %   This uses the same forward kinematic matrix computations as v_002.m
    %   but with trot and trans instead of trchain with rotations and
    %   translations passed in as parameters. More information about this
    %   can be found in documentation.
    chainStream = eye(4); %4x4 identity matrix
    criticalCoordinates = [0 0 0];
    for i = 1:obj.Links %for every link in this finger add a Joint and a Link into the matrix computations
        switch obj.JointDirection(1,i)
            case 'x'
                chainStream = chainStream * trotx(JointAngles(1,i));
            case 'y'
                chainStream = chainStream * troty(JointAngles(1,i));
            case 'z'
                chainStream = chainStream * trotz(JointAngles(1,i));
        end
        switch obj.LinkDirection(1,i)
            case 'x'
                chainStream = chainStream * transl(obj.LinkLength(1,i),0,0);
            case 'y'
                chainStream = chainStream * transl(0,obj.LinkLength(1,i),0);
            case 'z'
                chainStream = chainStream * transl(0,0,obj.LinkLength(1,i));
        end
        criticalCoordinates = [
            criticalCoordinates
            chainStream(1,4) chainStream(2,4) chainStream(3,4)
        ];
    end
    
end

%basic structure of getFingerCoordinates with triangle system to give
%fingers volume and geometry. Unfinished.
%{
function criticalCoordinates = getFingerCoordinates(obj, JointAngles)
    chainStream = eye(4);
    criticalCoordinates = [0 0 0];
    for i = 1:obj.Links
        chainStreamFirst2 = eye(4);
        chainStreamSecond2 = eye(4);
        if obj.Links+1-i <= size(LinkPlanes, 1)
            switch obj.JointDirection(1,i)
                case 'x'
                    chainStream = chainStream * trotx(JointAngles(1,i));
                case 'y'
                    chainStream = chainStream * troty(JointAngles(1,i));
                case 'z'
                    chainStream = chainStream * trotz(JointAngles(1,i));
            end
            switch obj.LinkDirection(1,i)
                case 'x'
                    chainStream = chainStream * transl(obj.LinkPlanes(i,1),0,0);
                case 'y'
                    chainStream = chainStream * transl(0,obj.LinkPlanes(i,1),0);
                case 'z'
                    chainStream = chainStream * transl(0,0,obj.LinkPlanes(i,1));
            end
            switch obj.PlanesDirection %WORK ON THIS
                case 'y'
                    chainStream = chainStream * trotz(pi/2);
                    chainStream = chainStream * transl(obj.LinkPlanes(i,3));
                    chainStream 
            end 
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            if i == 1 && j == 1
                criticalCoordinates = [chainStream(1,4) chainStream(2,4) chainStream(3,4)];
            else
                criticalCoordinates = [
                    criticalCoordinates
                    chainStream(1,4) chainStream(2,4) chainStream(3,4)
                ];
            end
        end

    end
    
end
%}
