%v_002_3dprintTest.m 
%Author:  Adam Wathieu
%Date:    July 27, 2019
%Mentor:  Joe Falco
%Project: Investigating the Standardization of Robotic Manipulators
%Robotic Hand: Schunk Dexterous Hand
%
%
%DESCRIPTION
%Added 3d printing functionality to v_002.m. This program will save an stl
%file upon execution, which will have the polyhedron, which you can print.
%the stl file is also in the repo.

A1 = 98; %length from joint 1 to joint 2 (hypothetically), constant
A2 = 86.5; %length from joint 2 to joint 3, constant 
A3 = 68.5; %length from joint 3 to fingertip, constant 

q1 = 0; %angle of joint 1 of bottom left finger: must be >0 and < pi/2
q2 = 0; %angle of joint 2 of bottom left finger: must be >-pi/2 and < pi/2
q3 = 0; %angle of joint 3 of bottom left finger: must be >-pi/2 and < pi/2

q4 = 0; %angle of joint 1 of top left finger: should be -q1_1 (I think
q5 = 0; %angle of joint 2 of top left finger: must be >-pi/2 and < pi/2
q6 = 0; %angle of joint 3 of top left finger: must be >-pi/2 and < pi/2

q7 = 0; %angle of joint 2 of middle right finger: must be >-pi/2 and < pi/2
q8 = 0; %angle of joint 3 of middle right finger: must be >-pi/2 and < pi/2

q1 = pi/4;
q2 = -pi/4;
q3 = pi/4;
q5 = -pi/3;
q6 = pi/3;
q7 = pi/6;
q8 = -pi/6;


%{ 
uncomment this for input
prompt_1 = 'radian rotation for joint 1 of bottom left finger (1b): ';
q1 = input(prompt_1);
while (q1 > pi/2 || q1 < 0) 
    q1 = input(prompt_1); %error checking
end
prompt_2 = 'radian rotation for joint 2 of bottom left finger (4): ';
q2 = input(prompt_2);
while (q2 > pi/2 || q2 < -pi/2) 
    q2 = input(prompt_2); %error checking
end
prompt_3 = 'radian rotation for joint 3 of bottom left finger (5): ';
q3 = input(prompt_3);
while (q3 > pi/2 || q3 < -pi/2) 
    q3 = input(prompt_3); %error checking
end
%}

%------------------------FINGER ONE COMPUTATIONS--------------------------%
jOneMat_1 = trchain('Rx(q1)Tx(A1)', [q1]);
jTwoMat_1 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)', [q1, q2]);
endEffMat_1 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A3)', [q1, q2, q3]);
%--------^^^------------/FINGER ONE COMPUTATIONS-----------^^^------------%


q4 = -q1;
%{ 
uncomment this for input

prompt_4 = 'radian rotation for joint 2 of top left finger (2): ';
q5 = input(prompt_4);
while (q5 > pi/2 || q5 < -pi/2) 
    q5 = input(prompt_5); %error checking
end
prompt_5 = 'radian rotation for joint 3 of top left finger (3): ';
q6 = input(prompt_5);
while (q6 > pi/2 || q6 < -pi/2) 
    q6 = input(prompt_5); %error checking
end
%}

%------------------------FINGER TWO COMPUTATIONS--------------------------%
jOneMat_2 = trchain('Rx(q4)Tx(A1)', [q4]);
jTwoMat_2 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)', [q4, q5]);
endEffMat_2 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A3)', [q4, q5, q6]);
%--------^^^------------/FINGER TWO COMPUTATIONS-----------^^^------------%


%{ 
uncomment this for input
prompt_6 = 'radian rotation for joint 2 of middle right finger (6): ';
q7 = input(prompt_6);
while (q7 > pi/2 || q7 < -pi/2) 
    q7 = input(prompt_6); %error checking
end
prompt_7 = 'radian rotation for joint 3 of middle right finger (7): ';
q8 = input(prompt_7);
while (q8 > pi/2 || q8 < -pi/2) 
    q8 = input(prompt_7); %error checking
end
%}


%-----------------------FINGER THREE COMPUTATIONS-------------------------%
jOneMat_3 = trchain('Rx(q4)Tx(A1)', [0]);
jTwoMat_3 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)', [0, q7]);
endEffMat_3 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A3)', [0, q7, q8]);
%--------^^^-----------/FINGER THREE COMPUTATIONS----------^^^------------%




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
] %array of coordinates for all fingers

criticalPointsF1 = criticalPoints(1:3, :) %array of coordinates for bottom left finger
criticalPointsF2 = criticalPoints(4:6, :) %array of coordinates for top left finger
criticalPointsF3 = criticalPoints(7:9, :) %array of coordinates for middle right finger

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

%Consult documentation to learn more about the values below
test = pi/2;
test2 = -test;
test3 = test;
A7 = 17.5;
A8 = 69;

A9 = 15.876;
A11 = 12;

A12 = 33.032;


%-------------------FINGER ONE TRIANGLE COORDINATES-----------------------%
jOneMat_triPrism_test = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A7)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q1, q2, test, test2]);
jOneMat_triPrism_test2 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A7)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q1, q2, test, test3]);
jOneMat_triPrism_test3 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A8)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q1, q2, test, test2]);
jOneMat_triPrism_test4 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A8)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q1, q2, test, test3]);

jOneMat_triPrism_test5 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A7)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q1, q2, q3, test, test2]);
jOneMat_triPrism_test6 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A7)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q1, q2, q3, test, test3]);
jOneMat_triPrism_test7 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A12)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q1, q2, q3, test, test2]);
jOneMat_triPrism_test8 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A12)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q1, q2, q3, test, test3]);

finger1_pad1 = [
    jOneMat_triPrism_test(1,4) jOneMat_triPrism_test(2,4) jOneMat_triPrism_test(3,4)
    jOneMat_triPrism_test2(1,4) jOneMat_triPrism_test2(2,4) jOneMat_triPrism_test2(3,4)
    jOneMat_triPrism_test3(1,4) jOneMat_triPrism_test3(2,4) jOneMat_triPrism_test3(3,4)
    jOneMat_triPrism_test4(1,4) jOneMat_triPrism_test4(2,4) jOneMat_triPrism_test4(3,4)
]

temp = finger1_pad1(4,:) -  finger1_pad1(1,:);
n = temp/2 ;
midCoordf1p1 = [ finger1_pad1(1, :) + n ]; 
%This value ^^^ is the center coordinate of the rectangle being formed.
%Used for testing purposes.


finger1_pad2 = [
    jOneMat_triPrism_test5(1,4) jOneMat_triPrism_test5(2,4) jOneMat_triPrism_test5(3,4)
    jOneMat_triPrism_test6(1,4) jOneMat_triPrism_test6(2,4) jOneMat_triPrism_test6(3,4)
    jOneMat_triPrism_test7(1,4) jOneMat_triPrism_test7(2,4) jOneMat_triPrism_test7(3,4)
    jOneMat_triPrism_test8(1,4) jOneMat_triPrism_test8(2,4) jOneMat_triPrism_test8(3,4)
]
temp = finger1_pad2(4,:) -  finger1_pad2(1,:);
n = temp/2
midCoordf1p2 = [ finger1_pad2(1, :) + n ];



%-------------------FINGER TWO TRIANGLE COORDINATES-----------------------%
jTwoMat_triPrism_test = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A7)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q4, q5, test, test2]);
jTwoMat_triPrism_test2 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A7)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q4, q5, test, test3]);
jTwoMat_triPrism_test3 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A8)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q4, q5, test, test2]);
jTwoMat_triPrism_test4 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A8)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q4, q5, test, test3]);

jTwoMat_triPrism_test5 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A7)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q4, q5, q6, test, test2]);
jTwoMat_triPrism_test6 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A7)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q4, q5, q6, test, test3]);
jTwoMat_triPrism_test7 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A12)Rz(test)Tx(A9)Rx(test2)Ty(A11)', [q4, q5, q6, test, test2]);
jTwoMat_triPrism_test8 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A12)Rz(test)Tx(A9)Rx(test3)Ty(A11)', [q4, q5, q6, test, test3]);

finger2_pad1 = [
    jTwoMat_triPrism_test(1,4) jTwoMat_triPrism_test(2,4) jTwoMat_triPrism_test(3,4)+66
    jTwoMat_triPrism_test2(1,4) jTwoMat_triPrism_test2(2,4) jTwoMat_triPrism_test2(3,4)+66
    jTwoMat_triPrism_test3(1,4) jTwoMat_triPrism_test3(2,4) jTwoMat_triPrism_test3(3,4)+66
    jTwoMat_triPrism_test4(1,4) jTwoMat_triPrism_test4(2,4) jTwoMat_triPrism_test4(3,4)+66
]
temp = finger2_pad1(4,:) -  finger2_pad1(1,:);
n = temp/2
midCoordf2p1 = [ finger2_pad1(1, :) + n ];


finger2_pad2 = [
    jTwoMat_triPrism_test5(1,4) jTwoMat_triPrism_test5(2,4) jTwoMat_triPrism_test5(3,4)+66
    jTwoMat_triPrism_test6(1,4) jTwoMat_triPrism_test6(2,4) jTwoMat_triPrism_test6(3,4)+66
    jTwoMat_triPrism_test7(1,4) jTwoMat_triPrism_test7(2,4) jTwoMat_triPrism_test7(3,4)+66
    jTwoMat_triPrism_test8(1,4) jTwoMat_triPrism_test8(2,4) jTwoMat_triPrism_test8(3,4)+66
]
temp = finger2_pad2(4,:) -  finger2_pad2(1,:);
n = temp/2
midCoordf2p2 = [ finger2_pad2(1, :) + n ];




%-------------------------------------FINGER THREE COORDINATES------------------------------------------%
jThreeMat_triPrism_test = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A7)Rz(test2)Tx(A9)Rx(test2)Ty(A11)', [0, q7, test2, test2]);
jThreeMat_triPrism_test2 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A7)Rz(test2)Tx(A9)Rx(test3)Ty(A11)', [0, q7, test2, test3]);
jThreeMat_triPrism_test3 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A8)Rz(test2)Tx(A9)Rx(test2)Ty(A11)', [0, q7, test2, test2]);
jThreeMat_triPrism_test4 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A8)Rz(test2)Tx(A9)Rx(test3)Ty(A11)', [0, q7, test2, test3]);

jThreeMat_triPrism_test5 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A2)Rz(q8)Tx(A7)Rz(test2)Tx(A9)Rx(test2)Ty(A11)', [0, q7, q8, test2, test2]);
jThreeMat_triPrism_test6 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A2)Rz(q8)Tx(A7)Rz(test2)Tx(A9)Rx(test3)Ty(A11)', [0, q7, q8, test2, test3]);
jThreeMat_triPrism_test7 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A2)Rz(q8)Tx(A12)Rz(test2)Tx(A9)Rx(test2)Ty(A11)', [0, q7, q8, test2, test2]);
jThreeMat_triPrism_test8 = trchain('Rx(q4)Tx(A1)Rz(q7)Tx(A2)Rz(q8)Tx(A12)Rz(test2)Tx(A9)Rx(test3)Ty(A11)', [0, q7, q8, test2, test3]);

finger3_pad1 = [
    jThreeMat_triPrism_test(1,4) jThreeMat_triPrism_test(2,4)+57.158 jThreeMat_triPrism_test(3,4)+33
    jThreeMat_triPrism_test2(1,4) jThreeMat_triPrism_test2(2,4)+57.158 jThreeMat_triPrism_test2(3,4)+33
    jThreeMat_triPrism_test3(1,4) jThreeMat_triPrism_test3(2,4)+57.158 jThreeMat_triPrism_test3(3,4)+33
    jThreeMat_triPrism_test4(1,4) jThreeMat_triPrism_test4(2,4)+57.158 jThreeMat_triPrism_test4(3,4)+33
]
temp = finger3_pad1(4,:) -  finger3_pad1(1,:);
n = temp/2
midCoordf3p1 = [ finger3_pad1(1, :) + n ];

finger3_pad2 = [
    jThreeMat_triPrism_test5(1,4) jThreeMat_triPrism_test5(2,4)+57.158 jThreeMat_triPrism_test5(3,4)+33
    jThreeMat_triPrism_test6(1,4) jThreeMat_triPrism_test6(2,4)+57.158 jThreeMat_triPrism_test6(3,4)+33
    jThreeMat_triPrism_test7(1,4) jThreeMat_triPrism_test7(2,4)+57.158 jThreeMat_triPrism_test7(3,4)+33
    jThreeMat_triPrism_test8(1,4) jThreeMat_triPrism_test8(2,4)+57.158 jThreeMat_triPrism_test8(3,4)+33
]
temp = finger3_pad2(4,:) -  finger3_pad2(1,:);
n = temp/2
midCoordf3p2 = [ finger3_pad2(1, :) + n ];




%MATRIX OF ALL TRIANGLE COORDINATES
finger_coord = [
    finger1_pad1
    finger1_pad2
    finger2_pad1
    finger2_pad2
    finger3_pad1
    finger3_pad2
]
%scatter3(finger_coord(:,1), finger_coord(:,2), finger_coord(:,3), 16, 'black', 'filled')

%{
%creates faces of polyhedron, and plots it
vlm = alphaShape(finger_coord);
h = plot(vlm);
volume(vlm) %in mm^3
volume(vlm)/16387.064 %volume in inches
%}

shp = alphaShape(finger_coord, 100000);
[bf, P] = boundaryFacets(shp);
stlwrite(triangulation(bf, P), 'v_002_3dprintTest.stl');
