function q = euler2quat(euler)
  cy = cos(euler(1) * 0.5); 
  cp = cos(euler(2) * 0.5);
  cr = cos(euler(3) * 0.5);
  sy = sin(euler(1) * 0.5); 
  sp = sin(euler(2) * 0.5);
  sr = sin(euler(3) * 0.5);
  
  q = zeros(4,1);
  q(1) = cr * cp * cy + sr * sp * sy;
  q(2) = sr * cp * cy - cr * sp * sy;
  q(3) = cr * sp * cy + sr * cp * sy;
  q(4) = cr * cp * sy - sr * sp * cy;

end

