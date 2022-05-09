
i = [1 0 0]';
j = [0 1 0]';
k = [0 0 1]';
terna = [i,j,k];

yaw = pi/6;
pitch = 0;
roll = 0;
euler = [yaw pitch roll];

q = [data(600,5),data(600,6),data(600,7),data(600,8)];
R = [ cos(pitch)*cos(yaw), -cos(roll)*sin(yaw)+sin(roll)*sin(pitch)*cos(yaw), sin(roll)*sin(yaw)+cos(roll)*sin(pitch)*cos(yaw);
      cos(pitch)*sin(yaw), cos(roll)*cos(yaw)+sin(roll)*sin(pitch)*sin(yaw), -sin(roll)*sin(yaw)+cos(roll)*sin(pitch)*sin(yaw);
      -sin(pitch),             sin(roll)*cos(pitch),                                           cos(roll)*cos(pitch)

];
Rq = [ q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2, 2*(q(2)*q(3) - q(1)*q(4)), 2*(q(1)*q(3) + q(2)*q(4));
      2*(q(2)*q(3) + q(1)*q(4)), q(1)^2 - q(2)^2 + q(3)^2 - q(4)^2, 2*(q(3)*q(4) - q(1)*q(2));
      2*(q(2)*q(4) - q(1)*q(3)), 2*(q(1)*q(2) + q(3)*q(4)), q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2
];
terna1 = Rq*terna;

quiver3(0, 0, 0, terna(1,1), terna(2,1), terna(3,1),'r');
axis equal;
hold;
quiver3(0, 0, 0, terna(1,2), terna(2,2), terna(3,2),'b');
quiver3(0, 0, 0, terna(1,3), terna(2,3), terna(3,3),'g');
quiver3(0, 0, 0, terna1(1,1), terna1(2,1), terna1(3,1),'r');
quiver3(0, 0, 0, terna1(1,2), terna1(2,2), terna1(3,2),'b');
quiver3(0, 0, 0, terna1(1,3), terna1(2,3), terna1(3,3),'g');