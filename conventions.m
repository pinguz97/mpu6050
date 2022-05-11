%euler_real_k = [0 11*pi/20 1/20*pi]';
euler_real_k = [11/20*pi 1*pi/20 0]';
       ciccio  = Rmatrix(euler_real_k)';
      accel = ciccio*[0 0 1]';
      mag = ciccio*[1 0 0]';
      lambda1 = sqrt((1+accel(3))/2);
      lambda2 = sqrt((1-accel(3))/2);
      if accel(3) >= 0
        q_acc = [lambda1, -accel(2)/2/lambda1, accel(1)/2/lambda1, 0]';
      else
        q_acc = [-accel(2)/2/lambda2, lambda2, 0,  accel(1)/2/lambda2]';
      end
      R_acc = Rmatrix(q_acc);
      l_mag = R_acc'*mag;
      q_acc1 = [-accel(2)/2/lambda2, lambda2, 0,  accel(1)/2/lambda2]';
      q_acc2 = [lambda1, -accel(2)/2/lambda1, accel(1)/2/lambda1, 0]';
      gamma = l_mag(1)^2 + l_mag(2)^2;
      if l_mag(1) >= 0
        q_mag = [sqrt((gamma+l_mag(1)*sqrt(gamma))/2/gamma), 0, 0, l_mag(2)/sqrt(2*(gamma+l_mag(1)*sqrt(gamma)))]';
      else
        q_mag = [l_mag(2)/sqrt(2*(gamma-l_mag(1)*sqrt(gamma))), 0, 0,  sqrt((gamma-l_mag(1)*sqrt(gamma))/2/gamma)]';
      end
      q_mag1 = [sqrt((gamma+l_mag(1)*sqrt(gamma))/2/gamma), 0, 0, l_mag(2)/sqrt(2*(gamma+l_mag(1)*sqrt(gamma)))]';
      q_mag3 = Qproduct([0 0 0 1]',q_mag1);
      q_mag2 = [l_mag(2)/sqrt(2*(gamma-l_mag(1)*sqrt(gamma))), 0, 0,  sqrt((gamma-l_mag(1)*sqrt(gamma))/2/gamma)]';
      q = Qproduct(q_acc, q_mag);
      if accel(2) > 0
      q = [q(1),-q(2), -q(3),-q(4)];
      end

i = [1 0 0]';
j = [0 1 0]';
k = [0 0 1]';
terna = [i,j,k];
terna1 = Rmatrix(euler_real_k)*terna;
cicciociccio = Rmatrix(q_acc)*[0 0 1]';
terna2 = Rmatrix(q_acc)'*terna;
quiver3(0, 0, 0, terna(1,1), terna(2,1), terna(3,1),'r');
axis equal;
hold;
quiver3(0, 0, 0, terna(1,2), terna(2,2), terna(3,2),'b');
quiver3(0, 0, 0, terna(1,3), terna(2,3), terna(3,3),'g');
quiver3(0, 0, 0, terna1(1,1), terna1(2,1), terna1(3,1),'r');
quiver3(0, 0, 0, terna1(1,2), terna1(2,2), terna1(3,2),'b');
quiver3(0, 0, 0, terna1(1,3), terna1(2,3), terna1(3,3),'g');
quiver3(0, 0, 0, terna2(1,1), terna2(2,1), terna2(3,1),'r');
quiver3(0, 0, 0, terna2(1,2), terna2(2,2), terna2(3,2),'b');
quiver3(0, 0, 0, terna2(1,3), terna2(2,3), terna2(3,3),'g');
quiver3(0, 0, 0, 0.5, 0, 0,'k');
quiver3(0, 0, 0, 0, 0, 0.5,'k');