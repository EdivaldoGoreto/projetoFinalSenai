/* PROJ_LOG: */

/*

CREATE TABLE Departamento (
    codDepartamento INTERGER PRIMARY KEY,
    nomeDepartamento VARCHAR(45)
);


CREATE TABLE departamentoDisciplina (
    cod INTERGER PRIMARY KEY,
    fk_codDepartamento INTERGER,
    fk_codDisciplina INTERGER
);

______________________________________

CREATE TABLE Curso (
    codCurso INTERGER PRIMARY KEY,
    nomeCurso VARCHAR(45)
);


CREATE TABLE CursoDisciplina (
    cod INTERGER PRIMARY KEY,
    fk_codCurso INTERGER,
    fk_cod_disciplina INTERGER,
    optativa BOOLEAN
);

______________________________________

CREATE TABLE Disciplina (
    cod INTERGER PRIMARY KEY,
    codDisciplina INTERGER,
    nomeDisciplina VARCHAR(45),
    fk_codDepartamento INTERGER
);

_____________________________________



CREATE TABLE Semestre (
    cod INTERGER PRIMARY KEY,
    fk_RA INTERGER,
    fk_codDisciplina INTERGER,
    data DATE
);

__________________________________________


CREATE TABLE Professor (
    cod INTERGER PRIMARY KEY,
    nome VARCHAR(45),
    sebreNome CHAR(2),
    fk_codDepartamento INTERGER
);

CREATE TABLE DisciplinaProfessor (
    cod INTERGER PRIMARY KEY,
    fk_codDiscipina INTERGER,
    fk_codProfessor INTERGER
);

___________________________________________________

CREATE TABLE Aluno (
    RA INTERGER PRIMARY KEY,
    nome VARCHAR(45),
    sobreNome VARCHAR(45),
    dataNascimento DATE,
    email VARCHAR(65),
    CPF VARCHAR(13),
    fk_codContato INTERGER,
    nomePai VARCHAR(45),
    nomeMae VARCHAR(45),
    fk_codCurso INTERGER
);

CREATE TABLE Endereco (
    codEndereco INTEGER PRIMARY KEY,
    logradouro VARCHAR(45),
    cidade VARCHAR(45),
    UF CHAR(2),
    CEP VARCHAR(11),
    pais VARCHAR(45),
    fk_RA INTERGER
);

CREATE TABLE Telefone (
    cod INTERGER,
    telefone VARCHAR(12),
    contato VARCHAR(12)
);


CREATE TABLE alunoDisciplina (
    cod INTERGER PRIMARY KEY,
    fk_RA INTERGER,
    fk_codDisciplina INTERGER
);

_______________________________________________


*/
CREATE DATABASE IF NOT EXISTS projetoFinal;

USE projetoFinal;



    CREATE TABLE IF NOT EXISTS departamento (
    codDepartamento INTEGER NOT NULL AUTO_INCREMENT,
    nomeDepartamento VARCHAR(100) NOT NULL,
    CONSTRAINT pk_cod_departamento_departamento PRIMARY KEY (codDepartamento)
);


 
 

 CREATE TABLE IF NOT EXISTS departamentoDisciplina (
 
    cod INTEGER NOT NULL AUTO_INCREMENT,
    fk_codDepartamento INT,
    fk_codDisciplina INT,
    CONSTRAINT pk_cod_DepartamentoDisciplina PRIMARY KEY (cod,fk_codDepartamento,fk_codDisciplina),
    CONSTRAINT fk_codDepartamento_departamento FOREIGN KEY (fk_codDepartamento) REFERENCES departamento (codDepartamento),
    CONSTRAINT fk_codDisciplina_Disciplina FOREIGN KEY (fk_codDisciplina) REFERENCES disciplina (codDisciplina)
);


/*CAPACIDADE MAXIMA DE ALUNOS
 AS DISCIPLINAS SAO OBRIGATORIAS OU OPTATIVAS DEPENDENDO DO CURSO*/

 DROP TABLE disciplina;
 CREATE TABLE IF NOT EXISTS disciplina (
    codDisciplina INTEGER NOT NULL AUTO_INCREMENT,
    nomeDisciplina VARCHAR(100) NOT NULL,
    fk_codDepartamento INT,
    optativa BOOLEAN,
    CONSTRAINT pk_codDisciplina_disciplina PRIMARY KEY (codDisciplina),
    CONSTRAINT fk_codDepartamento_disciplina FOREIGN KEY(fk_codDepartamento) REFERENCES departamento (codDepartamento)
);


/*UM PROFESSOR PODE LESSIONAR NO MAXIMO 4 DISCIPLINA*/
CREATE TABLE IF NOT EXISTS professor (
    codProfessor INTEGER NOT NULL  AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    sobreNome VARCHAR(100) NOT NULL,
    fk_codDepartamento INT,
    CONSTRAINT pk_codProfessor_professor PRIMARY KEY (codProfessor),
    CONSTRAINT fk_codDepartamento_professor FOREIGN KEY(fk_codDepartamento) REFERENCES departamento(codDepartamento)
);

/*CURSOS SAO COMPOSTOS POR VARIAS DISCIPLINAS*/


CREATE TABLE IF NOT EXISTS curso (
    codCurso INTEGER NOT NULL  AUTO_INCREMENT,
    nomeCurso VARCHAR(100) NOT NULL,
    fk_codDisciplina INT,
    qtdHoras_min INTEGER,
    numPeriodo INT,
    status BOOLEAN,
    CONSTRAINT pk_codCurso_curso PRIMARY KEY (codCurso),
    CONSTRAINT fk_codDisciplina_curso FOREIGN KEY(fk_codDisciplina) REFERENCES disciplina(codDisciplina)
);


CREATE TABLE professorDisciplina (
    cod INT NOT NULL AUTO_INCREMENT,
    fk_codProfessor INT NOT NULL,
    fk_codDisciplina INT NOT NULL,
    CONSTRAINT pk_codProfessorDisciplina PRIMARY KEY (cod, fk_codProfessor, fk_codDisciplina),
    CONSTRAINT fk_codProfessorProfessorDisciplina FOREIGN KEY(fk_codProfessor) REFERENCES professor(codProfessor),
    CONSTRAINT fk_codDisciplinaProfessorDisciplina FOREIGN KEY(fk_codDisciplina) REFERENCES disciplina(codDisciplina)
);

CREATE TABLE IF NOT EXISTS matricula (
    cod INT NOT NULL AUTO_INCREMENT,
    fk_RA INTEGER NOT NULL,
    status CHAR(1),
    situacao VARCHAR (10),
    CONSTRAINT pk_cod_matricula PRIMARY KEY (cod, fk_RA),
    CONSTRAINT fk_RA_marticula FOREIGN KEY(fk_RA) REFERENCES aluno(RA)
);

 DROP TABLE alunodisciplina;
CREATE TABLE IF NOT EXISTS alunoDisciplina (
    cod INT NOT NULL AUTO_INCREMENT,
    fk_RA INTEGER NOT NULL,
    fk_codDisciplina INT,
    CONSTRAINT pk_alunoDisciplina PRIMARY KEY (cod, fk_RA),
    CONSTRAINT fk_RA_alunoDisciplina FOREIGN KEY(fk_RA) REFERENCES aluno(RA),
    CONSTRAINT fk_codDisciplina_alunoDisciplina FOREIGN KEY(fk_codDisciplina) REFERENCES disciplina(codDisciplina)
);

 

   drop TABLE nota;
 CREATE TABLE IF NOT EXISTS
    nota (
        cod int NOT NULL AUTO_INCREMENT,
        fk_RA int NOT NULL,
        fk_codCurso INT NOT NULL,
        fk_codDisciplina int NOT NULL,
        nota FLOAT ,
        frequencia FLOAT,
        fk_semestre INT,   
       
      CONSTRAINT pk_cod_nota PRIMARY KEY (
            cod,
            fk_RA,
            fk_codDisciplina
        ),        
         CONSTRAINT fk_RA_nota FOREIGN KEY(fk_RA) REFERENCES alunoDisciplina(RA),
         CONSTRAINT fk_codDisciplina_aluno FOREIGN KEY(fk_codDisciplina) REFERENCES alunoDisciplina(codDisciplina),
         CONSTRAINT fk_codCurso_Aluno FOREIGN KEY(fk_codCurso) REFERENCES curso(codCurso),
         CONSTRAINT fk_semestre_nota FOREIGN KEY(fk_semestre) REFERENCES semestre(cod)
    );

CREATE TABLE IF NOT EXISTS semestre (
    cod INT NOT NULL AUTO_INCREMENT,
    fk_RA INTEGER NOT NULL,
    dataInicio DATE,
    dataFim DATE,
    CONSTRAINT pk_cod_semestre PRIMARY KEY (cod, fk_RA, fk_codDisciplina),
    CONSTRAINT fk_RA_semestre FOREIGN KEY(fk_RA) REFERENCES aluno(RA)
);

CREATE TABLE IF NOT EXISTS cursoDisciplina (
    cod int,
    fk_codCurso INTEGER NOT NULL,
    fk_codDisciplina INTEGER NOT NULL,
    fk_preRequisito INT,
    fk_semestre INTEGER,
    
    CONSTRAINT PRIMARY KEY pk_cod_cursoDisciplina (cod, fk_codCurso, fk_codDisciplina),
    CONSTRAINT fk_codCurso_cursoDisciplina FOREIGN KEY(fk_codCurso) REFERENCES curso(codCurso),
    CONSTRAINT fk_codDisciplina_cusoDisciplina FOREIGN KEY(fk_codDisciplina) REFERENCES disciplina(codDisciplina),
    CONSTRAINT fk_preRequisito_cursoDisciplina FOREIGN KEY(fk_preRequisito) REFERENCES disciplina(codDisciplina),
    CONSTRAINT fk_semetre_cusoDisciplina FOREIGN KEY(fk_semestre) REFERENCES nota(semestre)
);

CREATE TABLE IF NOT EXISTS professorDisciplina (
    cod INT NOT NULL,
    fk_codProfessor INTEGER NOT NULL,
    fk_codDisciplina INTEGER NOT NULL,
    CONSTRAINT PRIMARY KEY pk_codProfessorDisciplina (cod,fk_codProfessor, fk_codDisciplina),
    CONSTRAINT fk_codProfessor_professorDisciplina FOREIGN KEY(fk_codProfessor) REFERENCES professor(cod_professor),
    CONSTRAINT fk_codDisciplina_professorDisciplina FOREIGN KEY(fk_codDisciplina) REFERENCES disciplina(cod_disciplina)
);

CREATE TABLE IF NOT EXISTS aluno (
    RA INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    dataNascimento DATE NOT NULL,
    email VARCHAR(45) NOT NULL,
    CPF INT NOT NULL,
    fk_codContato INT,
    fk_codCurso INT,
    nomePai VARCHAR(45) DEFAULT NULL,
    nomeMae VARCHAR(45) DEFAULT NULL,
    CONSTRAINT pk_RA_aluno PRIMARY KEY (RA),
    CONSTRAINT fk_codCurso_aluno FOREIGN KEY (fk_codCurso) REFERENCES curso (codCurso),
    CONSTRAINT fk_codContato_aluno FOREIGN KEY (fk_codContato) REFERENCES contato (codContato)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



	CREATE TABLE IF NOT EXISTS contato 
(
    cod	INT,
    tel1	VARCHAR(512),
    tel2	VARCHAR(512),
    CONSTRAINT pk_cod_contato PRIMARY KEY (cod)
);




CREATE TABLE IF NOT EXISTS turma (
    cod_turma INTEGER NOT NULL,
    RA INTEGER NOT NULL,
    cod_professor INTEGER NOT NULL,
    cod_curso INTEGER NOT NULL,
    cod_disciplina INTEGER,
    semestre INTEGER,
    turno CHAR(1) NOT NULL,
    sala VARCHAR(20),
    qtd_aluno INT,
    CONSTRAINT PRIMARY KEY pk_cod_turma_turma (cod_turma),
    CONSTRAINT fk_RA_aluno FOREIGN KEY(RA) REFERENCES aluno(RA),
    CONSTRAINT fk_RA_aluno FOREIGN KEY(RA) REFERENCES aluno(RA)
);


	CREATE TABLE IF NOT EXISTS endereco 
(
    codEndereco	INT AUTO_INCREMENT,
    logradouro	VARCHAR(65),
    cidade	VARCHAR(65),
    UF	CHAR(2),
    CEP	VARCHAR(12),
    pais	VARCHAR(45),
    fk_RA	INT,
    CONSTRAINT pk_codEdereco PRIMARY KEY(codEndereco),
    CONSTRAINT fk_RA_endereco FOREIGN KEY(fk_RA) REFERENCES aluno(RA)
);
