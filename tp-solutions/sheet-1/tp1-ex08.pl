cargo(tecnico, rogerio).
cargo(tecnico, ivone).

cargo(engenheiro, daniel).
cargo(engenheiro, isabel).
cargo(engenheiro, oscar).
cargo(engenheiro, tomas).
cargo(engenheiro, ana).

cargo(supervisor, luis).
cargo(supervisor_chefe, sonia).
cargo(secretaria_exec, laura).
cargo(diretor, santiago).

chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).

% a) O cargo que chefia técnicos é chefiado por quem?
% b) Listar todos os cargos caso a Ivone chefie técnicos.
% c) Listar duas vezes o nome do supervisor.
% d) Quem é chefiado por supervisores ou supervisores chefe?
% e) Que cargo, sem ser o da Carolina, é chefiado por diretores?
