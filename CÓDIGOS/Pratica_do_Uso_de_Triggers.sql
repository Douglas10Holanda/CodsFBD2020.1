-- Prática do Uso de Triggers

-- 1 - Crie a tabela empregados

CREATE TABLE empregados(
  codigo int4 NOT NULL,
  nome VARCHAR,
  salario int4,
  departamento_cod int4,
  ultima_data TIMESTAMP,
  ultimo_usuario VARCHAR(50),
  CONSTRAINT empregados_pkey PRIMARY KEY (codigo) ) 
 
-- 2 - Crie uma função do trigger

  CREATE FUNCTION empregados_gatilho() RETURNS TRIGGER AS $empregados_gatilho$
    BEGIN
        -- Verificar se foi fornecido o nome e o salário do empregado
        IF NEW.nome IS NULL THEN
            RAISE EXCEPTION 'O nome do empregado não pode ser nulo';
        END IF;
        IF NEW.salario IS NULL THEN
            RAISE EXCEPTION '% não pode ter um salário nulo', NEW.nome;
        END IF;
        --  
        -- Quem paga para trabalhar?
        --      
        IF NEW.salario < 0 THEN
            RAISE EXCEPTION '% não pode ter um salário negativo', NEW.nome;
        END IF;
        --  
        --
        -- Registrar quem alterou a folha de pagamento e quando
        --
        NEW.ultima_data := 'now';
        NEW.ultimo_usuario := CURRENT_USER;
        RETURN NEW;
    END;
  $empregados_gatilho$ LANGUAGE plpgsql;
 
-- 3 - Crie o trigger que vai executar a função empregados_gatilho
 
  CREATE TRIGGER empregados_gatilho BEFORE INSERT OR UPDATE ON empregados
    FOR EACH ROW EXECUTE PROCEDURE empregados_gatilho();
 
-- 4 - Atualização da tabela empregados 

INSERT INTO empregados (codigo,nome, salario) VALUES (5,'João',1000);
INSERT INTO empregados (codigo,nome, salario) VALUES (6,'José',1500);
INSERT INTO empregados (codigo,nome, salario) VALUES (7,'Maria',2500);
SELECT * FROM empregados;
INSERT INTO empregados (codigo,nome, salario) VALUES (5,NULL,1000);
NEW – Para INSERT e UPDATE
OLD – Para DELETE

-- 5 - Crie outra versão da tabela empregados 

 DROP TABLE empregados;
 
  CREATE TABLE empregados (
    nome  VARCHAR NOT NULL,
    salario     INTEGER
  );
 
  CREATE TABLE empregados_audit(
    operacao    CHAR(1)   NOT NULL,
    usuario     VARCHAR      NOT NULL,
    DATA        TIMESTAMP NOT NULL,
    nome    VARCHAR      NOT NULL,
    salario     INTEGER
  );
 
-- 6 - Crie a função para auditoria que será chamada pelo trigger

  CREATE OR REPLACE FUNCTION processa_emp_audit() RETURNS TRIGGER AS $emp_audit$
    BEGIN
        --
        -- Cria uma linha na tabela emp_audit para refletir a operação
        -- realizada na tabela emp. Utiliza a variável especial TG_OP
        -- para descobrir a operação sendo realizada.
        --
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO empregados_audit SELECT 'E', USER, now(), OLD.nome, OLD.salario;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO empregados_audit SELECT 'A', USER, now(), NEW.nome, NEW.salario;
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO empregados_audit SELECT 'I', USER, now(), NEW.nome, NEW.salario;
            RETURN NEW;
        END IF;
        RETURN NULL; -- o resultado é ignorado uma vez que este é um gatilho AFTER
    END;
    $emp_audit$ LANGUAGE plpgsql;

-- 7 - Crie o trigger para auditoria
 
CREATE TRIGGER emp_audit
  AFTER INSERT OR UPDATE OR DELETE ON empregados
    FOR EACH ROW EXECUTE PROCEDURE processa_emp_audit();
 
-- 8 - Atualize a nova tabela empregados 

DELETE FROM empregados; 
INSERT INTO empregados (nome, salario) VALUES ('João',1000);
INSERT INTO empregados (nome, salario) VALUES ('José',1500);
INSERT INTO empregados (nome, salario) VALUES ('Maria',250);
UPDATE empregados SET salario = 2500 WHERE nome = 'Maria';
DELETE FROM empregados WHERE nome = 'João';
SELECT * FROM empregados;
SELECT * FROM empregados_audit;

-- 9 - Crie a outra versão da tabela empregados

-- Outro exemplo:

DROP TABLE empregados;
  CREATE TABLE empregados (
    codigo          serial  PRIMARY KEY,
    nome    VARCHAR    NOT NULL,
    salario     INTEGER
  );
 
 DROP TABLE empregados_audit;
  CREATE TABLE empregados_audit(
    usuario         VARCHAR      NOT NULL,
    DATA            TIMESTAMP NOT NULL,
    id              INTEGER   NOT NULL,
    coluna          text      NOT NULL,
    valor_antigo    text      NOT NULL,
    valor_novo      text      NOT NULL
  );
 
 
--10 - Crie uma função para auditoria que será chamada pelo trigger

  CREATE OR REPLACE FUNCTION processa_emp_audit() RETURNS TRIGGER AS $emp_audit$
    BEGIN
        --
        -- Não permitir atualizar a chave primária
        --
        IF (NEW.codigo <> OLD.codigo) THEN
            RAISE EXCEPTION 'Não é permitido atualizar o campo codigo';
        END IF;
        --
        -- Inserir linhas na tabela emp_audit para refletir as alterações
        -- realizada na tabela emp.
        --
        IF (NEW.nome <> OLD.nome) THEN
           INSERT INTO empregados_audit SELECT CURRENT_USER, CURRENT_TIMESTAMP,
                       NEW.codigo, 'nome', OLD.nome, NEW.nome;
        END IF;
        IF (NEW.salario <> OLD.salario) THEN
           INSERT INTO empregados_audit SELECT CURRENT_USER, CURRENT_TIMESTAMP,
                       NEW.codigo, 'salario', OLD.salario, NEW.salario;
        END IF;
        RETURN NULL; -- o resultado é ignorado uma vez que este é um gatilho AFTER
    END;
  $emp_audit$ LANGUAGE plpgsql;
 
-- 11 - Crie o trigger para a tabela empregados. O trigger deve chamar o processa_emp_audit() 
 
  CREATE TRIGGER emp_audit
  AFTER UPDATE ON empregados
  FOR EACH ROW EXECUTE PROCEDURE processa_emp_audit();
 
 
 
INSERT INTO empregados (nome, salario) VALUES ('João',1000);
INSERT INTO empregados (nome, salario) VALUES ('José',1500);
INSERT INTO empregados (nome, salario) VALUES ('Maria',2500);
UPDATE empregados SET salario = 2500 WHERE codigo= 2;

UPDATE empregados SET nome = 'Maria Cecília' WHERE codigo = 3;
UPDATE empregados SET codigo=100 WHERE codigo=1;

-- ERRO:  Não é permitido atualizar o campo codigo

SELECT * FROM empregados;
SELECT * FROM empregados_audit;