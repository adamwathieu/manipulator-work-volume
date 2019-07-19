A1 = 98; %length from joint 1 to joint 2 (hypothetically), constant value (change)
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
jOneMat_1 = trchain('Rx(q1)Tx(A1)', [q1]);
%jOneMat
jTwoMat_1 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)', [q1, q2]);
%jTwoMat
endEffMat_1 = trchain('Rx(q1)Tx(A1)Rz(q2)Tx(A2)Rz(q3)Tx(A3)', [q1, q2, q3]);
%endEffMat



q4 = -q1;
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
jOneMat_2 = trchain('Rx(q4)Tx(A1)', [q4]);
jTwoMat_2 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)', [q4, q5]);
endEffMat_2 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)Rz(q6)Tx(A3)', [q4, q5, q6]);

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
jOneMat_3 = trchain('Rx(q4)Tx(A1)', [0]);
jTwoMat_3 = trchain('Rx(q4)Tx(A1)Rz(q5)Tx(A2)', [0, q7]);
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
]

criticalPointsF1 = [
    jOneMat_1(1,4) jOneMat_1(2,4) jOneMat_1(3,4)
    jTwoMat_1(1,4) jTwoMat_1(2,4) jTwoMat_1(3,4)
    endEffMat_1(1,4) endEffMat_1(2,4) endEffMat_1(3,4)
]

criticalPointsF2 = [
    jOneMat_2(1,4) jOneMat_2(2,4) jOneMat_2(3,4)+66
    jTwoMat_2(1,4) jTwoMat_2(2,4) jTwoMat_2(3,4)+66
    endEffMat_2(1,4) endEffMat_2(2,4) endEffMat_2(3,4)+66
]

criticalPointsF3 = [
    jOneMat_3(1,4) jOneMat_3(2,4)+57.158 jOneMat_3(3,4)+33
    jTwoMat_3(1,4) jTwoMat_3(2,4)+57.158 jTwoMat_3(3,4)+33
    endEffMat_3(1,4) endEffMat_3(2,4)+57.158 endEffMat_3(3,4)+33
]

for i = 1:9
    if i < 4
        scatter3(criticalPoints(i,1), criticalPoints(i,2), criticalPoints(i,3), 16, [0 0.4470 0.7410], 'filled')
        hold on;
        %line(criticalPoints(i,1), criticalPoints(i,2), criticalPoints(i,3))
    elseif i < 7
        scatter3(criticalPoints(i,1), criticalPoints(i,2), criticalPoints(i,3), 16, [0.8500 0.3250 0.0980], 'filled')
        %line(criticalPoints(i,1), criticalPoints(i,2), criticalPoints(i,3))
    else
        scatter3(criticalPoints(i,1), criticalPoints(i,2), criticalPoints(i,3), 16, [0.4660 0.6740 0.1880], 'filled')
        %line(criticalPoints(i,1), criticalPoints(i,2), criticalPoints(i,3))
    end
end
lineF1 = line(criticalPointsF1(:,1), criticalPointsF1(:,2), criticalPointsF1(:,3))
lineF2 = line(criticalPointsF2(:,1), criticalPointsF2(:,2), criticalPointsF2(:,3))
lineF3 = line(criticalPointsF3(:,1), criticalPointsF3(:,2), criticalPointsF3(:,3))

%scatter3(110.374, -10.7166, -6.18711, 'filled')


shp = alphaShape(criticalPoints);
h = plot(shp);
volume(shp)
volume(shp)/16387.064

%ptCloud = pointCloud(criticalPoints);
%model = pcfitsphere(ptCloud, 0.01, 'MaxNumTrials', 1000, 'Confidence', 99)
%plot(model);
%volume(model)


criticalPoints/25.4 %mm to inches conversion
%scatter3(criticalPoints(:,1), criticalPoints(:,2), criticalPoints(:,3), 'filled')
%scatter3(criticalPoints(1,1), criticalPoints(1,2), criticalPoints(1,3), 'filled')
%hold on;
%scatter3(criticalPoints(2,1), criticalPoints(2,2), criticalPoints(2,3), 'filled')
%endEffPoint = [endEffMat(1,4); endEffMat(2,4); endEffMat(3,4)];
%x = endEffMat(1,4);
%y = endEffMat(2,4);
%z = endEffMat(3,4);
%endEffCoord = sprintf('end effector coordinate: (%d,%d,%d)', x,y,z);
