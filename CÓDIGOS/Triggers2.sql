-- CLIENTE
CREATE TABLE IF NOT EXISTS tb_cliente
(
    id BIGINT,
    nome TEXT
);

-- MOVIMENTACAO
CREATE TABLE IF NOT EXISTS tb_movimentacao
(
    id BIGINT,
    id_cliente BIGINT,
    tipo VARCHAR(1),
    valor REAL
);

-- MOVIMENTACAO
CREATE TABLE IF NOT EXISTS tb_saldo
(

    id_cliente BIGINT,
    valor REAL
);


-- Criação da Trigger Function

CREATE OR REPLACE FUNCTION fc_atualizar_saldo()
  RETURNS trigger AS $BODY$
DECLARE
    n REAL DEFAULT 0;
BEGIN
    IF( NEW.tipo = 'D' ) THEN
        n = NEW.valor * (-1);
    ELSIF( NEW.tipo = 'C' ) THEN 
        n = NEW.valor;
    END IF;

    IF NOT EXISTS( SELECT 1 FROM tb_saldo WHERE id_cliente = NEW.id_cliente ) THEN
        INSERT INTO tb_saldo ( id_cliente, valor ) VALUES (  NEW.id_cliente, n );
    ELSE
        UPDATE tb_saldo SET valor = valor + n WHERE id_cliente = NEW.id_cliente;
    END IF;

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

--Criação da Trigger:
CREATE TRIGGER trg_atualizar_saldo AFTER INSERT OR UPDATE ON tb_movimentacao 
FOR EACH ROW EXECUTE PROCEDURE fc_atualizar_saldo();

-- Cadastro Clientes:
INSERT INTO tb_cliente ( id, nome ) VALUES ( 1, 'ADRIANO' );
INSERT INTO tb_cliente ( id, nome ) VALUES ( 2, 'FABIANY' );
INSERT INTO tb_cliente ( id, nome ) VALUES ( 3, 'LUCAS ROBSON' );
INSERT INTO tb_cliente ( id, nome ) VALUES ( 4, 'DAVI TEIXEIRA' );
INSERT INTO tb_cliente ( id, nome ) VALUES ( 5, 'MARIANA' );

-- Recupera o Saldo de todos os Clientes cadastrados antes das Movimentações:
SELECT 
    c.id,
    c.nome,
    COALESCE( s.valor, 0.0 ) AS saldo
FROM
    tb_cliente c
LEFT JOIN
    tb_saldo AS s ON ( s.id_cliente = c.id );

 -- Simula movimentações do Cliente "ADRIANO":
 INSERT INTO tb_movimentacao ( id, id_cliente, tipo, valor ) VALUES ( 1, 1, 'C', 1000.00 ); -- Saldo: +1000.00
INSERT INTO tb_movimentacao ( id, id_cliente, tipo, valor ) VALUES ( 2, 1, 'D', 10.75 ); -- Saldo: +989.25
INSERT INTO tb_movimentacao ( id, id_cliente, tipo, valor ) VALUES ( 3, 1, 'D', 22.50 ); -- Saldo: +966.75
INSERT INTO tb_movimentacao ( id, id_cliente, tipo, valor ) VALUES ( 4, 1, 'C', 100.00 ); -- Saldo: +1066.75
INSERT INTO tb_movimentacao ( id, id_cliente, tipo, valor ) VALUES ( 5, 1, 'D', 1000.00 ); -- Saldo: +66.75

-- Simula movimentações da Cliente "FABIANY"
INSERT INTO tb_movimentacao ( id, id_cliente, tipo, valor ) VALUES ( 1, 2, 'C', 1000.00 ); -- Saldo: +1000.00
INSERT INTO tb_movimentacao ( id, id_cliente, tipo, valor ) VALUES ( 2, 2, 'C', 200.00 ); -- Saldo: +1200.00
INSERT INTO tb_movimentacao ( id, id_cliente, tipo, valor ) VALUES ( 3, 2, 'D', 500.00 ); -- Saldo: +700.00
INSERT INTO tb_movimentacao ( id, id_cliente, tipo, valor ) VALUES ( 4, 2, 'D', 100.00 ); -- Saldo: +600;00
INSERT INTO tb_movimentacao ( id, id_cliente, tipo, valor ) VALUES ( 5, 2, 'D', 10.00 ); -- Saldo: +590.00

-- Recupera o Saldo de todos os Clientes cadastrados DEPOIS das Movimentações:
SELECT 
    c.id,
    c.nome,
    COALESCE( s.valor, 0.0 ) AS saldo
FROM
    tb_cliente c
LEFT JOIN
    tb_saldo AS s ON ( s.id_cliente = c.id );

    
