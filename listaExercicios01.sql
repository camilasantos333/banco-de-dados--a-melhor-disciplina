SELECT titulo FROM livros;

SELECT nome, nascimento FROM autores WHERE YEAR(nascimento) < 1900;

SELECT l.titulo
FROM livros l
JOIN autores a ON l.autor_id = a.id
WHERE a.nome = 'J.K. Rowling';
