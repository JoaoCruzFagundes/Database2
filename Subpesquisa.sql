CREATE DATABASE ex_basicos;

USE ex_basicos;

CREATE TABLE produto(
id_produto BIGINT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
nome VARCHAR(30) NOT NULL,
preco DECIMAL(10,2)
);
CREATE TABLE cliente(
codigo BIGINT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
nome VARCHAR(30) NOT NULL,
cidade VARCHAR(30),
estado VARCHAR(30)
);
CREATE TABLE estado(
codigo BIGINT AUTO_INCREMENT NOT NULL UNIQUE ,
regiao VARCHAR(30) NOT NULL,
sigla VARCHAR(2) NOT NULL,
estado VARCHAR(30) PRIMARY KEY
);

CREATE TABLE filial(
numero BIGINT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
endereco VARCHAR(30) NOT NULL,
abertura DATE
);
INSERT INTO filial VALUES (1, 'Recife', "2011-04-10");
INSERT INTO filial VALUES (2, 'Sao Carlos' ,"2010-05-24");
INSERT INTO filial VALUES (3, 'Recife',"2009-10-01");
INSERT INTO filial VALUES (4, 'Sao Carlos' ,"2013-01-01");
INSERT INTO filial VALUES (5, 'Recife' ,"2014-03-26");

INSERT INTO produto VALUES (1, 'chocolate', 4.00);
INSERT INTO produto VALUES (2, 'oleo' ,2.15);
INSERT INTO produto VALUES (3, 'catchup ',3.60);
INSERT INTO produto VALUES (4, 'ervamate' ,8.00);
INSERT INTO produto VALUES (5, 'salame' ,4.60);

INSERT INTO cliente VALUES (10, 'joao','mossoro', 'RN');
INSERT INTO cliente VALUES (16, 'maria' ,'fortaleza','CE');
INSERT INTO cliente VALUES (25, 'carlos ','niteroi','RJ');

INSERT INTO estado VALUES (1, 'nordeste', 'RN', 'Rio Grande Do Norte');
INSERT INTO estado VALUES (16, 'sudeste' ,'SP', 'Sao Paulo' );

SELECT numero FROM filial where abertura >ALL (SELECT abertura FROM filial WHERE endereco LIKE "Sao Carlos" AND endereco LIKE "Recife");

SELECT * FROM cliente WHERE estado IN ( SELECT sigla FROM estado WHERE regiao like "nordeste") ;

SELECT * FROM produto WHERE preco = (SELECT MAX(preco) AS maximo FROM produto) ;

SELECT * FROM produto WHERE preco >any ( SELECT AVG(preco) as media FROM produto);