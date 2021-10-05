/* Respostas Atividade - Clínica Boa Saúde */
﻿
create table paciente (cod_pac int, nome varchar(30), endereço varchar(50), telefone int,
constraint paciente_pkey primary key (cod_pac));
create table medico (crm integer, nome varchar(30), endereco varchar(50), telefone int,
especialidade varchar(30), constraint medico_pkey primary key (crm));
create table convenio (codconv int, nome varchar(30), constraint convenio_pkey primary
key (codconv));
create table consulta (codconsulta int, dataa varchar(10), horario varchar(5), medico int, paciente int,
convenio int, porcent int, constraint consulta_pkey primary key (codconsulta),
constraint medico_fkey foreign key (medico) references medico (crm), 
constraint paciente_fkey foreign key (paciente) references paciente (cod_pac), 
constraint convenio_fkey foreign key (convenio) references convenio (codconv));
create table atende (medico int, convenio int, primary key (medico, convenio),
constraint atende_fkey foreign key (medico) references medico (crm),
constraint atende_fkey2 foreign key (convenio) references convenio (codconv));
create table possui (paciente int, convenio int, tipo varchar(40), vencimento varchar(10),
primary key (paciente, convenio),
constraint atende_fkey1 foreign key (paciente) references paciente (cod_pac),
constraint atende_fkey2 foreign key (convenio) references convenio (codconv));


insert into paciente (cod_pac, nome, endereço, telefone) values (1, 'João', 'Rua 1', 98099756);
insert into paciente (cod_pac, nome, endereço, telefone) values (2, 'José', 'Rua B', 36218978);
insert into paciente (cod_pac, nome, endereço, telefone) values (3, 'Maria', 'Rua 10', 45679872);
insert into paciente (cod_pac, nome, endereço, telefone) values (4, 'Joana', 'Rua J', 33439889);

insert into medico (crm, nome, endereco, telefone, especialidade) values (18739, 'Elias',
'Rua X', 87381221, 'Pediatria');
insert into medico (crm, nome, endereco, telefone, especialidade) values (7646, 'Ana',
'Av Z', 78291233, 'Obstetricia');
insert into medico (crm, nome, endereco, telefone, especialidade) values (39872, 'Pedro',
'Tv H', 98882333, 'Oftalmologia');

insert into convenio (codconv, nome) values (189, 'Cassi');
insert into convenio (codconv, nome) values (232, 'Unimed');
insert into convenio (codconv, nome) values (454, 'Santa Casa');
insert into convenio (codconv, nome) values (908, 'Copasa');
insert into convenio (codconv, nome) values (435, 'São Lucas');

insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (1, '10/05/2013', '10:00', 18739, 1, 189, 5);
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (2, '12/05/2013', '10:00', 7646, 2, 232, 10);
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (3, '12/05/2013', '11:00', 18739, 3, 908, 15);
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (4, '13/05/2013', '10:00', 7646, 4, 435, 13);
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (5, '14/05/2013', '13:00', 7646, 2, 232, 10);
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (6, '14/05/2013', '14:00', 39872, 1, 189, 5);

insert into atende (medico, convenio) values (18739, 189);
insert into atende (medico, convenio) values (18739, 908);
insert into atende (medico, convenio) values (7646, 232);
insert into atende (medico, convenio) values (39872, 189);

insert into possui (paciente, convenio, tipo, vencimento) values (1, 189, 'E', '31/12/2016');
insert into possui (paciente, convenio, tipo, vencimento) values (2, 232, 'S', '31/12/2014');
insert into possui (paciente, convenio, tipo, vencimento) values (3, 908, 'S', '31/12/2017');
insert into possui (paciente, convenio, tipo, vencimento) values (4, 435, 'E', '31/12/2016');
insert into possui (paciente, convenio, tipo, vencimento) values (1, 232, 'S', '31/12/2015');

/* Respostas Atividade - Clínica Boa Saúde */

/* CRIANDO A TABELA PACIENTE */
create table if not exists paciente  (
	cod_pac int, 
	nome varchar(30), 
	endereço varchar(50), 
	telefone int,
	constraint paciente_pkey primary key (cod_pac));
	
/* CRIANDO A TABELA MÉDICO */
create table if not exists medico  (
	crm integer, nome varchar(30), 
	endereco varchar(50), 
	telefone int,
	especialidade varchar(30), 
	constraint medico_pkey primary key (crm));

/* CRIANDO A TABELA CONVÊNIO */
create table if not exists convenio (
	codconv int, 
	nome varchar(30), 
	constraint convenio_pkey primary key (codconv));

/* CRIANDO A TABELA CONSULTA */
create table if not exists consulta  (
	codconsulta int, 
	dataa varchar(10), 
	horario varchar(5), 
	medico int, 
	paciente int,
	convenio int, 
	porcent int, 
	constraint consulta_pkey primary key (codconsulta),
	constraint medico_fkey foreign key (medico) references medico (crm), 
	constraint paciente_fkey foreign key (paciente) references paciente (cod_pac), 
	constraint convenio_fkey foreign key (convenio) references convenio (codconv));

/* CRIANDO A TABELA ATENDE */
create table if not exists atende (
	medico int, 
	convenio int, 
	primary key (medico, convenio),
	constraint atende_fkey foreign key (medico) references medico (crm),
	constraint atende_fkey2 foreign key (convenio) references convenio (codconv));

/* CRIANDO A TABELA POSSUI */
create table if not exists possui (
	paciente int, 
	convenio int, 
	tipo varchar(40), 
	vencimento varchar(10),
	primary key (paciente, convenio),
	constraint atende_fkey1 foreign key (paciente) references paciente (cod_pac),
	constraint atende_fkey2 foreign key (convenio) references convenio (codconv));

/* INSERINDO DADOS  NA TABELA PACIENTE */
insert into paciente (cod_pac, nome, endereço, telefone) values ( 'João', 'Rua 1', 98099756);
insert into paciente (cod_pac, nome, endereço, telefone) values (2, 'José', 'Rua B', 36218978);
insert into paciente (cod_pac, nome, endereço, telefone) values (3, 'Maria', 'Rua 10', 45679872);
insert into paciente (cod_pac, nome, endereço, telefone) values (4, 'Joana', 'Rua J', 33439889);

/* INSERINDO DADOS  NA TABELA MÉDICO */
insert into medico (crm, nome, endereco, telefone, especialidade) values (18739, 'Elias',
'Rua X', 87381221, 'Pediatria');
insert into medico (crm, nome, endereco, telefone, especialidade) values (7646, 'Ana',
'Av Z', 78291233, 'Obstetricia');
insert into medico (crm, nome, endereco, telefone, especialidade) values (39872, 'Pedro',
'Tv H', 98882333, 'Oftalmologia');

/* INSERINDO DADOS  NA TABELA CONVÊNIO */
insert into convenio (codconv, nome) values (189, 'Cassi');
insert into convenio (codconv, nome) values (232, 'Unimed');
insert into convenio (codconv, nome) values (454, 'Santa Casa');
insert into convenio (codconv, nome) values (908, 'Copasa');
insert into convenio (codconv, nome) values (435, 'São Lucas');

/* INSERINDO DADOS  NA TABELA CONSULTA */
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (1, '10/05/2013', '10:00', 18739, 1, 189, 5);
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (2, '12/05/2013', '10:00', 7646, 2, 232, 10);
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (3, '12/05/2013', '11:00', 18739, 3, 908, 15);
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (4, '13/05/2013', '10:00', 7646, 4, 435, 13);
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (5, '14/05/2013', '13:00', 7646, 2, 232, 10);
insert into consulta (codconsulta, dataa, horario, medico, paciente, convenio, porcent) 
values (6, '14/05/2013', '14:00', 39872, 1, 189, 5);

/* INSERINDO DADOS  NA TABELA ATENDE */
insert into atende (medico, convenio) values (18739, 189);
insert into atende (medico, convenio) values (18739, 908);
insert into atende (medico, convenio) values (7646, 232);
insert into atende (medico, convenio) values (39872, 189);

/* INSERINDO DADOS  NA TABELA POSSUI */
insert into possui (paciente, convenio, tipo, vencimento) values (1, 189, 'E', '31/12/2016');
insert into possui (paciente, convenio, tipo, vencimento) values (2, 232, 'S', '31/12/2014');
insert into possui (paciente, convenio, tipo, vencimento) values (3, 908, 'S', '31/12/2017');
insert into possui (paciente, convenio, tipo, vencimento) values (4, 435, 'E', '31/12/2016');
insert into possui (paciente, convenio, tipo, vencimento) values (1, 232, 'S', '31/12/2015');

/*----------------------------------Questão 01--------------------------------*/
update paciente set endereço = 'Rua do Bonde' where nome = 'João';
/*----------------------------------Questão 02--------------------------------*/
update medico set endereco = 'RUa Z', telefone = 98387867 where nome = 'Elias';
/*----------------------------------Questão 03--------------------------------*/
update possui set tipo = 'S';
/*----------------------------------Questão 04--------------------------------*/
delete from possui where paciente = 2 and convenio = 232;
/*----------------------------------Questão 05--------------------------------*/
delete from consulta where dataa = '14/05/2013' and horario = '14:00';
/*----------------------------------Questão 06--------------------------------*/
alter table medico rename column especialidade to especializacao;
/*----------------------------------Questão 07--------------------------------*/
alter table convenio alter column nome type varchar(200);
/*----------------------------------Questão 08--------------------------------*/
alter table consulta add valor float;
update consulta set valor = 100.00;















