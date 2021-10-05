create type disciplina as (
   	codigo integer,
	nome text,
	media numeric
);

create table alunos (
matricula integer primary key,
nome text,
nota disciplina
);

insert into alunos values ('1','Maria', Row(9, 'PAA', 6.0)),
						  ('2','Carlos', Row(10, 'Banco de Dados', 7.0)),
						  ('3','José', Row(10, 'Banco de Dados', 8.0)),
						  ('5','Pedro', Row(11, 'Metodologia Científica', 9.0)),
						  ('6','Patricia', Row(10, 'Banco de Dados', 8.0)),
						  ('7','João', Row(10, 'PAA', 9.0));

insert into alunos values ('99','Angélica', Row(1, 'Banco de Dados Avançados', 10.0));



create type tipo_cidade as (
codigo numeric,
nome varchar (45),
cep varchar (14),
estado varchar (2)
);

create type tipo_endereco as (
rua varchar (45),
bairro varchar (45),
numero numeric,
cidade tipo_cidade
);