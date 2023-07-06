CREATE TABLE Estudante
(
	id_estudante INT PRIMARY KEY NOT NULL, -- NOT NULL obriga os campos a serem preenchidos 
	nome VARCHAR(200),
	sexo VARCHAR(1), --M para masculino e F para feminino 
	idade INT, 
	escolaridade VARCHAR(50),
	estado VARCHAR(30), 
	situacao VARCHAR(100)
);

CREATE TABLE pessoa_facilitadora_tech 
(
	id_pessoa_facilitadora_tech INT PRIMARY KEY NOT NULL,
	nome VARCHAR(200)
);

CREATE TABLE pessoa_facilitadora_soft
(
	id_pessoa_facilitadora_soft INT PRIMARY KEY NOT NULL,
	nome VARCHAR(200)
); 

CREATE TABLE Turma 
(
	id_turma INT PRIMARY KEY NOT NULL,
	nome VARCHAR(50)
);

CREATE TABLE Modulo 
(
	id_modulo INT PRIMARY KEY NOT NULL,
	nome VARCHAR(200),
	modulo_0 VARCHAR(50),
	modulo_1 VARCHAR(50),
	modulo_2 VARCHAR(50),
	modulo_3 VARCHAR(50),
	modulo_4 VARCHAR(50),
	modulo_5 VARCHAR(50)
);

CREATE TABLE Curso
(
	id_curso INT PRIMARY KEY NOT NULL,
	nome VARCHAR(200),
	carga_horaria INT,
	id_estudante INT NOT NULL,
	id_pessoa_facilitadora_tech INT NOT NULL,
	id_pessoa_facilitadora_soft INT NOT NULL,
	id_turma INT NOT NULL,
	id_modulo INT NOT NULL
);






