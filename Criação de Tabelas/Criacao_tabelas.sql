
CREATE TABLE estudante -- Criando a Tabela Estudante 
(
	id_estudante SERIAL PRIMARY KEY NOT NULL, -- Definindo id_estudante como a PK da tabela e usando NOT NULL restringir que o campo seja nulo
	nome VARCHAR(200), -- Criando coluna nome na tabela Estudante, com o varchar com o limite de 200 caracteres 
	sexo VARCHAR(1), -- Criando a coluna sexo na tabela Estudante, deverá ser conter 1 caracter, F para feminino e M para masculino 
	idade INT, -- Criando a coluna idade na tabela Estudante, com o tipo de dado INT (inteiro) que receberá a idade do estudante 
	escolaridade VARCHAR(100), -- Criando coluna escolaridade na tabela Estudante, com o limite de 100 caracteres 
	estado VARCHAR(25), -- Criando coluna estado na tabela Estudante, com o limite de 25 caracteres 
	situacao VARCHAR(100), -- Criando coluna situacao na tabela Estudante, com o limite de 100 caracteres 
	email VARCHAR(50), -- Criando coluna email na tabela Estudante, com o limite de 50 caracteres 
	telefone VARCHAR(25) -- Criando coluna telefone na tabela Estudante, com o limite de 50 caracteres 
);

CREATE TABLE pessoa_facilitadora_tech 
(
	id_pessoa_facilitadora_tech SERIAL PRIMARY KEY NOT NULL, -- Definindo id_pessoa_facilitadora_tech como a PK da tabela, e usando NOT NULL restringir que o campo seja nulo
	nome VARCHAR(200) -- Criando coluna nome na tabela pessoa_facilitadora_tech , com o varchar com o limite de 200 caracteres 
);

CREATE TABLE pessoa_facilitadora_soft  
(
	id_pessoa_facilitadora_soft SERIAL PRIMARY KEY NOT NULL, -- Definindo id_pessoa_facilitadora_tech como a PK da tabela, e usando NOT NULL restringir que o campo seja nulo
	nome VARCHAR(200) -- Criando coluna nome na tabela pessoa_facilitadora_soft , com o varchar com o limite de 200 caracteres 
);

CREATE TABLE turma 
(
	id_turma SERIAL PRIMARY KEY NOT NULL, -- Definindo id_turma como a PK da tabela, e usando NOT NULL restringir que o campo seja nulo
	nome VARCHAR(200) -- Criando coluna nome na tabela turma , com o varchar com o limite de 200 caracteres 
);

CREATE TABLE modulo
(
	id_modulo SERIAL PRIMARY KEY NOT NULL, -- Definindo id_modulo como a PK da tabela, e usando NOT NULL restringir que o campo seja nulo
	modulo_0 VARCHAR (25), -- Criando coluna modulo_0 na tabela modulo_0 , com o varchar com o limite de 25 caracteres 
	modulo_1 VARCHAR (25), -- Criando coluna modulo_1 na tabela modulo_0 , com o varchar com o limite de 25 caracteres 
	modulo_2 VARCHAR (25), -- Criando coluna modulo_2 na tabela modulo_0 , com o varchar com o limite de 25 caracteres 
	modulo_3 VARCHAR (25), -- Criando coluna modulo_3 na tabela modulo_0 , com o varchar com o limite de 25 caracteres 
	modulo_4 VARCHAR (25), -- Criando coluna modulo_4 na tabela modulo_0 , com o varchar com o limite de 25 caracteres 
	modulo_5 VARCHAR (25) -- Criando coluna modulo_5 na tabela modulo_0 , com o varchar com o limite de 25 caracteres 
);

CREATE TABLE curso 
(
	id_curso INT NOT NULL, 
	nome VARCHAR(50), 
	carga_horaria INT, 
	id_estudante INT,
	id_pessoa_facilitadora_tech INT, 
	id_pessoa_facilitadora_soft INT, 
	id_turma INT, 
	id_modulo INT,
	CONSTRAINT fk_CursoEstudante FOREIGN KEY (id_estudante) REFERENCES estudante (id_estudante),
	CONSTRAINT fk_CursoPessoaFacilitadoratech FOREIGN KEY (id_pessoa_facilitadora_tech) REFERENCES pessoa_facilitadora_tech (id_pessoa_facilitadora_tech),
	CONSTRAINT fk_CursoPessoaFacilitadoraSoft FOREIGN KEY (id_pessoa_facilitadora_soft) REFERENCES pessoa_facilitadora_soft (id_pessoa_facilitadora_soft),
	CONSTRAINT fk_CursoTurma FOREIGN KEY (id_turma) REFERENCES turma (id_turma),
	CONSTRAINT fk_modulo FOREIGN KEY (id_modulo) REFERENCES modulo (id_modulo)
);

CREATE TABLE log_estudante_situacao
(
	registro SERIAL,
	id_estudante INT,
	data_alteracao TIMESTAMP,
	situacao VARCHAR(50)

);

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

CREATE TRIGGER tg_atualiza_situacao_estudante
    AFTER UPDATE
    ON estudante
FOR EACH ROW
    EXECUTE PROCEDURE atualizacao_situacao_estudante()


