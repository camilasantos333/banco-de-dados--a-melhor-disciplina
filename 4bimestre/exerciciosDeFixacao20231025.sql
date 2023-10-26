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
