-- Active: 1696797798526@@127.0.0.1@3306@projetofinal
DROP PROCEDURE InserirAlunoDisciplina;

DELIMITER //

CREATE PROCEDURE InserirAlunoDisciplina(
    IN fk_RA_param INT,
    IN fk_codCurso_param INT,
    IN fk_codDisciplina_param INT,
    IN nota_param FLOAT,
    IN frequencia_param FLOAT,
    IN fk_semestre_param INT,
    IN dataInicio_param DATE,
    IN dataFim_param DATE
)
BEGIN
    -- Verifica se o curso já possui 30 alunos matriculados na disciplina
    IF (SELECT COUNT(*) FROM alunodisciplina ad
        JOIN nota n ON n.fk_RA = ad.fk_RA
        WHERE n.fk_codCurso = fk_codCurso_param AND ad.fk_codDisciplina = fk_codDisciplina_param) < 30 THEN

        -- Insere o aluno na tabela alunodisciplina
        INSERT INTO alunodisciplina (fk_RA, fk_codDisciplina) VALUES (fk_RA_param, fk_codDisciplina_param);
    
        -- Mensagem de depuração
        SELECT CONCAT('Aluno inserido com RA ', fk_RA_param) AS mensagem;

        -- Obtém o ID do último registro inserido na tabela alunodisciplina
        SET @last_insert_id_alunodisciplina := LAST_INSERT_ID();

        -- Inserir na tabela de notas
        INSERT INTO nota (fk_RA, fk_codCurso, fk_codDisciplina, nota, frequencia, fk_semestre)
        VALUES (fk_RA_param, fk_codCurso_param, fk_codDisciplina_param, nota_param, frequencia_param, fk_semestre_param);

        -- Obtém o ID do último registro inserido na tabela nota
        SET @last_insert_id_nota := LAST_INSERT_ID();

        -- Inserir na tabela de semestre usando o RA da alunodisciplina
        INSERT INTO semestre (fk_RA, dataInicio, dataFim)
        VALUES (fk_RA_param, dataInicio_param, dataFim_param);

        -- Obtém o ID do último registro inserido na tabela semestre
        SET @last_insert_id_semestre := LAST_INSERT_ID();
    
        -- Se necessário, você pode utilizar os IDs obtidos para outras operações

        -- Mensagem de depuração
        SELECT CONCAT('ID da alunodisciplina: ', @last_insert_id_alunodisciplina, ', ID da nota: ', @last_insert_id_nota, ', ID do semestre: ', @last_insert_id_semestre) AS mensagem;
    ELSE
        -- Mensagem de erro caso o limite de alunos seja atingido
        SELECT 'Limite de alunos atingido para este curso e disciplina. Não foi possível adicionar mais alunos.' AS mensagem;
    END IF;
END //

DELIMITER ;

-- ---------------------------------------------------------------
CALL InserirAlunoDisciplina(
   
    20162105,       -- fk_RA
    1,              -- fk_codCurso
    1,            -- fk_codDisciplina
    8.5,            -- nota
    4.5,           -- frequencia
    1,              -- fk_semestre
    '2023-01-01',   -- dataInicio
    '2023-06-30'    -- dataFim
);
-- -----------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE InserirProfessor(    
    IN nome_param VARCHAR(255),
    IN sobreNome_param VARCHAR(255),
    IN fk_codDepartamento_param INT
)
BEGIN
    -- Declarar variáveis
    DECLARE num_professores INT;

    -- Contar o número de professores
    SELECT COUNT(*) INTO num_professores FROM Professor;

    -- Verificar se o número de professores já atingiu o máximo permitido
    IF num_professores >= 40 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Limite de professores já alcançado!';
    ELSE
        -- Inserir na tabela ProfessorDisciplina
        INSERT INTO Professor(nome, sobreNome, fk_codDepartamento)
        VALUES (nome_param, sobreNome_param, fk_codDepartamento_param);
    END IF;
END //

DELIMITER ;
-- -----------------------------------------------------------------

CALL InserirProfessor(
   
    'João', -- NOME
    'Silva', -- SOBRENOME
    1       -- CODIGO Do DEPARTAMENTO
);
-- -----------------------------------------------------------------
drop Procedure inserirAluno;
DELIMITER //

CREATE PROCEDURE InserirAluno(
    IN RA_param INT,
    IN nome_param VARCHAR(45),
    IN sobreNome_param VARCHAR(45),
    IN dataNascimento_param DATE,
    IN email_param VARCHAR(45),
    IN CPF_param INT,
    IN dataCadastro_param DATE,
    IN fk_codCurso_param INT,
    IN nomePai_param VARCHAR(45),
    IN nomeMae_param VARCHAR(45),
    IN logradouro_param VARCHAR(65),
    IN cidade_param VARCHAR(65),
    IN UF_param CHAR(2),
    IN CEP_param VARCHAR(12),
    IN pais_param VARCHAR(45),
    IN tel1_param VARCHAR(512),
    IN tel2_param VARCHAR(512)
)
BEGIN
    -- Declaração de variáveis
    DECLARE num_alunos_ano_atual INT;
    DECLARE ano_atual INT;

    -- Obter o ano atual
    SELECT YEAR(NOW()) INTO ano_atual;

    -- Contar o número de alunos do ano atual
    SELECT COUNT(*) INTO num_alunos_ano_atual FROM aluno WHERE YEAR(dataCadastro) = ano_atual;

    -- Verificar se o número máximo de alunos foi atingido
    IF num_alunos_ano_atual >= 3000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Limite de 3000 alunos já alcançado para o ano atual!';
    ELSE
        -- Verificar se excede o limite adicional de 3000 alunos
        IF num_alunos_ano_atual >= 3000 + 300 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Limite total de 3300 alunos já alcançado para o ano atual!';
        ELSE
            -- Inserir na tabela aluno
            INSERT INTO aluno (RA, nome, sobrenome, dataNascimento, email, CPF, fk_codCurso, nomePai, nomeMae, dataCadastro)
            VALUES (RA_param, nome_param, sobreNome_param, dataNascimento_param, email_param, CPF_param, fk_codCurso_param, nomePai_param, nomeMae_param, dataCadastro_param);

            -- Obter o ID do aluno recém-inserido
            SET RA_param = LAST_INSERT_ID();

            -- Inserir na tabela endereco
            INSERT INTO endereco (logradouro, cidade, UF, CEP, pais, fk_RA)
            VALUES (logradouro_param, cidade_param, UF_param, CEP_param, pais_param, RA_param);

            -- Obter o ID do endereco recém-inserido
            SET RA_param = LAST_INSERT_ID();

            -- Inserir na tabela contato
            INSERT INTO contato (tel1, tel2, fk_RA)
            VALUES (tel1_param, tel2_param, RA_param);
        END IF;
    END IF;
END //

DELIMITER ;
-- -----------------------------------------------------------------



CALL InserirAluno(
   
    20175100,            -- RA
    'Nome',              -- nome
    'Sobrenome',         -- sobrenome
    '2000-01-01',        -- dataNascimento
    'email@example.com', -- email
    123456789,           -- CPF
    '2023-11-15',        -- dataCadastro
    1,                   -- fk_codCurso
    'NomePai',           -- nomePai
    'NomeMae',           -- nomeMae
    'Rua X',             -- logradouro
    'Cidade Y',          -- cidade
    'UF',                -- UF
    '12345-678',         -- CEP
    'Brasil',            -- pais
    '123-456-789',       -- tel1
    '987-654-321'        -- tel2
);


-- -----------------------------------------------------------------


DELIMITER //

CREATE PROCEDURE InserirCurso(
    IN nomeCurso_param VARCHAR(100),
    IN qtdHoras_param INT,
    IN numPeriodo_param INT,
    IN status_param INT
)
BEGIN
    -- Declaração de variáveis
    DECLARE num_cursos INT;

    -- Contar o número de cursos
    SELECT COUNT(*) INTO num_cursos FROM curso;

    -- Verificar se o número máximo de cursos foi atingido
    IF num_cursos >= 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Limite de 10 cursos já alcançado!';
    ELSE
        -- Inserir na tabela curso
        INSERT INTO curso (nomeCurso, qtdHoras_min, numPeriodo, status)
        VALUES (nomeCurso_param, qtdHoras_param, numPeriodo_param, status_param);
    END IF;
END //

DELIMITER ;


-- -----------------------------------------------------------------

CALL InserirCurso(
    'BANCO DE DADOS',       -- NOME DO CURSOR
    3044,                   -- DURAÇÃO DO CURSO
    8,                      -- NUMERO DE SEMESTRES
    1                       -- STATUS DO CURSO -- ATIVO = 1 -- INATIVO = 0
);

-- -----------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE InserirCursoDisciplina(    
    IN fk_codCurso_param INT,
    IN fk_codDisciplina_param INT,
    IN fk_preRequisito_param INT,
    IN fk_semestre_param INT
)
BEGIN
    DECLARE curso_disciplina_existem INT;

-- Verificar se o curso e a disciplina existem
SELECT COUNT(*) INTO curso_disciplina_existem
FROM curso AS c
INNER JOIN disciplina AS d ON c.codCurso = fk_codCurso_param AND d.codDisciplina = fk_codDisciplina_param;

    IF curso_disciplina_existem > 0 THEN
        -- Inserir a relação curso-disciplina
        INSERT INTO cursoDisciplina (fk_codCurso, fk_codDisciplina, fk_preRequisito, fk_semestre)
        VALUES (fk_codCurso_param, fk_codDisciplina_param, fk_preRequisito_param, fk_semestre_param);

        -- Mensagem de sucesso
        SELECT 'Relação de curso-disciplina cadastrada com sucesso.' AS mensagem;
    ELSE
        -- Mensagem de erro se o curso ou disciplina não existirem
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Curso ou disciplina não encontrados. Não foi possível cadastrar a relação de curso-disciplina.';
    END IF;
END //

DELIMITER ;

-- -----------------------------------------------------------------

CALL InserirCursoDisciplina(
    /* Preencha os valores dos parâmetros conforme necessário */
    1,   -- fk_codCurso
    90,  -- fk_codDisciplina
    1,   -- fk_preRequisito
    1    -- fk_semestre
);

-- -----------------------------------------------------------------