DELIMITER //
CREATE TRIGGER inserir_cliente_
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem) 
    VALUES (CONCAT('Novo cliente dia', NOW()));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER exclusao_cliente
BEFORE DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem) 
    VALUES (CONCAT('Tentou excluir um cliente, ', OLD.nome, ', dia ', NOW()));
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER atualiza_cliente
BEFORE UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF NEW.nome IS NULL OR NEW.nome = '' THEN
        INSERT INTO Auditoria (mensagem) 
        VALUES (CONCAT('Nome', OLD.nome, ' atualizado para ', NEW.nome, ', dia ', NOW()));
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER decrementa_estoque
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;
    
    IF (SELECT estoque FROM Produtos WHERE id = NEW.produto_id) < 5 THEN
        INSERT INTO Auditoria (mensagem) 
        VALUES (CONCAT('O estoque do produto', (SELECT nome FROM Produtos WHERE id = NEW.produto_id), ' está abaixo de 5 unidades, dia ', NOW()));
    END IF;
END;
//
DELIMITER ;
