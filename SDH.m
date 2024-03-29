classdef SDH < Hand
    %SDH Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
        
    end
    
    methods
        function obj = SDH()
            %SDH Construct an instance of this class
            %   Detailed explanation goes here
            finger1 = Finger(3, [16.5 86.5 68.5], 'xxx', 3, 'xzz'); %bottom left
            finger2 = Finger(3, [16.5 86.5 68.5], 'xxx', 3, 'xzz'); %top left
            finger3 = Finger(2, [86.5 68.5], 'xx', 2, 'zz'); %middle right
            PositionsSchunk = [81.5 0 0; 81.5 0 66; 98 57.158 33];
            Origin = [0 0 0];
            PalmLimit = [0 0 0];
            obj@Hand([finger1 finger2 finger3], PositionsSchunk, Origin, PalmLimit);
            obj.configureDefaultFingers(); %default joint angles for SDH
            
        end
        
        function configureDefaultFingers(obj)
            obj.configureFingers([pi/4 -pi/4 pi/4], [-pi/4 -pi/4 pi/4], [pi/6 -pi/6]);
        end
        
        function configureFinger1(obj, JointAngles)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.Fingers(1,1).Configure(JointAngles);
        end
        
        function configureFinger2(obj, JointAngles)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.Fingers(1,2).Configure(JointAngles);
        end
        
        function configureFinger3(obj, JointAngles)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.Fingers(1,3).Configure(JointAngles);
        end
        
        function configureFingers(obj, JointAngles1, JointAngles2, JointAngles3)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.Fingers(1,1).Configure(JointAngles1);
            obj.Fingers(1,2).Configure(JointAngles2);
            obj.Fingers(1,3).Configure(JointAngles3);
        end
        
        function volCoordinates = getVolCoordinates(obj)
             volCoordinates = [0 0 0]; %initizalize matrix   
                
             for i = 1:size(obj.Fingers, 2) %iterate through the number of fingers
                  if i == 1 || i == 2
                      if i == 1
                        volCoordinates = [
                            obj.Fingers(1, i).LineCoordinates(2:size(obj.Fingers(1, i).LineCoordinates, 1), 1) + obj.Position(i, 1), obj.Fingers(1, i).LineCoordinates(2:size(obj.Fingers(1, i).LineCoordinates, 1), 2) + obj.Position(i, 2), obj.Fingers(1, i).LineCoordinates(2:size(obj.Fingers(1, i).LineCoordinates, 1), 3) + obj.Position(i, 3);
                        ];
                      
                      else
                        volCoordinates = [
                            volCoordinates
                            obj.Fingers(1, i).LineCoordinates(2:size(obj.Fingers(1, i).LineCoordinates, 1), 1) + obj.Position(i, 1), obj.Fingers(1, i).LineCoordinates(2:size(obj.Fingers(1, i).LineCoordinates, 1), 2) + obj.Position(i, 2), obj.Fingers(1, i).LineCoordinates(2:size(obj.Fingers(1, i).LineCoordinates, 1), 3) + obj.Position(i, 3); 
                        ];
                      end
                  else
                      volCoordinates = [
                          volCoordinates
                          obj.Fingers(1, i).LineCoordinates(:, 1) + obj.Position(i, 1), obj.Fingers(1, i).LineCoordinates(:, 2) + obj.Position(i, 2), obj.Fingers(1, i).LineCoordinates(:, 3) + obj.Position(i, 3);
                      ]; 
                  end    
             end
        end  
        
        function volCoordinates = getFinger1VolCoordinates(obj)
            volCoordinates = [
                obj.Fingers(1, 1).LineCoordinates(2:size(obj.Fingers(1, 1).LineCoordinates, 1), 1) + obj.Position(1, 1), obj.Fingers(1, 1).LineCoordinates(2:size(obj.Fingers(1, 1).LineCoordinates, 1), 2) + obj.Position(1, 2), obj.Fingers(1, 1).LineCoordinates(2:size(obj.Fingers(1, 1).LineCoordinates, 1), 3) + obj.Position(1, 3);
            ];
        end  
        
        function volCoordinates = getFinger2VolCoordinates(obj)
            volCoordinates = [
                obj.Fingers(1, 2).LineCoordinates(2:size(obj.Fingers(1, 2).LineCoordinates, 1), 1) + obj.Position(2, 1), obj.Fingers(1, 2).LineCoordinates(2:size(obj.Fingers(1, 2).LineCoordinates, 1), 2) + obj.Position(2, 2), obj.Fingers(1, 2).LineCoordinates(2:size(obj.Fingers(1, 2).LineCoordinates, 1), 3) + obj.Position(2, 3); 
            ];
        end  
        
        function volCoordinates = getFinger3VolCoordinates(obj)
            volCoordinates = [
                obj.Fingers(1, 3).LineCoordinates(:, 1) + obj.Position(3, 1), obj.Fingers(1, 3).LineCoordinates(:, 2) + obj.Position(3, 2), obj.Fingers(1, 3).LineCoordinates(:, 3) + obj.Position(3, 3);
            ];
        end 
    end
end

