--1
DELIMITER //
CREATE FUNCTION total_livros_por_genero(nome_genero VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE total_count INT;
    SELECT COUNT(*) INTO total_count
    FROM Livro L
    INNER JOIN Genero G ON L.id_genero = G.id
    WHERE G.nome_genero = nome_genero;
    RETURN total_count;
END;
//
DELIMITER ;
--2
DELIMITER //
CREATE FUNCTION listar_livros_por_autor(primeiro_nome VARCHAR(255), ultimo_nome VARCHAR(255))
RETURNS TEXT
BEGIN
    DECLARE lista_livros TEXT;
    SET lista_livros = '';
    SELECT GROUP_CONCAT(L.titulo) INTO lista_livros
    FROM Livro_Autor LA
    INNER JOIN Livro L ON LA.id_livro = L.id
    INNER JOIN Autor A ON LA.id_autor = A.id
    WHERE A.primeiro_nome = primeiro_nome AND A.ultimo_nome = ultimo_nome;

    RETURN lista_livros;
END;
//
DELIMITER ;
-- 3
DELIMITER //
CREATE FUNCTION atualizar_resumos()
RETURNS INT
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE livro_id INT;
    DECLARE cur CURSOR FOR
    SELECT id
    FROM Livro;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    update_loop: LOOP
        FETCH cur INTO livro_id;
        IF done = 1 THEN
            LEAVE update_loop;
        END IF;
        UPDATE Livro
        SET resumo = CONCAT(resumo, ' Este é um excelente livro!')
        WHERE id = livro_id;
    END LOOP;
    CLOSE cur;
    RETURN 1;
END;
//
DELIMITER ;
-- 4
DELIMITER //
CREATE FUNCTION media_livros_por_editora()
RETURNS DECIMAL(5,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE media DECIMAL(5,2);
    SELECT AVG(editora_count) INTO media
    FROM (SELECT id_editora, COUNT(*) AS editora_count
          FROM Livro
          GROUP BY id_editora) AS temp;
    RETURN media;
END;
//
DELIMITER ;
-- 5 
DELIMITER //
CREATE FUNCTION autores_sem_livros()
RETURNS TEXT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE lista_autores_sem_livros TEXT;
    SET lista_autores_sem_livros = '';
    SELECT GROUP_CONCAT(CONCAT(primeiro_nome, ' ', ultimo_nome)) INTO lista_autores_sem_livros
    FROM Autor
    WHERE id NOT IN (SELECT DISTINCT id_autor FROM Livro_Autor);
    RETURN lista_autores_sem_livros;
END;
//
DELIMITER ;
