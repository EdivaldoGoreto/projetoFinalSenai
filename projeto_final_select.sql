-- Active: 1696797798526@@127.0.0.1@3306

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
    

