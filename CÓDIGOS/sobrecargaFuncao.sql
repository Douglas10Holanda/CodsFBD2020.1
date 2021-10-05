
-- Somar dois números inteiros. 
--Esta função recebe como argumentos dois números inteiros, 
--e retorna como resultado a soma dos dois números recebidos.
CREATE FUNCTION somar_inteiros(integer, integer) RETURNS integer
    AS 'select $1 + $2;'
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT;

SELECT somar_inteiros(2,3);


-- Incrementar um inteiro. 
--Incrementar um inteiro, fazendo uso do nome do argumento, no PL/pgSQL:
CREATE OR REPLACE FUNCTION incrementar(i integer) RETURNS integer AS $$
    BEGIN
        RETURN i + 1;
    END;
$$ LANGUAGE plpgsql;

SELECT incrementar(10);

-- Retornar um resultado tipo linha usando parâmetros de saída. Esta função recebe como argumento um número inteiro, e retorna uma linha contendo o número inteiro recebido e uma cadeia de caracteres contendo o número inteiro recebido concatenado com uma constante cadeia de caracteres.
CREATE FUNCTION dup(in int, out f1 int, out f2 text)
    AS $$ SELECT $1, CAST($1 AS text) || ' como texto' $$
    LANGUAGE SQL;

    SELECT * FROM dup(42);

 -- Retornar um resultado tipo linha usando um tipo composto. Esta função é semelhante à função anterior, porém ao invés de utilizar parâmetros de saída utiliza um tipo de dado composto previamente definido para retornar os valores.
 CREATE TYPE dup_resultado AS (f1 int, f2 text);

CREATE FUNCTION dup(int) RETURNS dup_resultado
    AS $$ SELECT $1, CAST($1 AS text) || ' como texto' $$
    LANGUAGE SQL;

SELECT * FROM dup(42);

--Somar dias a uma data. A seguir está mostrada uma função sobrecarregada para somar dias a data. Pode ser utilizada com os tipos de dado date, timestamp e timestamp with time zone.
CREATE OR REPLACE FUNCTION somar_dias(data date, dias integer)
RETURNS date AS $$
BEGIN
   RETURN data + CAST(dias || ' DAYS' AS interval);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION somar_dias(data timestamp, dias integer)
RETURNS timestamp AS $$
BEGIN
   RETURN data + CAST(dias || ' DAYS' AS interval);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION somar_dias(data timestamp with time zone, dias integer)
RETURNS timestamp with time zone AS $$
BEGIN
   RETURN data + CAST(dias || ' DAYS' AS interval);
END;
$$ LANGUAGE plpgsql;

SELECT somar_dias(date '2020-06-05', 30);
SELECT somar_dias(timestamp '2020-07-16 15:00:00', 30);

