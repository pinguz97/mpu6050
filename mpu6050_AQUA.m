%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MPU6050 Complementary Filter/Kalman Filter Comparison
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

%% Create Gyro and Accel sim parameters
roll_real_k1 = 0.0;
roll_real_k = 0.0;
roll_vel_real = 0.0;
gyro_drift_real = 1;
gyro_cal_bias_real = 0.01;
gyro_sigma_noise = 0.002;
accel_sigma_noise = sqrt(0.03);

accel_meas_k1 = 0.0;
accel_meas_k = 0.0;
gyro_meas_k1 = 0.0;
gyro_meas_k = 0.0;

dt = 0.004;
t = 0:dt:6;
data = zeros(length(t),19);
%% Calculate q_acc q_mag
accel_meas = zeros(3,1);
mag_meas = zeros(3,1);

% accel_meas = [1/2 0 sqrt(3)/2]';
% mag_meas = [sqrt(3)/2 0 -1/2]';

q_acc = zeros(4,1);
q_mag = zeros(4,1);

% if accel_meas(3) >= 0
%     lambda1 = sqrt((1+accel_meas(3))/2);
%     q_acc = [lambda1 -accel_meas(2)/2/lambda1 accel_meas(1)/2/lambda1 0]';
% else
%     lambda2 = sqrt((1-accel_meas(3))/2);
%     q_acc = [-accel_meas(2)/2/lambda2 lambda2 0  accel_meas(1)/2/lambda2]';
% end
% R_acc = Rmatrix(q_acc);
% l_mag = R_acc*mag_meas;
% gamma = l_mag(1)^2 + l_mag(2)^2;
% if l_mag(1) >= 0
%     q_mag = [sqrt((gamma+l_mag(1)*sqrt(gamma))/2/gamma), 0, 0, l_mag(2)/sqrt(2*(gamma+l_mag(1)*sqrt(gamma)))]';
% else
%     q_mag = [l_mag(2)/sqrt(2*(gamma-l_meas(1)*sqrt(gamma))) 0  sqrt((gamma-l_mag(1)*sqrt(gamma))/2/gamma)]';
% end
% q = Qproduct(q_acc, q_mag);
%% Create complementary filter parameters
angle_roll_k1_hat = 0.0;
angle_roll_k_hat = 0.0;

gain_k1 = 0.99; % gyro gain
gain_k2 = 0.01; % gyro drift correction

xk = zeros(1,2);              % kalman state vector ([roll_hat gyro_drift_hat])
pk = [0.5 0; 0 0.01];          % covariance matrix
K = zeros(1,2);               % kalman gain vector
phi = [1 dt; 0 1];             % state transition matrix
psi = [dt 0];                 % control transition matrix
R = 0.03;                     % measurement noise
Q = [0.002^2 0; 0 0];          % process noise
H = [1 0];

%% Simulation Loop
%euler_real_k = [2.579, -0.0573, 1.9536]';
euler_real_k = [0 0 pi/3]';
%omega_real = [0.1 -0.2 0.1]';
%omega_real = [0.1 0.5235 1]';
omega_real2 = [0 0 pi]';
omega_real = [0.1 pi/6 1]';
omega_real1 = [0 pi 0]';
euler_real_k1 = [0,0,0]';

i = [1 0 0]';
j = [0 1 0]';
k = [0 0 1]';
terna = [i,j,k];
% gyro movements
for i = 1:length(t)
   
        euler_real_k1 = euler_real_k + omega_real * dt;
%       if t(i) <= 2
%       euler_real_k1 = euler_real_k + omega_real * dt;
%       elseif t(i) <= 4
%       euler_real_k1 = euler_real_k + omega_real1 * dt;
%       else
%       euler_real_k1 = euler_real_k + omega_real2 * dt;
%       end
      ciccio  = Rmatrix(euler_real_k1)';
      accel = ciccio*[0 0 1]';
      mag = ciccio*[1 0 0]';
      
      if accel(3) >= 0
        lambda1 = sqrt((1+accel(3))/2);
        q_acc = [lambda1, -accel(2)/2/lambda1, accel(1)/2/lambda1, 0]';
      else
        lambda2 = sqrt((1-accel(3))/2);
        q_acc = [-accel(2)/2/lambda2, lambda2, 0,  accel(1)/2/lambda2]';
      end
      R_acc = Rmatrix(q_acc);
      l_mag = R_acc'*mag;
      gamma = l_mag(1)^2 + l_mag(2)^2;
      if l_mag(1) >= 0
        q_mag = [sqrt((gamma+l_mag(1)*sqrt(gamma))/2/gamma), 0, 0, l_mag(2)/sqrt(2*(gamma+l_mag(1)*sqrt(gamma)))]';
 
      else
        q_mag = [l_mag(2)/sqrt(2*(gamma-l_mag(1)*sqrt(gamma))), 0, 0,  sqrt((gamma-l_mag(1)*sqrt(gamma))/2/gamma)]';
      end
            q = Qproduct(q_acc, q_mag);
            if l_mag(1) <0
            q = [-q(1),-q(2), -q(3),-q(4)];
            end
           
      
%     accel_meas_k1 = roll_real_k1 + randn(1) * accel_sigma_noise;
%     gyro_read_k1 = roll_vel_real - gyro_drift_real + randn(1) * gyro_sigma_noise + gyro_cal_bias_real;
%     gyro_meas_k1 = gyro_read_k1 - gyro_cal_bias_real; % degrees per second
      
    data(i,:) = [t(i), euler_real_k1(1), euler_real_k1(2), euler_real_k1(3), q(1), q(2), q(3), q(4),...
             q_acc(1), q_acc(2), q_acc(3), q_acc(4), q_mag(1), q_mag(4), accel(3), l_mag(1), l_mag(2),accel(1),accel(2)];
    %data(i,:) = [t(i), euler_real_k1(1), euler_real_k1(2), euler_real_k1(3), q_mag(1), q_mag(4), l_mag(1), l_mag(2), accel(3)];
    euler_real_k = euler_real_k1;
    



    
end
%% Plot data
subplot(2,2,2)
plot(t,data(:,5),t,data(:,6), t,data(:,7), t,data(:,8));
grid on
xlim([0 6]);
subplot(2,2,1)
plot(t,data(:,9),t,data(:,10), t,data(:,11), t,data(:,12));
grid on
xlim([0 6]);
subplot(2,2,3)
plot(t,data(:,13),t,data(:,14));
grid on
xlim([0 6]);
subplot(2,2,4)
%plot(t,data(:,15),t,data(:,16),t,data(:,17),t,data(:,18),t,data(:,19));
plot(t,data(:,15),t,data(:,16),t,data(:,17));
grid on
xlim([0 6]);
%plot(t,data(:,5),t,data(:,6), t,data(:,9), t,data(:,7)); %accel and l_mag %discontinuities
%plot(t,data(:,8), t,data(:,9));


