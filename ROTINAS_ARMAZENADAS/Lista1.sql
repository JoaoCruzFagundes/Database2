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
declare resposta2 varchar(100);
case weekday(pegaData) 
when 0 then set resposta2 = "0 - segunda";
when 1 then set resposta2 = "1 - terça";
when 2 then set resposta2 = "2 - quarta";
when 3 then set resposta2 = "3 - quinta";
when 4 then set resposta2 = "4 - sexta";
when 5 then set resposta2 = "5 - sabado";
when 6 then set resposta2 = "6 - domingo";
end case;
return resposta;
end$$
delimiter ;
select distinct pd.codpedido, cl.nome, ex2(pd.datapedido) from pedido pd join cliente cl on pd.codcliente = cl.codcliente order by cl.nome asc ;
select * from cliente;
/*3. Crie uma função para retornar o gentílico dos clientes de acordo com o estado onde moram
(gaúcho, catarinense ou paranaense), o parâmetro de entrada deve ser a sigla do estado. Para
testar a função crie uma consulta que liste o nome do cliente e gentílico (função criada).*/
delimiter $$
create function ex3(unidFed varchar(3)) returns varchar(255) deterministic
begin
declare resposta3 varchar(100);
case unidFed 
when "RS" then set resposta3 = "Rio Grande do Sul";
when "SC" then set resposta3 = "Santa Catarina";
when "AC" then set resposta3 = "Acre";
when "AL" then set resposta3 = "Alagoas";
when "AP" then set resposta3 = "Amapa";
when "AM" then set resposta3 = "Amazonas";
when "BA" then set resposta3 = "Bahia";
when "CE" then set resposta3 = "Ceara";
when "DF" then set resposta3 = "Distrito Federal";
when "ES" then set resposta3 = "Espirito Santo";
when "GO" then set resposta3 = "Goiais";
when "MA" then set resposta3 = "Maranhão";
when "MT" then set resposta3 = "Mato Grosso";
when "MS" then set resposta3 = "Mato Grosso do Sul";
when "MG" then set resposta3 = "Minas Gerais";
when "PA" then set resposta3 = "Pará";
when "PB" then set resposta3 = "Paraíba";
when "PR" then set resposta3 = "Paraná";
when "PE" then set resposta3 = "Pernambuco";
when "PI" then set resposta3 = "Piauí";
when "RJ" then set resposta3 = "Rio de Janeiro";
when "RN" then set resposta3 = "Rio Grande do Norte";
when "RO" then set resposta3 = "Rondônia";
when "RR" then set resposta3 = "Roraima";
when "SP" then set resposta3 = "São Paulo";
when "SE" then set resposta3 = "Sergipe";
when "TO" then set resposta3 = "Tocantins";
END case;
return resposta3;
end$$
delimiter ;
select cd.nome, ex3(cd.uf) as Estado from cliente cd;

drop function ex3;

/*4. Crie uma função que retorne a Inscrição Estadual no formato #######-##. Para testar a função
criada exiba os dados do cliente com a IE formatada corretamente utilizando a função criada.*/
delimiter $$
CREATE FUNCTION ex4(ie varchar(9)) returns varchar(10)  deterministic
begin
declare parte1 varchar(7);
declare parte2 varchar(2);
declare resposta4 varchar(20);
select substring(ie,1,7) into parte1;
select substring(ie,8,9) into parte2;
set resposta4 = concat(parte1,"-",parte2);
return resposta4;
end$$
delimiter ;

select cd.nome, ex4(cd.ie) from cliente cd;

/*5. Crie uma função que retorne o tipo de envio do pedido, se for até 3 dias será enviado por SEDEX,
se for entre 3 e 7 dias deverá ser enviado como encomenda normal, caso seja maior que este prazo
deverá ser utilizado uma encomenda não prioritária. Como dados de entrada recebe a data do
pedido e o prazo de entrega e o retorno será um varchar. Note que para criar esta função você
deverá utilizar a cláusula IF.*/

delimiter $$
CREATE FUNCTION ex5(pegaDataPedido date, pegaPrazoEntrega date) returns varchar(255) not deterministic
begin
declare resposta5 varchar(255) ;
declare diasEntrega bigint;
set diasEntrega = datediff(pegaPrazoEntrega,pegaDataPedido);
if (diasEntrega <= 3) then set resposta5 = "Enviado por Sedex";
elseif (diasEntrega>3 && diasEntrega <7) then set resposta5 = "Encomenda normal";
else set resposta5 = "Entrega não prioritaria";
end if;
return resposta5;
end$$
delimiter ;
select ex5(PrazoEntrega,DataPedido) as entrega from pedido;
select datediff(PrazoEntrega,DataPedido) from pedido;
drop function ex5;

/*6. Crie uma função que faça a comparação entre dois números inteiros. Caso os dois números sejam
iguais a saída deverá ser “x é igual a y”, no qual x é o primeiro parâmetro e y o segundo parâmetro.
Se x for maior, deverá ser exibido “x é maior que y”. Se x for menor, deverá ser exibido “x é menor
que y”.*/

delimiter $$
create function ex6(x int ,y int) returns varchar(255) not deterministic
begin
declare resposta6 varchar(255) ;
if (x>y) then set resposta6 = "X é maior que Y";
elseif (x<y) then set resposta6 = "X é menor que Y";
else set resposta6 = "X é igual a Y";
end if;
return resposta6;
end$$
delimiter ;

/*7. Crie uma função que calcule a fórmula de bhaskara. Como parâmetro de entrada devem ser
recebidos 3 valores (a, b e c). Ao final a função deve retornar “Os resultados calculados são x e y”,
no qual x e y são os valores calculados.*/

delimiter $$
create function ex7(a double, b double, c double) returns 
