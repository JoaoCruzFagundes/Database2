USE compubras;
/*1. Retorne o número mais o nome do mês em português (1 - Janeiro) de acordo com o parâmetro
informado que deve ser uma data. Para testar, crie uma consulta que retorne o cliente e mês de
venda (número e nome do mês).*/
DELIMITER $$

create function exercice1(pegaData date) returns VARCHAR(255) DETERMINISTIC 
BEGIN
declare resposta varchar(255);
case date_format(pegaData , '%m') 
when 1 then set resposta = '1 - janeiro';
when 2 then set resposta = '2 - fevereiro';
when 3 then set resposta = '3 - março';
when 4 then set resposta = '4 - abril';
when 5 then set resposta = '5 - maio';
when 6 then set resposta = '6 - junho';
when 7 then set resposta = '7 - julho';
when 8 then set resposta = '8 - agosto';
when 9 then set resposta = '9 - setembro';
when 10 then set resposta = '10 - outubro';
when 11 then set resposta = '11 - novembro';
when 12 then set resposta = '12 - dezembro';
end case;
return resposta;
end$$
DELIMITER ;

select codcliente, exercice1(dataPedido) as "data" from pedido order by "data" asc;

/*2. Retorne o número mais o nome do dia da semana (0 - Segunda) em português, como parâmetro de
entrada receba uma data. Para testar, crie uma consulta que retorne o número do pedido, nome do
cliente e dia da semana para entrega (função criada).*/
delimiter $$
CREATE FUNCTION ex2(pegaData date) returns varchar(255) deterministic
begin 
declare resposta varchar(100);
case weekday(pegaData) 
when 0 then set resposta = "0 - segunda";
when 1 then set resposta = "1 - terça";
when 2 then set resposta = "2 - quarta";
when 3 then set resposta = "3 - quinta";
when 4 then set resposta = "4 - sexta";
when 5 then set resposta = "5 - sabado";
when 6 then set resposta = "6 - domingo";
end case;
return resposta;
end$$
delimiter ;
select distinct pd.codpedido, cl.nome, ex2(pd.datapedido) from pedido pd join cliente cl on pd.codcliente = cl.codcliente order by cl.nome asc ;

/*3. Crie uma função para retornar o gentílico dos clientes de acordo com o estado onde moram
(gaúcho, catarinense ou paranaense), o parâmetro de entrada deve ser a sigla do estado. Para
testar a função crie uma consulta que liste o nome do cliente e gentílico (função criada).*/
delimiter $$
create function ex3(unidFed varchar(3)) returns varchar(255) deterministic
begin

