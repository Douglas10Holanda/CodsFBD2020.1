CREATE KEYSPACE IF NOT EXISTS ufersa
WITH replication = {
	'class' : 'SimpleStrategy',
	'replication_factor' : 3
};

CREATE TABLE IF NOT EXISTS ufersa.turma (
  id uuid PRIMARY KEY,
  nome text,
  endereco text,
  telefone text,
  curso text,

  );
  
 
  INSERT INTO ufersa.turma (id, nome, endereco, telefone, curso)
  VALUES (a3e64f8f-bd44-4f28-b8d9-6938726e34d4, 'Adriano','Rua Maria','9999-9999','Ciência da Computação');
 INSERT INTO ufersa.turma (id,nome, endereco, telefone, curso)
  VALUES (62c36092-82a1-3a00-93d1-46196ee77204,'Igor','Rua X','8888-9999','Ciência da Computação');
   INSERT INTO ufersa.turma (id, nome, endereco, telefone, curso)
  VALUES (62c36092-82a1-3a00-93d1-46196ee77204, 'Angélica','Centro','1111-9999','Ciência da Computação');
 INSERT INTO ufersa.turma (id,nome, endereco, telefone, curso)
  VALUES (8a172618-b121-4136-bb10-f665cfc469eb,'João','Rua Sem Saída','8888-0000','Contabilidade');

  CREATE INDEX ON ufersa.turma( curso );

  SELECT id,nome, telefone FROM ufersa.turma WHERE curso = 'Contabilidade';

  DELETE FROM ufersa.turma WHERE id = 8a172618-b121-4136-bb10-f665cfc469eb;