DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;
END //
DELIMITER ;
CALL sp_ListarAutores();
DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN categoria_nome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo, Autor.Nome, Autor.Sobrenome
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    INNER JOIN Autor_Livro ON Livro.Livro_ID = Autor_Livro.Livro_ID
    INNER JOIN Autor ON Autor_Livro.Autor_ID = Autor.Autor_ID
    WHERE Categoria.Nome = categoria_nome;
END //
DELIMITER ;
CALL sp_LivrosPorCategoria('Ficção Científica');
DELIMITER //
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoria_nome VARCHAR(100), OUT total_livros INT)
BEGIN
    SELECT COUNT(*) INTO total_livros
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoria_nome;
END //
DELIMITER ;
SET @resultado = 0;
CALL sp_ContarLivrosPorCategoria('Ficçao Científica', @resultado);
SELECT @resultado;
DELIMITER //
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoria_nome VARCHAR(100), OUT possui_Livros BOOLEAN)
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoria_nome;
    IF total > 0 THEN
        SET possui_livros = TRUE;
    ELSE
        SET possui_livros = FALSE;
    END IF;
END //
DELIMITER ;
CALL sp_VerificarLivrosCategoria('Ficcão Científica', @resultado);
SELECT @resultado;
DELIMITER //
CREATE PROCEDURE sp_LivrosAteAno(IN ano_limite INT)
BEGIN
    SELECT Titulo, Ano_Publicacao
    FROM Livro
    WHERE Ano_Publicacao <= ano_limite;
END //
DELIMITER ;
CALL sp_LivrosAteAno(2012);
DELIMITER //
CREATE PROCEDURE sp_TitulosPorCategoria(IN categoria_nome VARCHAR(100))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE livro_titulo VARCHAR(255);
    DECLARE cur CURSOR FOR
        SELECT Livro.Titulo
        FROM Livro
        INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
        WHERE Categoria.Nome = categoria_nome;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    FETCH cur INTO livro_titulo;
    WHILE NOT done DO
        SELECT livro_titulo AS 'Título do Livro';
        FETCH cur INTO livro_titulo;
    END WHILE;
    CLOSE cur;
END //
DELIMITER ;
CALL sp_TitulosPorCategoria('Ficção Científica');
DELIMITER //
CREATE PROCEDURE sp_AdicionarLivro(
    IN titulo_livro VARCHAR(255),
    IN editora_id INT,
    IN ano_publicacao INT,
    IN numero_paginas INT,
    IN categoria_id INT,
    OUT mensagem VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET mensagem = 'Erro. O livro já existe';
    END;
    INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
    VALUES (titulo_livro, editora_id, ano_publicacao, numero_paginas, categoria_id);
    SET mensagem = 'Novo livro adicionado.';
END //
DELIMITER ;
CALL sp_AdicionarLivro('A Mente Poderosa', 2, 2020, 280, 5, @mensagem);
SELECT @mensagem;
CALL sp_AdicionarLivro('New book', 2, 2022, 300, 2, @mensagem);
SELECT @mensagem;
DELIMITER //
CREATE PROCEDURE sp_AutorMaisAntigo(OUT nome_autor VARCHAR(255))
BEGIN
    SELECT CONCAT(Nome, ' ', Sobrenome) INTO nome_autor
    FROM Autor
    WHERE Data_Nascimento = (SELECT MIN(Data_Nascimento) FROM Autor);
END //
DELIMITER ;
CALL sp_AutorMaisAntigo(@nome_autor);
SELECT @nome_autor;

DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE titulo VARCHAR(255);

    DECLARE cur CURSOR FOR
    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO titulo;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT titulo;
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;
-- Nesta stored procedure:

-- Declaramos um cursor chamado cur para percorrer os resultados da consulta.
-- Usamos um cursor para selecionar os títulos dos livros de uma categoria específica, que é passada como um parâmetro de entrada para a procedure.
-- Definimos um manipulador para tratar a condição "NOT FOUND", que é acionada quando não há mais registros para recuperar do cursor.
-- Abrimos o cursor para iniciar a iteração pelos resultados.
-- Iniciamos um loop (read_loop) para percorrer os registros retornados pelo cursor.
-- Dentro do loop, tentamos buscar um título do cursor e verificamos se todos os registros foram lidos. Se todos os registros foram lidos, saímos do loop.
-- Se um título foi recuperado com sucesso, selecionamos o título na saída da procedure.
-- Finalmente, fechamos o cursor para liberar recursos.
-- Esses comentários explicam o funcionamento da procedure, destacando as principais etapas e decisões tomadas durante a sua execução. Isso torna mais fácil para outros desenvolvedores entenderem e trabalharem com a stored procedure sp_LivrosPorCategoria.
