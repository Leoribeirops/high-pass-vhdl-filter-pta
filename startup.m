function startup()
%STARTUP Inicializa o ambiente do projeto (paths e dependências por máquina).

% 1) Determinar o root do projeto a partir deste arquivo
thisFile = mfilename("fullpath");
projectRoot = fileparts(thisFile);

% 2) (Opcional) Limpar paths extras e re-habilitar toolboxes padrão
restoredefaultpath;
rehash toolboxcache;

% 3) Descobrir hostname (Windows/Linux/Mac)
hostname = strtrim(getenv("COMPUTERNAME"));
if hostname == ""
    hostname = strtrim(getenv("HOSTNAME"));
end

fprintf("[STARTUP] Host: %s\n", hostname);
fprintf("[STARTUP] Project root: %s\n", projectRoot);

% 4) Paths do projeto (use apenas o que contém .m / pacotes)
addpath(projectRoot, "-begin");

addProjectPath(fullfile(projectRoot, "cosim_link"));
addProjectPath(fullfile(projectRoot, "data"));
addProjectPath(fullfile(projectRoot, "functions"));
addProjectPath(fullfile(projectRoot, "src"));
addProjectPath(fullfile(projectRoot, "vhdl"));

end

function addProjectPath(p)
% Adiciona diretório do projeto (com genpath apenas se existir e fizer sentido).
addIfExists(p);
end

function addIfExists(p)
% Adiciona path apenas se existir, com log.
if isfolder(p)
    addpath(p, "-begin");
    fprintf("  + %s\n", p);
else
    fprintf("  ! (não encontrado) %s\n", p);
end
end

