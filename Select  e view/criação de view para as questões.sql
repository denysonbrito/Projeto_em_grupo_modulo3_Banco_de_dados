
--Questões

--1. Selecionar a quantidade total de estudantes cadastrados no banco;

--Criacao de select para quantidade total de estudantes cadastrados no banco de dados   
SELECT COUNT(*) AS quantidade_estudantes
FROM estudante; 



--Criacao de view para  quantidade total de estudantes  
CREATE VIEW view_quantidade_estudantes AS
SELECT COUNT(*) AS quantidade_estudantes
FROM estudante; -- Criacao de view para a uantidade total de estudantes

--consultando a quantidade total de alunos pelo view
SELECT quantidade_estudantes
FROM view_quantidade_estudantes;


---------------------------------------------------------------
--2. Selecionar quais pessoas facilitadoras atuam em mais de uma turma;

-- Criacao de select para select pessoa_facilitadora_tech
SELECT pessoa_facilitadora_tech.nome
FROM pessoa_facilitadora_tech
JOIN curso ON pessoa_facilitadora_tech.id_pessoa_facilitadora_tech = curso.id_pessoa_facilitadora_tech
GROUP BY pessoa_facilitadora_tech.nome
HAVING COUNT(DISTINCT curso.id_turma) > 1;

-- Criacao de view para select pessoa_facilitadora_tech
CREATE VIEW view_facilitadores_tech_multiturma AS
SELECT pessoa_facilitadora_tech.nome
FROM pessoa_facilitadora_tech
JOIN curso ON pessoa_facilitadora_tech.id_pessoa_facilitadora_tech = curso.id_pessoa_facilitadora_tech
GROUP BY pessoa_facilitadora_tech.nome
HAVING COUNT(DISTINCT curso.id_turma) > 1;

-- Consultando pessoa_facilitadora_tech pelo view view_facilitadores_tech_multiturma
SELECT nome
FROM view_facilitadores_tech_multiturma;



-- Criacao de select para select pessoa_facilitadora_soft
SELECT pessoa_facilitadora_soft.nome
FROM pessoa_facilitadora_soft
JOIN curso ON pessoa_facilitadora_soft.id_pessoa_facilitadora_soft = curso.id_pessoa_facilitadora_soft
GROUP BY pessoa_facilitadora_soft.nome
HAVING COUNT(DISTINCT curso.id_turma) > 1;

-- Criacao de view para select pessoa_facilitadora_soft
CREATE VIEW view_facilitadores_soft_multiturma AS
SELECT pessoa_facilitadora_soft.nome
FROM pessoa_facilitadora_soft
JOIN curso ON pessoa_facilitadora_soft.id_pessoa_facilitadora_soft = curso.id_pessoa_facilitadora_soft
GROUP BY pessoa_facilitadora_soft.nome
HAVING COUNT(DISTINCT curso.id_turma) > 1;

-- Consultando pessoa_facilitadora_soft pelo view view_facilitadores_soft_multiturma
SELECT nome
FROM view_facilitadores_soft_multiturma;



----------------------------------------------------------------------





