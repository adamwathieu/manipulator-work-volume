
%----------------------------------SCHUNK---------------------------------%
finger1 = Finger(3, [16.5 86.5 68.5], 'xxx', 3, 'xzz'); %bottom left
finger2 = Finger(3, [16.5 86.5 68.5], 'xxx', 3, 'xzz'); %top left
finger3 = Finger(2, [86.5 68.5], 'xx', 2, 'zz'); %middle right
Configure(finger1, [pi/4 -pi/4 pi/4]); %q1 q2 q3
Configure(finger2, [-pi/4 -pi/3 pi/3]); %q4 q5 q6
Configure(finger3, [pi/6 -pi/6]); %q7 %q8

PositionsSchunk = [
    81.5 0 0
    81.5 0 66
    98 57.158 33
];

LinkPlanes = [
    17.5 69 15.875 12
    17.5 33.032 15.875 12
];

Schunk = Hand([finger1 finger2 finger3], PositionsSchunk, [0 0 0], [0 0 0])
%draw(Schunk)
%---------------------------------/SCHUNK---------------------------------%




%---------------------------------ALLEGRO---------------------------------%
finger4 = Finger(4, [15.4 54 38.4 15.4], 'zzzz', 4, 'zyyy'); %left
Configure(finger4, [0 pi/2 pi/2 pi/4]);
finger5 = Finger(4, [15.4 54 38.4 15.4], 'zzzz', 4, 'zyyy'); %middle
finger6 = Finger(4, [15.4 54 38.4 15.4], 'zzzz', 4, 'zyyy'); %right
finger7 = Finger(4, [35 15.4 38.4 38.4], 'yyyy', 4, 'zyxx'); %thumb
Configure(finger7, [-pi/6 pi/6 pi/2 pi/2]);

PositionsAllegro = [
    0 -45 0
    0 0 0
    0 45 0
    0 20 -64
];

PalmLimit = [0 0 -64];
Allegro = Hand([finger4 finger5 finger6 finger7], PositionsAllegro, [0 0 0], PalmLimit)
draw(Allegro)
%--------------------------------/ALLEGRO---------------------------------%