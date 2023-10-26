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
