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
t = 0:dt:10;
data = zeros(length(t),7);

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
% gyro movements
for i = 1:length(t)
   
    roll_vel_real = 0.0;
    if ( i>= 500) && (i <750)
        roll_vel_real = 30.0;
    end
    if ( i>= 1250) && (i <1500)
        roll_vel_real = -40.0;
    end
    if ( i>= 1750) && (i <2000)
        roll_vel_real = 10.0;
    end
    
    roll_real_k1 = roll_real_k + roll_vel_real * dt;
    accel_meas_k1 = roll_real_k1 + randn(1) * accel_sigma_noise;
    gyro_read_k1 = roll_vel_real - gyro_drift_real + randn(1) * gyro_sigma_noise + gyro_cal_bias_real;
    gyro_meas_k1 = gyro_read_k1 - gyro_cal_bias_real; % degrees per second
    
    % Complementary filter
    angle_roll_k1_hat = gain_k1 * (angle_roll_k1_hat + gyro_meas_k1 * dt ) + gain_k2 * accel_meas_k1;
    
    % Kalman filter
    
%     uk = gyro_meas_k1;
%     zk = accel_meas_k1;
%     
%     xk1Minus = phi * xk + psi * uk;
%     pk1Minus = phi * pk * phi' + Q;
%     S = H * pk1Minus * H*R;
%     K = pk1Minus * H' + inv(S);
%     xk1 = xk1Minus + K *(zk - H * xk1Minus);
%     pk1 = (eye(2,2) - K * H) * pk1Minus;
    
    
    data(i,:) = [t(i), roll_real_k1, accel_meas_k1, gyro_meas_k1, angle_roll_k1_hat, 0, 0];
    
    roll_real_k = roll_real_k1;
    angle_roll_k_hat = angle_roll_k1_hat;
   
end

plot(t, data(:,2),t, data(:,5));
grid on
axis([0 10 -15 35]);

