USE projetoFinal;


CREATE VIEW vw_notaAluno AS
SELECT
    a.RA,
    a.nome,
    a.sobreNome,
    ad.frequencia,
    ad.semestre,
    d.nomeDisciplina,
    ad.dataInicio,
    ad.nota
FROM
    aluno a
    LEFT JOIN alunoDisciplina ad ON a.RA = ad.fk_RA
    RIGHT JOIN disciplina d ON d.codDisciplina = ad.fk_codDisciplina;

SELECT *FROM vw_notaAluno ;

CREATE VIEW vw_cursoDiscipina AS
SELECT
    d.codDisciplina,
    c.nomeCurso 'Nome do Curso',
    d.nomeDisciplina 'Nome Disciplina',
    d.fk_codDepartamento 'Código do Departamento',
    d.cargaHoraria 'Total horas Disciplina',
    cd.periodo 'Semestre',
    cd.fk_preRequisito
FROM
    disciplina AS d
    LEFT JOIN cursoDisciplina AS cd ON cd.fk_codDisciplina = d.codDisciplina
    INNER JOIN curso AS c ON cd.fk_codCurso = c.codCurso;
SELECT *FROM vw_cursoDiscipina ;

CREATE VIEW vw_disciplina AS

SELECT
    d.codDisciplina,
    c.nomeCurso 'Nome do Curso',
    d.nomeDisciplina 'Nome Disciplina',
    d.fk_codDepartamento 'Código do Departamento',
    d.cargaHoraria 'Total horas Disciplina',
    cd.periodo 'Semestre',
    cd.fk_preRequisito,
    d2.nomeDisciplina
FROM
    disciplina AS d
    LEFT JOIN cursoDisciplina AS cd ON cd.fk_codDisciplina = d.codDisciplina
    LEFT JOIN disciplina AS d2 ON cd.fk_preRequisito = d2.codDisciplina
    INNER JOIN curso AS c ON cd.fk_codCurso = c.codCurso;



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