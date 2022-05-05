function [euler] = quat2euler(quat)
euler  = zeros(3,1);
test = quat(1) * quat(3) + quat(4) * quat(2);
if test > 0.499 
    euler(1) = 2 * atan2(quat(2),quat(1));
    euler(2) = pi/2;
    euler(3) = 0;
elseif test < -0.499 
    euler(1) = -2 * atan2(quat(2),quat(1));
    euler(2) = -pi/2;
    euler(3) = 0;
else
euler(3) = atan2(2*(quat(1)*quat(2)+quat(3)*quat(4)),1-2*(quat(2)^2+quat(3)^2));
euler(2) = asin(2*(quat(1)*quat(3)+quat(4)*quat(2)));
euler(1) = atan2(2*(quat(1)*quat(4)+quat(2)*quat(3)),1-2*(quat(3)^2+quat(4)^2));    
end
end

