%% 0) Limpar tudo
% -----------------------
clc; clear;
%% 1) Caminhos
% Obtém o nome do computador
hostname = getenv('COMPUTERNAME');   % Windows
hostname = strtrim(hostname);
project_location = pwd;
cd('data');
load('LPF_OUT.mat');
x=LPF_OUT; % ECG INPUT
cd('../');
fs = 360; %
n  = (0:length(x)-1); % eixo em samples

figure('Name', 'LPF OUT');
plotN = 120;
plot( ...
    n(1:plotN), x(1:plotN), ...
    'Color', 'r', ...
    'LineWidth', 2.5, ...
    'LineStyle', '-' , ...
    'DisplayName', 'ECG (MIT-BIH)' ...
    );
grid on; grid minor;
title('ECG'); xlabel('Samples'); ylabel('Amplitude');
legend('Location','northeast');
% Cosim_setup
load = ones(1, length(x));
N = 650e3;
reset = zeros(1, N);
reset(1) = 1;
load = ones(1, N);
load(1) = 0;
disp('Project Ready');
%% Gerador de Estímulo: IMPULSO verificar coeficientes
fs = 360; %
n  = (0:length(x)-1); % eixo em samples

% Configuração
N_total = 120;      % 100 amostras são suficientes para limpar o pipeline
amplitude = 1;   % Valor alto, mas dentro dos 13 bits (Max 4095)

% Criar vetor de zeros
%ecg_impulse = zeros(N_total, 1);
ecg_impulse = zeros(1, N_total);

% Injetar o impulso na amostra 10 (dá tempo do reset passar)
ecg_impulse(10) = amplitude;

% Injetar o impulso na amostra 10 (dá tempo do reset passar)
%ecg_impulse(23) = amplitude;

x=ecg_impulse;

%Força 'ecg' a virar uma LINHA (1xN), não importa como ele entrou
x = x(:)';

disp('>>> Gerador de Estímulo: IMPULSO verificar coeficientes DONE <<<');
figure('Name', 'Impulse');
plotN = 20;

plot( ...
    n(1:plotN), x(1:plotN), ...
    'Color', 'r', ...
    'LineWidth', 2.5, ...
    'LineStyle', '-' , ...
    'DisplayName', 'Impulse' ...
    );
grid on; grid minor;
title('Impulse'); xlabel('Samples'); ylabel('Amplitude');
legend('Location','northeast');

%% Gerador de Estímulo: Degrau verificar saída
fs = 360; %
n  = (0:length(x)-1); % eixo em samples

% Configuração
N_total = 120;      % 100 amostras são suficientes para limpar o pipeline
amplitude = 1;   % Valor alto, mas dentro dos 13 bits (Max 4095)

% Criar vetor de zeros
ecg_stim = zeros(N_total, 1);

% 2. Criar o Degrau
% Do início até t=9 é zero. De t=10 em diante é 1.

ecg_stim(10:end) = amplitude;
x=ecg_stim;

%Força 'ecg' a virar uma LINHA (1xN), não importa como ele entrou
x = x(:)';

disp('>>> Gerador de Estímulo: Degrau verificar saída DONE <<<');
figure('Name', 'STEP');
plotN = 20;

plot( ...
    n(1:plotN), x(1:plotN), ...
    'Color', 'r', ...
    'LineWidth', 2.5, ...
    'LineStyle', '-' , ...
    'DisplayName', 'STEP' ...
    );
grid on; grid minor;
title('STEP'); xlabel('Samples'); ylabel('Amplitude');
legend('Location','northeast');

%% Como verificar se está normalizado?

max_val = max(abs(x));

if max_val <= 1
    disp('O sinal está normalizado.');
else
    disp('O sinal NÃO está normalizado.');
    x = x / max(abs(x));
    disp('O sinal foi normalizado.')
end

%% High-pass Pan-Tompkins (coeficientes explícitos)
b = zeros(1,33);
b(1)   = -1/32;
b(17)  = 1;
b(18)  = -1;
b(33)  = 1/32;

a = [1 -1];

y = filter(b, a, x);


sampole_plot=100;
disp('>>> Rode a Co-Simulação <<<');

figure('Name', 'MATLAB OUTPUT');
plotN = 120;

plot( ...
    n(1:plotN), y(1:plotN), ...
    'Color', 'r', ...
    'LineWidth', 2.5, ...
    'LineStyle', '-' , ...
    'DisplayName', 'MATLAB OUTPUT' ...
    );
grid on; grid minor;
title('MATLAB OUTPUT'); xlabel('Samples'); ylabel('Amplitude');
legend('Location','northeast');
%%  Montar Cosimulação Primeira vez
cd('cosim_link');
cosimWizard;

% Use the HDL simulator executables at the following location
% C:\modeltech64_2020.4\win64
% Next
% Add vhdl
% Compile
% Name os HDL module to cosimulate with: Select Your TOP LEVEL Arch. 
% Imput List, All must be Input for better control
% Configure Data Type output: Usually Fixedpoint, signed, fraction needs to
% be consider. For this exemple fraction needs to to be 9 bits

%% Rodar testes
cd('cosim_link');
open('LPF_IMP_STEP_test.slx');

%% VHDL output

vhdl_out_HPF=out.S_HPF';

figure('Name', 'VHDL OUTPUT');
plotN = 120;
plot( ...
    n(1:plotN), vhdl_out_HPF(1:plotN), ...
    'Color', 'b', ...
    'LineWidth', 2.5, ...
    'LineStyle', '-' , ...
    'DisplayName', 'VHDL OUTPUT' ...
    );
grid on; grid minor;
title('VHDL OUTPUT'); xlabel('Samples'); ylabel('Amplitude');
legend('Location','northeast');


%%

figure('Name', 'Comparação de Sinais');

plotN = 1000;

subplot(2,1,1);
plot( ...
    n(1:plotN), y(1:plotN), ...
    'Color', 'r', ...
    'LineWidth', 2.5, ...
    'LineStyle', '-', ...
    'DisplayName', 'MATLAB OUTPUT' ...
    );
grid on; grid minor;
title('MATLAB OUTPUT');
xlabel('Samples');
ylabel('Amplitude');
legend('Location','northeast');

subplot(2,1,2);
plot( ...
    n(1:plotN), vhdl_out_HPF(1:plotN), ...
    'Color', 'b', ...
    'LineWidth', 2.5, ...
    'LineStyle', '-', ...
    'DisplayName', 'VHDL OUTPUT' ...
    );
grid on; grid minor;
title('VHDL OUTPUT');
xlabel('Samples');
ylabel('Amplitude');
legend('Location','northeast');
