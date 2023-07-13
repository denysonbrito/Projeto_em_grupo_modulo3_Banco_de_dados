
--Questões

--1. Selecionar a quantidade total de estudantes cadastrados no banco;

--Criacao de select para quantidade total de estudantes cadastrados no banco de dados   
SELECT COUNT(id_estudante) AS quantidade_estudantes
FROM estudante; 



--Criacao de view para  quantidade total de estudantes  
CREATE VIEW view_quantidade_estudantes AS
SELECT COUNT(*) AS quantidade_estudantes
FROM estudante; -- Criacao de view para a quantidade total de estudantes

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
-- 3. Crie uma view que selecione a porcentagem de estudantes com status de evasão agrupados por turma;

CREATE OR REPLACE VIEW percentual_de_evasao_por_turma AS
SELECT
   (turma.nome),
    CONCAT((COUNT(CASE WHEN estudante.situacao = 'inativo' THEN 1 END) / COUNT(*)::FLOAT) * 100, '%') AS percentual_evasão
FROM
    estudante
INNER JOIN
    curso ON estudante.id_estudante = curso.id_estudante
INNER JOIN 
	turma ON curso.id_turma = turma.id_turma
GROUP BY
    turma.nome;

-- Consulta da view 
SELECT * FROM percentual_de_evasao_por_turma

----------------------------------------------------------------------
--4. Crie um trigger para ser disparado quando o atributo status de um estudante for atualizado e inserir um novo dado em uma tabela de log.
CREATE OR REPLACE FUNCTION 
atualizacao_situacao_estudante() RETURNS
trigger AS $$
BEGIN 
   INSERT INTO log_estudante_situacao
	(id_estudante, data_alteracao, situacao)
   VALUES
	(NEW.id_estudante, NOW(), NEW.situacao);

RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualizacao_situacao_estudante
	AFTER UPDATE
	ON estudante
FOR EACH ROW
	EXECUTE PROCEDURE atualizacao_situacao_estudante()

-- teste de UPDATE na situacao
UPDATE ESTUDANTE SET SITUACAO='inativo' where id_estudante = 1

--consulta tabela log_estudante_situacao
select * from log_estudante_situacao

----------------------------------------------------------------------
-- 5. Uma empresa parceira deseja saber os alunos que não concluiram o ensino 
-- médio por turma, para que possam realizar o sorteio de 5 bolsas de estudos (EJA - ENSINO MÉDIO) para cada turma.

SELECT TURMA.ID_TURMA, TURMA.NOME, ESTUDANTE.ID_ESTUDANTE AS MATRÍCULA, ESTUDANTE.NOME, estudante.escolaridade FROM ESTUDANTE
estudante
INNER JOIN
    curso ON estudante.id_estudante = curso.id_estudante
INNER JOIN 
	turma ON curso.id_turma = turma.id_turma
WHERE estudante.escolaridade LIKE 'Fundamental Completo' 
GROUP BY
    TURMA.ID_TURMA, turma.nome, ESTUDANTE.NOME, estudante.escolaridade, MATRÍCULA
ORDER BY TURMA.ID_TURMA
