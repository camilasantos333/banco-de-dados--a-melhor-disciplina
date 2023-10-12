-- 1
CREATE TABLE nomes (
    nome VARCHAR(255)
);
INSERT INTO nomes (nome) 
VALUES ('Roberta'), 
    ('Roberto'), 
    ('Maria Clara'), 
    ('João');
       
SELECT UPPER(nome)
FROM nomes;

SELECT nome, 
LENGTH(nome) as total_letras FROM nomes;

SELECT 
    CASE 
        WHEN nome LIKE 'Roberto' OR nome LIKE 'João' THEN CONCAT('Sr. ', nome)
        ELSE CONCAT('Sra. ', nome)
    END AS fem_masc
FROM nomes;

-- 2
CREATE TABLE produtos (
    produto VARCHAR(255),
    preco DECIMAL(10, 2),
    quantidade INT
);

SELECT produto,
ROUND(preco, 2) as val_arredondado FROM produtos;

SELECT produto,
ABS(quantidade) as qtd_absoluta FROM produtos;

SELECT AVG(preco) as media_preco FROM produtos;

-- 3
CREATE TABLE eventos (
    data_evento DATE
);

INSERT INTO eventos (data_evento)
VALUES
    ('2017-10-20'),
    ('2023-04-18'),
    ('2023-12-25');
    
INSERT INTO eventos (data_evento)
VALUES (NOW());

SELECT DATEDIFF('2023-04-18', '2023-12-25') as qtdEntre_datas;

SELECT data_evento, 
DAYNAME(data_evento) as dia_da_semana FROM eventos;

-- 4
SELECT produto,
    IF(quantidade > 0, 'Em estoque', 'Fora de estoque') as estoque
FROM produtos;

SELECT produto,
    CASE 
        WHEN preco < 10 THEN 'Barato'
        WHEN preco >= 10 AND preco < 50 THEN 'Médio'
        ELSE 'Caro'
    END AS categoria
FROM produtos;

-- 5
DELIMITER //
CREATE FUNCTION TOTAL_VALOR(preco DECIMAL(10, 2), quantidade INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN preco * quantidade;
END;
//
DELIMITER ;

SELECT produto, 
TOTAL_VALOR(preco, quantidade) as val_total FROM produtos;

-- 6
SELECT COUNT(*) as total_de_prod FROM produtos;

SELECT produto, MAX(preco) AS prod_mais_caro
FROM produtos
GROUP BY produto;

SELECT produto, MIN(preco) AS prod_mais_barato
FROM produtos
GROUP BY produto;

SELECT SUM(IF(quantidade > 0, preco, 0)) as total_estoque FROM produtos;

-- 7 
DELIMITER //
CREATE FUNCTION fatorial(n INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE resultado INT DEFAULT 1;
    WHILE n > 0 DO
        SET resultado = resultado * n;
        SET n = n - 1;
    END WHILE;
    RETURN resultado;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION calculaExpoente(base INT, expoente INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE resultado INT DEFAULT 1;
    DECLARE i INT;
    
    SET i = 1;
    
    WHILE i <= expoente DO
        SET resultado = resultado * base;
        SET i = i + 1;
    END WHILE;
    
    RETURN resultado;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION verifica(palavra VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE reverso VARCHAR(255);
    
    SET reverso = REVERSE(palavra);
    
    IF palavra = reverso THEN
        RETURN 1; 
    ELSE
        RETURN 0;
    END IF;
END;
//
DELIMITER ;
