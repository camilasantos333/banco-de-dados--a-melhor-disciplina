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
