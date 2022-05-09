function Rq = Rmatrix(q)
if length(q) == 4
Rq = [ q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2, 2*(q(2)*q(3) - q(1)*q(4)), 2*(q(1)*q(3) + q(2)*q(4));
      2*(q(2)*q(3) + q(1)*q(4)), q(1)^2 - q(2)^2 + q(3)^2 - q(4)^2, 2*(q(3)*q(4) - q(1)*q(2));
      2*(q(2)*q(4) - q(1)*q(3)), 2*(q(1)*q(2) + q(3)*q(4)), q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2
];
elseif length(q) == 3
    Rq = [ cos(q(2))*cos(q(3)), -cos(q(1))*sin(q(3))+sin(q(1))*sin(q(2))*cos(q(3)), sin(q(1))*sin(q(3))+cos(q(1))*sin(q(2))*cos(q(3));
      cos(q(2))*sin(q(3)), cos(q(1))*cos(q(3))+sin(q(1))*sin(q(2))*sin(q(3)), -sin(q(1))*cos(q(3))+cos(q(1))*sin(q(2))*sin(q(3));
      -sin(q(2)),             sin(q(1))*cos(q(2)),                                           cos(q(1))*cos(q(2))

];
end
end

