A1 = 98; %length from joint 1 to joint 2 (hypothetically), constant
A2 = 86.5; %length from joint 2 to joint 3, constant 
A3 = 68.5; %length from joint 3 to fingertip, constant 

q1 = 0; %angle of joint 1 of bottom left finger: must be >0 and < pi/2
q2 = 0; %angle of joint 2 of bottom left finger: must be >-pi/2 and < pi/2
q3 = 0; %angle of joint 3 of bottom left finger: must be >-pi/2 and < pi/2

q4 = 0; %angle of joint 1 of top left finger: should be -q1 (I think
q5 = 0; %angle of joint 2 of top left finger: must be >-pi/2 and < pi/2
q6 = 0; %angle of joint 3 of top left finger: must be >-pi/2 and < pi/2

q7 = 0; %angle of joint 2 of middle right finger: must be >-pi/2 and < pi/2
q8 = 0; %angle of joint 3 of middle right finger: must be >-pi/2 and < pi/2

%Numbers for testing.
%{
q1 = pi/6;
q2 = -pi/4;
q3 = pi/4;
q5 = 0;
q6 = pi/2;
q7 = pi/4;
q8 = pi/6;
%}
%~Numbers for testing.

precision = 5; % 0% to 100% precision for finding optimal hand position
iteration = 1/precision;

maxVolume = 1;
maxAngle = [];
maxCriticalPoints = [];
maxCoordinates = [];

test = pi/2;
test2 = -test;
test3 = test;
A7 = 17.5;
A8 = 69;

A9 = 15.876;
A11 = 12;

A12 = 33.032;

for q1 = 0.8:iteration:pi/2
   q4 = -q1;
   disp(['Reached the outermost loop. q1 is equal to: ' num2str(q1) '. <===============================']);
   
   %finger 1
   jOneMat_1 = trchain('Rx(q1)Tx(A1)', q1);
   %finger 2
   jOneMat_2 = trchain('Rx(q4)Tx(A1)', q4);
   %finger 3
   jOneMat_3 = trchain('Rx(q4)Tx(A1)', 0);
   
   for q2 = -pi/2:iteration:pi/2
       disp(['Inside the q2 loop. q2 is equal to: ' num2str(q2) '.']);
       if q2 < 0
           i = -pi/2-q2;
       else
           i = -pi/2;
       end
       
       %finger 1
       jTwoMat_1 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)', [q1, q2]);
       
       %-------------------------------------FINGER ONE COORDINATES------------------------------------------%
       jOneMat_triPrism_test = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A7)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q1, q2, test, test2]);
       jOneMat_triPrism_test2 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A7)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q1, q2, test, test3]);
       jOneMat_triPrism_test3 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A8)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q1, q2, test, test2]);
       jOneMat_triPrism_test4 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A8)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q1, q2, test, test3]);
       
       finger1_pad1 = [
       jOneMat_triPrism_test(1,4) jOneMat_triPrism_test(2,4) jOneMat_triPrism_test(3,4)
       jOneMat_triPrism_test2(1,4) jOneMat_triPrism_test2(2,4) jOneMat_triPrism_test2(3,4)
       jOneMat_triPrism_test3(1,4) jOneMat_triPrism_test3(2,4) jOneMat_triPrism_test3(3,4)
       jOneMat_triPrism_test4(1,4) jOneMat_triPrism_test4(2,4) jOneMat_triPrism_test4(3,4)
            ];
       
      for q3 = i:iteration:pi/2
         %finger 1
         endEffMat_1 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A3)', [q1, q2, q3]); 
         
         %-------------------------------------FINGER ONE COORDINATES------------------------------------------%
         jOneMat_triPrism_test5 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A7)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q1, q2, q3, test, test2]);
         jOneMat_triPrism_test6 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A7)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q1, q2, q3, test, test3]);
         jOneMat_triPrism_test7 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A12)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q1, q2, q3, test, test2]);
         jOneMat_triPrism_test8 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A12)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q1, q2, q3, test, test3]);
         
         finger1_pad2 = [
            jOneMat_triPrism_test5(1,4) jOneMat_triPrism_test5(2,4) jOneMat_triPrism_test5(3,4)
            jOneMat_triPrism_test6(1,4) jOneMat_triPrism_test6(2,4) jOneMat_triPrism_test6(3,4)
            jOneMat_triPrism_test7(1,4) jOneMat_triPrism_test7(2,4) jOneMat_triPrism_test7(3,4)
            jOneMat_triPrism_test8(1,4) jOneMat_triPrism_test8(2,4) jOneMat_triPrism_test8(3,4)
         ];
         
         for q5 = -pi/2:iteration:pi/2
             disp(['Inside the q5 loop. q5 is equal to: ' num2str(q5) '.']);
             if q5 < 0
                j = -pi/2-q5;
             else
                j = -pi/2;
             end
             
             %finger 2
             jTwoMat_2 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)', [q4, q5]);
             
             %-------------------------------------FINGER TWO COORDINATES------------------------------------------%
             jTwoMat_triPrism_test = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A7)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q4, q5, test, test2]);
             jTwoMat_triPrism_test2 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A7)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q4, q5, test, test3]);
             jTwoMat_triPrism_test3 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A8)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q4, q5, test, test2]);
             jTwoMat_triPrism_test4 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A8)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q4, q5, test, test3]);
             
             finger2_pad1 = [
                jTwoMat_triPrism_test(1,4) jTwoMat_triPrism_test(2,4) jTwoMat_triPrism_test(3,4)+66
                jTwoMat_triPrism_test2(1,4) jTwoMat_triPrism_test2(2,4) jTwoMat_triPrism_test2(3,4)+66
                jTwoMat_triPrism_test3(1,4) jTwoMat_triPrism_test3(2,4) jTwoMat_triPrism_test3(3,4)+66
                jTwoMat_triPrism_test4(1,4) jTwoMat_triPrism_test4(2,4) jTwoMat_triPrism_test4(3,4)+66
             ];
             
             for q6 = j:iteration:pi/2
                 
                %finger 2
                endEffMat_2 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A3)', [q4, q5, q6]); 
                
                %-------------------------------------FINGER TWO COORDINATES------------------------------------------%
                jTwoMat_triPrism_test5 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A7)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q4, q5, q6, test, test2]);
                jTwoMat_triPrism_test6 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A7)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q4, q5, q6, test, test3]);
                jTwoMat_triPrism_test7 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A12)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q4, q5, q6, test, test2]);
                jTwoMat_triPrism_test8 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A12)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q4, q5, q6, test, test3]);
                
                finger2_pad2 = [
                    jTwoMat_triPrism_test5(1,4) jTwoMat_triPrism_test5(2,4) jTwoMat_triPrism_test5(3,4)+66
                    jTwoMat_triPrism_test6(1,4) jTwoMat_triPrism_test6(2,4) jTwoMat_triPrism_test6(3,4)+66
                    jTwoMat_triPrism_test7(1,4) jTwoMat_triPrism_test7(2,4) jTwoMat_triPrism_test7(3,4)+66
                    jTwoMat_triPrism_test8(1,4) jTwoMat_triPrism_test8(2,4) jTwoMat_triPrism_test8(3,4)+66
                ];
                
                for q7 =  0:iteration:pi/2 %changed the bottom limit of this for loop to 0 because seems unreasonable to have third finger go less than that in an attempt to find maximum volume
                     
                   %finger 3
                   jTwoMat_3 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)', [0, q7]);
                   
                   %-------------------------------------FINGER THREE COORDINATES------------------------------------------%
                   jThreeMat_triPrism_test = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A7)Rz(test2)Tx(A9)Rx(test2)Ty(A11)', [0, q7, test2, test2]);
                   jThreeMat_triPrism_test2 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A7)Rz(test2)Tx(A9)Rx(test3)Ty(A11)', [0, q7, test2, test3]);
                   jThreeMat_triPrism_test3 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A8)Rz(test2)Tx(A9)Rx(test2)Ty(A11)', [0, q7, test2, test2]);
                   jThreeMat_triPrism_test4 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A8)Rz(test2)Tx(A9)Rx(test3)Ty(A11)', [0, q7, test2, test3]);
                   
                   finger3_pad1 = [
                        jThreeMat_triPrism_test(1,4) jThreeMat_triPrism_test(2,4)+57.158 jThreeMat_triPrism_test(3,4)+33
                        jThreeMat_triPrism_test2(1,4) jThreeMat_triPrism_test2(2,4)+57.158 jThreeMat_triPrism_test2(3,4)+33
                        jThreeMat_triPrism_test3(1,4) jThreeMat_triPrism_test3(2,4)+57.158 jThreeMat_triPrism_test3(3,4)+33
                        jThreeMat_triPrism_test4(1,4) jThreeMat_triPrism_test4(2,4)+57.158 jThreeMat_triPrism_test4(3,4)+33
                   ];
                   
                   for q8 = -pi/2:iteration:pi/2-q7
                        %finger 3
                        endEffMat_3 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A3)', [0, q7, q8]);
                        
                        criticalPoints = [
                            jOneMat_1(1,4) jOneMat_1(2,4) jOneMat_1(3,4)
                            jTwoMat_1(1,4) jTwoMat_1(2,4) jTwoMat_1(3,4)
                            endEffMat_1(1,4) endEffMat_1(2,4) endEffMat_1(3,4)
                            jOneMat_2(1,4) jOneMat_2(2,4) jOneMat_2(3,4)+66
                            jTwoMat_2(1,4) jTwoMat_2(2,4) jTwoMat_2(3,4)+66
                            endEffMat_2(1,4) endEffMat_2(2,4) endEffMat_2(3,4)+66
                            jOneMat_3(1,4) jOneMat_3(2,4)+57.158 jOneMat_3(3,4)+33
                            jTwoMat_3(1,4) jTwoMat_3(2,4)+57.158 jTwoMat_3(3,4)+33
                            endEffMat_3(1,4) endEffMat_3(2,4)+57.158 endEffMat_3(3,4)+33
                        ]; %array of coordinates for all fingers

                        %-------------------------------------FINGER THREE COORDINATES------------------------------------------%
                        jThreeMat_triPrism_test5 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A2)Rz(q8)Tx(A7)Rz(test2)Tx(A9)Rx(test2)Ty(A11)', [0, q7, q8, test2, test2]);
                        jThreeMat_triPrism_test6 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A2)Rz(q8)Tx(A7)Rz(test2)Tx(A9)Rx(test3)Ty(A11)', [0, q7, q8, test2, test3]);
                        jThreeMat_triPrism_test7 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A2)Rz(q8)Tx(A12)Rz(test2)Tx(A9)Rx(test2)Ty(A11)', [0, q7, q8, test2, test2]);
                        jThreeMat_triPrism_test8 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A2)Rz(q8)Tx(A12)Rz(test2)Tx(A9)Rx(test3)Ty(A11)', [0, q7, q8, test2, test3]);

                        finger3_pad2 = [
                            jThreeMat_triPrism_test5(1,4) jThreeMat_triPrism_test5(2,4)+57.158 jThreeMat_triPrism_test5(3,4)+33
                            jThreeMat_triPrism_test6(1,4) jThreeMat_triPrism_test6(2,4)+57.158 jThreeMat_triPrism_test6(3,4)+33
                            jThreeMat_triPrism_test7(1,4) jThreeMat_triPrism_test7(2,4)+57.158 jThreeMat_triPrism_test7(3,4)+33
                            jThreeMat_triPrism_test8(1,4) jThreeMat_triPrism_test8(2,4)+57.158 jThreeMat_triPrism_test8(3,4)+33
                        ];
                        

                        %MATRIX OF ALL RECTANGLE COORDINATES
                        finger_coord = [
                            finger1_pad1
                            finger1_pad2
                            finger2_pad1
                            finger2_pad2
                            finger3_pad1
                            finger3_pad2
                        ];
                        
                        
                        vlm = alphaShape(finger_coord);
                        temp_vol = volume(vlm)/16387.064;
                        
                        if temp_vol >= maxVolume
                            maxVolume = temp_vol;
                            disp(maxVolume);
                            maxAngle = [q1; q2; q3; q4; q5; q6; q7; q8];
                            maxCriticalPoints = criticalPoints;
                            maxCoordinates = finger_coord;
                        end
                   end
                end
             end    
         end
      end
   end
end
maxVolume
maxAngle
maxCriticalPoints
maxCoordinates









criticalPointsF1 = maxCriticalPoints(1:3, :); %array of coordinates for bottom left finger
criticalPointsF2 = maxCriticalPoints(4:6, :); %array of coordinates for top left finger
criticalPointsF3 = maxCriticalPoints(7:9, :); %array of coordinates for middle right finger

%adding coordinates to graph w/ colors
scatter3(criticalPointsF1(:,1), criticalPointsF1(:,2), criticalPointsF1(:,3), 16, 'red', 'filled')
hold on;
scatter3(criticalPointsF2(:,1), criticalPointsF2(:,2), criticalPointsF2(:,3), 16, 'green', 'filled')
scatter3(criticalPointsF3(:,1), criticalPointsF3(:,2), criticalPointsF3(:,3), 16, 'blue', 'filled')

%adding 0 coordinate
scatter3(0,0,0,'*')

xlabel('x')
ylabel('y')
zlabel('z')
legend({'red = finger 1 (bottom left finger)', 'green = finger 2 (top left finger)', 'blue = finger 3 (middle right finger)'})

%-------------------- CREATING LINES -----------------------------------------------%
lineF1_1 = line(criticalPointsF1(1:2,1), criticalPointsF1(1:2,2), criticalPointsF1(1:2,3));
lineF1_2 = line(criticalPointsF1(2:3,1), criticalPointsF1(2:3,2), criticalPointsF1(2:3,3));
lineF2_1 = line(criticalPointsF2(1:2,1), criticalPointsF2(1:2,2), criticalPointsF2(1:2,3));
lineF2_2 = line(criticalPointsF2(2:3,1), criticalPointsF2(2:3,2), criticalPointsF2(2:3,3));
lineF3_1 = line(criticalPointsF3(1:2,1), criticalPointsF3(1:2,2), criticalPointsF3(1:2,3));
lineF3_2 = line(criticalPointsF3(2:3,1), criticalPointsF3(2:3,2), criticalPointsF3(2:3,3));
%-----------------------------------------------------------------------------------%

%---------------CREATING INTERMEDIATE POINTS FOR TRIANGULAR PRISMS------------------%
%------FINGER 1 (BOTTOM LEFT)--------%
%{
temp = criticalPointsF1(2, :) - criticalPointsF1(1, :);
n = temp/norm(temp) %unit vector of first line of finger 1
n = n*17.5; %17.5 is a constant: it is the length from 0 coordinate to the start of grip sensors along line
triCoord1 = [criticalPointsF1(1, :) + n; criticalPointsF1(2, :) - n];
scatter3(triCoord1(:,1), triCoord1(:,2), triCoord1(:,3), 'filled')
%}
%-----------------------------------------------------------------------------------%
%{
test = pi/2;
test2 = -test;
test3 = test;
A7 = 17.5;
A8 = 69;
A12 = 33.032;


A9 = 15.876;
A11 = 12;
%}

%{
jOneMat_linetest0 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A7)', [q1, q2]);
jOneMat_linetest = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A7)Rz(test)Tx(A9)', [q1, q2, test]);
criticalTest = [
    jOneMat_linetest0(1,4) jOneMat_linetest0(2,4) jOneMat_linetest0(3,4)
    jOneMat_linetest(1,4) jOneMat_linetest(2,4) jOneMat_linetest(3,4)
];
lineTester = line(criticalTest(:,1), criticalTest(:,2), criticalTest(:,3));
%}



scatter3(maxCoordinates(:,1), maxCoordinates(:,2), maxCoordinates(:,3), 16, 'black', 'filled')
vlm = alphaShape(maxCoordinates);
h = plot(vlm);


%vlm = alphaShape(finger_coord);
%h = plot(vlm);
%volume(vlm);
%vol = volume(vlm)/16387.064

%patch(finger1_pad1(:,1), finger1_pad1(:,2), finger1_pad1(:,3))
%{
vlm = alphaShape(finger_coord);
%h = plot(vlm);
volume(vlm)
volume(vlm)/16387.064

ptCloud = pointCloud(criticalPoints);
model = pcfitcylinder(ptCloud, 1, 'MaxNumTrials', 1000, 'Confidence', 99)
plot(model);
%volume(model)
%}













%hold on;
%scatter3(jOneMat_triPrism_test2(1,4), jOneMat_triPrism_test2(2,4), jOneMat_triPrism_test2(3,4), 16, 'cyan', 'filled')
%scatter3(jOneMat_triPrism_test3(1,4), jOneMat_triPrism_test3(2,4), jOneMat_triPrism_test3(3,4), 16, 'black', 'filled')
%scatter3(jOneMat_triPrism_test4(1,4), jOneMat_triPrism_test4(2,4), jOneMat_triPrism_test4(3,4), 16, 'cyan', 'filled')


%scatter3(110.374, -10.7166, -6.18711, 'filled')

%{
shp = alphaShape(criticalPoints);
h = plot(shp);
volume(shp)
volume(shp)/16387.064
%}

%criticalPoints/25.4 %mm to inches conversion
%scatter3(criticalPoints(:,1), criticalPoints(:,2), criticalPoints(:,3), 'filled')
%scatter3(criticalPoints(1,1), criticalPoints(1,2), criticalPoints(1,3), 'filled')
%hold on;
%scatter3(criticalPoints(2,1), criticalPoints(2,2), criticalPoints(2,3), 'filled')
%endEffPoint = [endEffMat(1,4); endEffMat(2,4); endEffMat(3,4)];
%x = endEffMat(1,4);
%y = endEffMat(2,4);
%z = endEffMat(3,4);
%endEffCoord = sprintf('end effector coordinate: (%d,%d,%d)', x,y,z);
