% FASTICA for 2+ mixtures %
clear
clc

%% Parameters

% The number of observed mixtures
N = 3; 

% Mixing coeficient
C1 = 1; 
C2 = 0.1;
C3 = 0.5;

%% Generating Mixture

Amix = rand(N,N);

% Reading the audio
S1 = audioread('Src1.wav');
S2 = audioread('Src2.wav');
S3 = audioread('Src3.wav');

S1(1325601:end,:) = [];
S2(1325601:end,:) = [];
S3(1325601:end,:) = [];

mix1 = [S1' * C1; S2' * C2; S3' * C3]; 
mix2 = [S1' * C2; S2' * C3; S3' * C1]; 
mix3 = [S1' * C3; S2' * C1; S3' * C2]; 

audiowrite('Mix1.wav',mix1',44100); %may be M instead of Xobs
audiowrite('Mix2.wav',mix2',44100); %may be M instead of Xobs
audiowrite('Mix3.wav',mix3',44100); %may be M instead of Xobs

figure
subplot(311)
plot(mix1')
xlabel('time (s)') 
ylabel('Signal Amplitude') 
legend('Mixture 1')

subplot(312)
plot(mix2')
xlabel('time (s)') 
ylabel('Signal Amplitude') 
legend('Mixture 2')

subplot(313)
plot(mix3')
xlabel('time (s)')
ylabel('Signal Amplitude') 
legend('Mixture 3')

% Linear mixture of the independent audio source
M = mix1 + mix2 + mix3 ; 

figure
plot(M')
xlabel('time (s)')
ylabel('Signal Amplitude') 
legend('Final Mixture')

X_observe = Amix*M;                              %Matrix consisting of M samples of N observed mixtures

%% Preprocessing, Centering

X = X_observe';

Xmean = mean(X);

for i = 1:N
    X(:,i) = X(:,i) - Xmean(i);
end

%% Preprocessing, Whitening

Es    = cov(X);
[Eigen_val,Eigen_vector] = eig(Es);

% whitened matrix
Z = Eigen_val*1/sqrt(Eigen_vector)*Eigen_val'*X';

%% FastICA algorithm

W = ones(N,N);
for p = 1:N

    %Initiaize row matrix w0 and w1
    w1 = randn(N, 1);
    w1 = w1/norm(w1,2);
    w0 = randn(N, 1);
    w0 = w0/norm(w0, 2);

    while (abs(abs(w0'*w1)-1) > 0.001)
        w0 = w1;        
        w1 = mean(Z.*power(w1'*Z, 3), 2) - 3*w1;
        w1 = w1/norm(w1, 2);
    end
    
    orth  = zeros(N,1);
        
    for j = 1:p-1
        orth = orth + w1'*W(:,j)* W(:,j);
    end
    
    w1      = w1 - orth;        
    w1      = w1 / norm(w1, 2);
    W(:,p) = w1; 
end
Sep = W'*Z;

%% Plotting and saving seperated audios

for item=1:N
    Sep(item,:) = rescale(Sep(item,:),-1,1);
end

figure
subplot(311)
plot(Sep(1,:))
xlabel('time (s)') 
ylabel('Signal Amplitude') 
legend('Source Estimation 1')

subplot(312)
plot(Sep(2,:))
xlabel('time (s)') 
ylabel('Signal Amplitude') 
legend('Source Estimation 2')

subplot(313)
plot(Sep(3,:))
xlabel('time (s)')
ylabel('Signal Amplitude') 
legend('Source Estimation 3')

audiowrite('Sep_1.wav',Sep(1,:),44100);
audiowrite('Sep_2.wav',Sep(2,:),44100);
audiowrite('Sep_3.wav',Sep(3,:),44100);