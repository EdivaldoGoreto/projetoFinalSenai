DROP FUNCTION IF EXISTS fn_ContaAluno;
USE projetofinal;

DELIMITER //

CREATE FUNCTION fn_ContaAluno() RETURNS VARCHAR (1000)
BEGIN
    -- Declaração de variáveis
    DECLARE num_alunos_ano_atual INT;
    DECLARE ano_atual INT;
    DECLARE selecao INT; -- Alterado o tipo de variável para INT
    DECLARE resultado VARCHAR(1000); -- Adicionado para armazenar o resultado da função
    DECLARE vaga_disponivel INT;
    DECLARE br VARCHAR(100);

    -- Obter o ano atual
    SELECT YEAR(NOW()) INTO ano_atual;

    -- Contar o número de alunos matriculados no ano atual
    SELECT COUNT(RA) INTO num_alunos_ano_atual FROM aluno WHERE YEAR(dataCadastro) = ano_atual;

    -- Atribuir o resultado da seleção à variável 'selecao'
    SET selecao = num_alunos_ano_atual;
    SET vaga_disponivel = 300 - selecao;
    SET br = '\n\n';

    -- Verificar se o limite de matrículas foi alcançado
    IF selecao >= 300 THEN
        
        SET resultado = CONCAT('Ano de', br, ano_atual,br,'Número Limite alcançado. Total de alunos:', br, 'Alunos Matriculados =',  selecao,' Vagas disponíveis: ', vaga_disponivel);
    ELSE
        SET resultado = CONCAT('Ano de',br, ano_atual,'!',br, 'Matrículas Liberadas.', br, 'Alunos Matriculados =',  selecao,' Vagas disponíveis: ', vaga_disponivel);
    END IF;

    -- Retornar a mensagem
    RETURN resultado;
END //

DELIMITER ;

SELECT fn_ContaAluno();

