-- Active: 1696797798526@@127.0.0.1@3306
CREATE DATABASE IF NOT EXISTS faculdade CHARACTER
SET
    utf8mb4 COLLATE utf8mb4_unicode_ci;
USE faculdade;
CREATE TABLE IF NOT EXISTS departamento (
    cod_departamento INTEGER NOT NULL PRIMARY KEY,
    nome_departamento VARCHAR(100) NOT NULL
);
/*CAPACIDADE MAXIMA DE ALUNOS
 AS DISCIPLINAS SAO OBRIGATORIAS OU OPTATIVAS DEPENDENDO DO CURSO
 */CREATE TABLE IF NOT EXISTS disciplina (
    cod_disciplina INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_disciplina VARCHAR(100) NOT NULL,
    cod_departamento INT,
    carga_horaria INT,
    optativa BOOLEAN,
    CONSTRAINT fk_cod_departamento_disciplina FOREIGN KEY(cod_departamento) REFERENCES departamento(cod_departamento)
);
/* INSERINDO DADOS NA TABELA DISCIPLINA*/
INSERT INTO
    disciplina (
        nome_disciplina,
        cod_departamento,
        carga_horaria,
        optativa
    )
VALUES
    ('Sistemas Operacionais', 1, 60, 0),
    ('Análise de Sistemas', 1, 60, 0),
    ('Banco de Dados I ', 1, 60, 0),
    ('Sistemas de Apoio a Decisão ', 1, 30, 0),
    ('Serviços de Redes para Internet  ', 1, 60, 0),
    ('Banco de Dados II  ', 1, 60, 0),
    ('Engenharia de Software ', 1, 90, 0),
    ('Projeto de Sistemas ', 1, 60, 0),
    ('Programação Orientada a Objetos II', 1, 60, 0),
    ('Gerência de Projetos de Software ', 1, 60, 0),
    ('Redes de Computadores', 1, 60, 0),
    ('Desenvolvimento Web ', 1, 60, 0),
    ('Comércio Eletrônico  ', 1, 60, 0),
    ('Gestão de Sistemas de Informação  ', 1, 60, 0),
    ('Laboratório de Engenharia de Software ', 1, 60, 0),
    ('Sistemas Distribuídos ', 1, 60, 0),
    ('Comunicação Empresarial  ', 1, 60, 0),
    ('Teoria Geral da Administração ', 1, 60, 0),
    ('Administração Financeira  ', 1, 60, 0),
    ('Administração da Produção e Logística  ', 1, 60, 0),
    ('Sociologia ', 1, 60, 0),
    ('Ética e legislação em Informática ', 1, 60, 0),
    ('Metodologia da Pesquisa ', 1, 60, 0),
    ('Empreendedorismo ', 1, 60, 0),
    ('Anteprojeto ', 1, 60, 0),
    ('Projeto de Diplomação I  ', 1, 60, 0),
    ('Projeto de Diplomação II   ', 1, 60, 0),
    ('Estágio Supervisionado Obrigatório', 1, 60, 0),
    (
        'Tópicos especiais em Engenharia de Software  ',
        1,
        60,
        0
    ),
    (
        'Tópicos Especiais em Redes de Computadores  ',
        1,
        60,
        0
    ),
    ('Interface com Usuário', 1, 60, 0),
    ('Sistemas Colaborativos ', 1, 60, 0),
    ('Pesquisa Operacional  ', 1, 60, 0),
    ('Libras  ', 1, 60, 0);
/*UM PROFESSOR PODE LESSIONAR NO MAXIMO 4 DISCIPLINA*/CREATE TABLE IF NOT EXISTS professor (
    cod_professor INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    sobre_nome VARCHAR(100) NOT NULL,
    cod_departamento INT,
    CONSTRAINT fk_cod_departamento_professor FOREIGN KEY(cod_departamento) REFERENCES departamento(cod_departamento)
);
INSERT INTO
    professor (nome, sobrenome, cod_departamento)
VALUES
    ('Maria', 'Silva', 1),
    ('João', 'Santos', 1),
    ('Ana', 'Carvalho', 1),
    ('Pedro', 'Rodrigues', 1),
    ('Sofia', 'Almeida', 1),
    ('Tiago', 'Ferreira', 1),
    ('Mariana', 'Neves', 1),
    ('Luís', 'Oliveira', 1),
    ('Lara', 'Gonçalves', 1),
    ('Ricardo', 'Moreira', 1),
    ('Cláudia', 'Pereira', 2),
    ('Carlos', 'Martins', 2),
    ('Isabel', 'Ribeiro', 2),
    ('André', 'Alves', 2),
    ('Beatriz', 'Soares', 2),
    ('Filipe', 'Lima', 2),
    ('Rita', 'Correia', 2),
    ('Hugo', 'Fernandes', 2),
    ('Inês', 'Pinto', 2),
    ('Nuno', 'Pacheco', 2),
    ('Lúcia', 'Costa', 3),
    ('José', 'Mendes', 3),
    ('Marta', 'Dias', 3),
    ('Paulo', 'Cardoso', 3),
    ('Catarina', 'Marques', 3),
    ('David', 'Barbosa', 3),
    ('Raquel', 'Guerra', 3),
    ('Bruno', 'Cunha', 3),
    ('Daniela', 'Magalhães', 3),
    ('Gonçalo', 'Ramos', 3),
    ('Teresa', 'Santana', 3),
    ('Hélder', 'Sousa', 3),
    ('Sara', 'Lopes', 3),
    ('Vasco', 'Andrade', 3),
    ('Rafael', 'Fonseca', 3),
    ('Patrícia', 'Simões', 3),
    ('Leonardo', 'Teixeira', 3),
    ('Ângela', 'Gomes', 1),
    ('Carolina', 'Reis', 2);
TRUNCATE TABLE professor;
/*CURSOS SAO COMPOSTOS POR VARIAS DISCIPLINAS*/CREATE TABLE IF NOT EXISTS curso (
    cod_curso INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(100) NOT NULL,
    cod_disciplina INT,
    qtd_horas_min INTEGER,
    num_periodo INT,
    status BOOLEAN,
    CONSTRAINT fk_cod_disciplina_curso FOREIGN KEY(cod_disciplina) REFERENCES disciplina(cod_disciplina)
);
CREATE TABLE professor_disciplina (
    cod INT NOT NULL AUTO_INCREMENT,
    cod_professor INT NOT NULL,
    cod_disciplina INT NOT NULL,
    PRIMARY KEY (cod, cod_professor, cod_disciplina),
    KEY `fk_cod_professor_professor_2` (`cod_professor`),
    KEY `fk_cod_disciplina_disciplina_2` (`cod_disciplina`)
);
INSERT INTO
    professor_disciplina (cod_professor, cod_disciplina)
VALUES
    (1, 1),
    (1, 3),
    (1, 5),
    (1, 7),
    (2, 2),
    (2, 4),
    (2, 6),
    (2, 8),
    (3, 1),
    (3, 9),
    (3, 10),
    (3, 11),
    (4, 12),
    (4, 1),
    (4, 13),
    (4, 14),
    (5, 15),
    (5, 16),
    (5, 12),
    (5, 2);
SELECT
    disciplina.nome_disciplina,
    disciplina.cod_disciplina,
    professor.cod_professor,
    professor.nome,
    professor.sobrenome,
    professor_disciplina.cod_professor,
    professor_disciplina.cod_disciplina
FROM
    disciplina
    INNER JOIN professor_disciplina ON professor_disciplina.cod_professor = disciplina.cod_disciplina
    INNER JOIN professor ON professor.cod_professor = professor_disciplina.cod_professor;
CREATE VIEW vw_professor_disciplina AS
SELECT
    p.cod_professor 'CÓDIGO DO PROFESSOR',
    p.nome 'NOME',
    p.sobrenome 'SOBRENOME',
    d.nome_disciplina 'NOME DA DISCIPLINA',
    p.cod_departamento 'DEPARTAMENTO'
FROM
    professor p
    LEFT JOIN professor_disciplina pd ON p.cod_professor = pd.cod_professor
    RIGHT JOIN disciplina d ON d.cod_disciplina = pd.cod_disciplina;
CREATE TABLE IF NOT EXISTS semestre (
    cod INT NOT NULL AUTO_INCREMENT,
    cod_semestre INT,
    cod_curso INT,
    cod_disciplina INT,
    turno CHAR(1),
    data DATE,
    PRIMARY KEY (cod, cod_semestre, cod_curso, cod_disciplina),
    CONSTRAINT fk_cod_curso_curso_1 FOREIGN KEY(cod_curso) REFERENCES curso(cod_curso),
    CONSTRAINT cod_disciplina_disciplina_1 FOREIGN KEY(cod_disciplina) REFERENCES disciplina(cod_disciplina)
);
CREATE VIEW vw_semestre AS
SELECT
    c.nome_curso,
    d.nome_disciplina,
    s.periodo,
    s.turno,
    s.data
FROM
    curso c
    LEFT JOIN semestre s ON c.cod_curso = s.cod_curso
    RIGHT JOIN disciplina d ON d.cod_disciplina = s.cod_disciplina;
/*
 CREATE TABLE
 cronograma_didatico (
 cod int NOT NULL AUTO_INCREMENT,
 cod_semestre INT,
 cod_curso INT,
 cod_disciplina INT,
 cod_professor INT,
 
 data DATE,
 
 
 PRIMARY KEY (
 cod,
 cod_semestre,
 cod_curso,
 cod_disciplina
 ),
 CONSTRAINT fk_cod_semestre_semestre FOREIGN KEY(cod_semestre) REFERENCES semestre(cod_semestre),
 CONSTRAINT fk_cod_curso_curso_disciplina FOREIGN KEY(cod_curso) REFERENCES curso_disciplina(cod_curso),
 CONSTRAINT fk_cod_disciplina_curso_disciplina FOREIGN KEY(cod_disciplina) REFERENCES curso_disciplina(cod_disciplina),
 CONSTRAINT fk_cod_professor_professor_disciplina FOREIGN KEY(cod_professor) REFERENCES professor_disciplina(cod_professor)
 ); 
 
 */CREATE TABLE IF NOT EXISTS aluno_disciplina (
    cod INT NOT NULL AUTO_INCREMENT,
    RA INTEGER NOT NULL,
    cod_disciplina INT,
    frequencia CHAR (1),
    semestre INT,
    data DATE,
    CONSTRAINT pk_aluno_disciplina PRIMARY KEY (cod, RA),
    CONSTRAINT fk_RA_aluno_disciplina FOREIGN KEY(RA) REFERENCES aluno(RA),
    CONSTRAINT fk_cod_disciplina_aluno_disciplina FOREIGN KEY(cod_disciplina) REFERENCES disciplina(cod_disciplina)
);

 

    
 CREATE TABLE IF NOT EXISTS
    nota (
        cod int NOT NULL AUTO_INCREMENT,
        RA int NOT NULL,
        cod_disciplina int NOT NULL,
        nota FLOAT ,
        semestre INT,
        
       
        PRIMARY KEY (
            cod,
            RA,
            cod_disciplina
        ),
        
         CONSTRAINT fk_RA_aluno_disciplina FOREIGN KEY(RA) REFERENCES aluno_disciplina(RA),
         CONSTRAINT fk_cod_disciplina_aluno_disciplina_3 FOREIGN KEY(cod_disciplina) REFERENCES aluno_disciplina(cod_disciplina)
    );


CREATE TABLE IF NOT EXISTS turma (
    cod INT NOT NULL AUTO_INCREMENT,
    RA INTEGER NOT NULL,
    cod_professor INT,
    frequencia FLOAT,
    semestre INT,
    data DATE,
    CONSTRAINT pk_cod_turma PRIMARY KEY (cod, RA),
    CONSTRAINT fk_cod_professor_professor_disciplina FOREIGN KEY(cod_professor) REFERENCES professor_disciplina(cod_professor),
    CONSTRAINT fk_RA_aluno_disciplina_01 FOREIGN KEY(RA) REFERENCES aluno(RA)
);
CREATE VIEW vw_nota_aluno_disciplina AS
SELECT
    a.RA,
    a.nome,
    a.sobrenome,
    ad.frequencia,
    ad.semestre,
    d.nome_disciplina,
    ad.data,
    ad.nota,
    ad.status
FROM
    aluno a
    LEFT JOIN aluno_disciplina ad ON a.RA = ad.RA
    RIGHT JOIN disciplina d ON d.cod_disciplina = ad.cod_disciplina;
/*INSERINDO DADOS NA TABELA CURSO */
INSERT INTO
    curso (
        nome_curso,
        cod_disciplina,
        qtd_horas_min,
        num_periodo,
        status
    )
VALUES
    ('SISTEMAS DE INFORMAÇÃO', 1, 3055, '8', 1),
    ('FULL STACK', 1, 3004, '8', 1),
    ('REDES', 1, 3048, '8', 1);
CREATE TABLE IF NOT EXISTS curso_disciplina (
    cod AUTO_INCREMENT AUTO_INCREMENT NOT NULL,
    cod_curso INTEGER NOT NULL,
    cod_disciplina INTEGER NOT NULL,
    periodo INTEGER NOT NULL,
    pre_requisito INT,
    CONSTRAINT PRIMARY KEY pk_cod_curso_disciplina (cod_curso, cod_disciplina),
    CONSTRAINT fk_cod_curso_curso FOREIGN KEY(cod_curso) REFERENCES curso(cod_curso),
    CONSTRAINT fk_cod_disciplina_disciplina FOREIGN KEY(cod_disciplina) REFERENCES disciplina(cod_disciplina),
    CONSTRAINT fk_pre_requisito_disciplina FOREIGN KEY(pre_requisito) REFERENCES disciplina(cod_disciplina)
);
/*INSERINDO DADOS NA TABELA CURSO DISCIPLINA*/
INSERT INTO
    curso_disciplina (cod_curso, cod_disciplina, periodo, pre_requisito)
VALUES
    /* 1 SEMESTRE NÃO POSSUI PRE-REQUISITO */(1, 1, 3, 48),
    (1, 2, 3, 48),
    (1, 3, 4, 48),
    (1, 36, 4, 48),
    (1, 30, 2, 48),
    /*REQUISITOS 2º SEMESTRE*/(1, 5, 3, 1),
    (1, 6, 5, 2),
    (1, 7, 6, 3),
    (1, 8, 4, 48),
    (1, 9, 2, 48),
    /*REQUISITOS 3º SEMESTRE*/(1, 14, 3, 8),
    (1, 9, 3, 4),
    (1, 32, 3, 9),
    (1, 10, 3, 7),
    (1, 11, 3, 1),
    /*REQUISITOS 4º SEMESTRE*/(1, 12, 4, 10),
    (1, 15, 4, 48),
    (1, 16, 4, 48),
    (1, 17, 4, 4),
    (1, 34, 4, 48),
    /*REQUISITOS 5º SEMESTRE*/(1, 19, 5, 16),
    (1, 20, 5, 15),
    (1, 21, 5, 15),
    (1, 18, 5, 24),
    (1, 22, 5, 12),
    /*REQUISITOS 6º SEMESTRE*/(1, 23, 6, 20),
    (1, 33, 6, 31),
    (1, 29, 6, 24),
    (1, 37, 6, 48),
    (1, 29, 6, 12),
    (1, 31, 6, 14),
    (1, 12, 6, 22),
    (1, 35, 6, 25),
    (1, 39, 6, 48),
    (1, 40, 6, 12);
/*ANTEPROJETO NESCESSITA ESTA APROVADO EM TODAS AS MATERIAS ATE O 4° SEMESTRE*//*REQUISITOS 7º SEMESTRE*/(1, 41, 7, 49),
(1, 42, 7, 49),
(1, 43, 7, 49),
(1, 43, 7, 49),
(1, 44, 7, 49),
/*REQUISITOS 8º SEMESTRE*/(1, 45, 8, 49),
(1, 46, 8, 49),
(1, 47, 8, 49);
/*CONSULTA JOIN CURSO DISCIPLINA*/USE faculdade;
CREATE VIEW vw_curso_discipina AS
SELECT
    d.cod_disciplina,
    c.nome_curso 'Nome do Curso',
    d.nome_disciplina 'Nome Disciplina',
    d.cod_departamento 'Código do Departamento',
    d.carga_horaria 'Total horas Disciplina',
    cd.periodo 'Semestre',
    cd.pre_requisito
FROM
    disciplina AS d
    LEFT JOIN curso_disciplina AS cd ON cd.cod_disciplina = d.cod_disciplina
    INNER JOIN curso AS c ON cd.cod_curso = c.cod_curso;
CREATE VIEW vw_disciplina AS
SELECT
    vw.cod_disciplina,
    `Nome do Curso`,
    `Nome Disciplina`,
    `Total horas Disciplina`,
    vw.Semestre,
    d.nome_disciplina 'Pré-Requisito'
FROM
    faculdade.vw_curso_discipina AS vw
    LEFT JOIN disciplina AS d ON d.cod_disciplina = vw.pre_requisito
GROUP BY
    vw.cod_disciplina;
CREATE TABLE IF NOT EXISTS professor_disciplina (
    cod_professor INTEGER NOT NULL,
    cod_disciplina INTEGER NOT NULL,
    CONSTRAINT PRIMARY KEY pk_cod_professor_disciplina (cod_professor, cod_disciplina),
    CONSTRAINT fk_cod_professor_professor FOREIGN KEY(cod_professor) REFERENCES professor(cod_professor),
    CONSTRAINT fk_cod_disciplina_disciplina_professor FOREIGN KEY(cod_disciplina) REFERENCES disciplina(cod_disciplina)
);
CREATE TABLE IF NOT EXISTS aluno (
    RA INTEGER NOT NULL UNIQUE,
    nome VARCHAR (255) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    CPF CHAR(9) NOT NULL UNIQUE,
    tel1 VARCHAR(12),
    tel2 VARCHAR(12),
    nome_pai VARCHAR(100) NOT NULL,
    nome_mae VARCHAR(100) NOT NULL,
    endereco VARCHAR(50),
    longradouro VARCHAR(50),
    CEP CHAR(8) NOT NULL UNIQUE
);
/*
 INSERINDO DADOS NA TABELA ALUNO
 */
INSERT INTO
    aluno (
        RA,
        nome,
        sobrenome,
        CPF,
        tel1,
        tel2,
        nome_pai,
        nome_mae,
        endereco,
        longradouro,
        CEP
    )
VALUES
    (
        00001,
        'EDIVALDO',
        'GORETO',
        00038144422212,
        61920032020,
        61920032222,
        'JÕAO DA SILVA',
        'MARIA BONITA',
        'QUADRA 202',
        'CONJUNTO B SANTA MARIA DF',
        72430208
    );
SELECT
    *
FROM
    aluno;
CREATE TABLE IF NOT EXISTS turma (
    cod_turma INTEGER NOT NULL PRIMARY KEY,
    RA INTEGER NOT NULL,
    cod_professor INTEGER NOT NULL,
    cod_curso INTEGER NOT NULL,
    cod_disciplina INTEGER,
    semestre INTEGER,
    turno CHAR(1) NOT NULL,
    sala VARCHAR(20),
    qtd_aluno INT,
    CONSTRAINT fk_RA_aluno FOREIGN KEY(RA) REFERENCES aluno(RA),
    CONSTRAINT fk_RA_aluno FOREIGN KEY(RA) REFERENCES aluno(RA)
);