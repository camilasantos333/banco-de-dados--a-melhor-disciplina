SELECT titulo FROM livros;

SELECT nome, nascimento FROM autores WHERE YEAR(nascimento) < 1900;

SELECT l.titulo
FROM livros l
JOIN autores a ON l.autor_id = a.id
WHERE a.nome = 'J.K. Rowling';

SELECT alunos.nome
FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id
WHERE matriculas.curso = 'Engenharia de Software';

SELECT produto, SUM(receita) as receita_total
FROM vendas
GROUP BY produto;

SELECT a.nome, COUNT(l.id) as numero_livros
FROM autores a
LEFT JOIN livros l ON a.id = l.autor_id
GROUP BY a.nome;

SELECT curso, COUNT(*) as numero_alunos
FROM matriculas
GROUP BY curso;

SELECT produto, AVG(receita) as media_receita
FROM vendas
GROUP BY produto;

SELECT produto, SUM(receita) as receita_total
FROM vendas
GROUP BY produto
HAVING receita_total > 10000;

SELECT a.nome, COUNT(l.id) as numero_livros
FROM autores a
LEFT JOIN livros l ON a.id = l.autor_id
GROUP BY a.nome
HAVING numero_livros > 2;

SELECT l.titulo, a.nome
FROM livros l
JOIN autores a ON l.autor_id = a.id;

SELECT alunos.nome, matriculas.curso
FROM alunos
LEFT JOIN matriculas ON alunos.id = matriculas.aluno_id;

SELECT a.nome, l.titulo
FROM autores a
LEFT JOIN livros l ON a.id = l.autor_id;

SELECT alunos.nome, matriculas.curso
FROM matriculas
RIGHT JOIN alunos ON matriculas.aluno_id = alunos.id;

SELECT alunos.nome, matriculas.curso
FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id;

SELECT a.nome, COUNT(l.id) as numero_livros
FROM autores a
LEFT JOIN livros l ON a.id = l.autor_id
GROUP BY a.nome
ORDER BY numero_livros DESC
LIMIT 1;

SELECT produto, SUM(receita) as receita_total
FROM vendas
GROUP BY produto
ORDER BY receita_total ASC
LIMIT 1;

SELECT alunos.nome, COUNT(matriculas.curso) as numero_matriculas
FROM alunos
LEFT JOIN matriculas ON alunos.id = matriculas.aluno_id
GROUP BY alunos.nome;

SELECT produto, COUNT(*) as quantidade_transacoes
FROM vendas
GROUP BY produto
ORDER BY quantidade_transacoes DESC
LIMIT 1;
