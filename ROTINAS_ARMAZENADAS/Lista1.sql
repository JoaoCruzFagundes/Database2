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
create function ex7(a double, b double, c double) returns varchar(255) not deterministic 
begin 
declare x double;
declare y double;
declare resposta7 varchar(255);
if ((b*b -4*a*c)>=0) then
set x =  (-b +SQRT(b*b -4*a*c))/(2*a);
set y = (-b -SQRT(b*b -4*a*c))/(2*a);
set resposta7 = concat("Resposta da operação é ",x," e ",y);
else set resposta7 = "Raizes não reais";
end if;
return resposta7;
end$$
delimiter ;
select ex7(7,8,0);
drop function ex7;

/*8. Crie uma função que retorne o valor total do salário de um vendedor (salário fixo + comissão
calculada). Note que esta função deve receber 3 valores de entrada, salário fixo, faixa de comissão
e o valor total vendido. Para testar essa função crie uma consulta que exiba o nome do vendedor e
o salário total.*/

delimiter $$
create function ex8(getSalario decimal(10,2), getFaixa varchar(2), gettotal double )
returns decimal(10,2) deterministic
begin 
declare resposta8 double;
case getFaixa 
when 'A' then return getSalario + (valor*0,20);
when 'B' then return getSalario + (valor*0,15);
when 'C' then return getSalario + (valor*0,1);
when 'D' then return getSalario + (valor*0,05);
else return -1;
end case;
end $$
delimiter ;
drop function ex8;

select ex8(SalarioFixo,FaixaComissao,total) as NovoSalario
from vendedor vd inner join pedido pd on vd.CodVendedor = pd.CodVendedor
inner join temp2 on pd.CodPedido = aux group by aux,pd.CodVendedor;

create view temp2 as (select sum(valor2) as total,aux from 
(select sum(quantidade)*ValorUnitario as valor2,CodPedido as aux from itempedido ip inner join produto pr
on pr.CodProduto = ip.CodProduto group by pr.CodProduto,ip.CodPedido order by aux) as temp group by aux);
select * from total;

drop view temp2;





/*9. DESAFIO 1: Crie uma função que receba um número IPv4 (Internet Protocol version 4) no formato
xxx.xxx.xxx.xxx e retorne a classe do mesmo e se é um IP válido ou inválido.*/
delimiter $$
CREATE FUNCTION ex9(ipv4 varchar(20)) returns varchar(50) deterministic
begin
declare inicio bigint;
declare radic varchar (255);
declare respostaDesafio varchar(2);
set inicio = instr(ipv4,'.');
select substring(ipv4,1,inicio) into radic;
if (inicio <4 || radic ) then set respostaDesafio = 'A'; 
end if;
return respostaDesafio;
end$$
delimiter ;
drop function ex9;
select ex9("1.168.0.0");



/*1. Crie uma função para calcular um aumento de 10% no salário dos vendedores de faixa de comissão
'A’. Considere o valor do salário fixo para calcular este aumento. Faça uma consulta select
utilizando essa função.*/
delimiter $$
CREATE FUNCTION aumento(idVendedor bigint) returns bigint deterministic
begin 
declare faixa varchar(2);
set faixa = (select vd.faixaComissao from vendedor vd where vd.codVendedor = idVendedor limit 1);
return faixa;
end $$
delimiter ;
drop function aumento;
select aumento(CodVendedor) from vendedor;


/*2. Crie uma função que retorne o código do produto com maior valor unitário.*/
delimiter $$
create procedure aumento(out cod bigint) deterministic 
begin
set cod = (select pr.codproduto from produto pr order by valorunitario desc limit 1);
end $$
delimiter ;
drop procedure aumento;
call aumento(@seila);
select @seila; 

/*3. Crie uma função que retorne o código, a descrição e o valor do produto com maior valor unitário. Os
valores devem ser retornados em uma expressão: “O produto com código XXX – XXXXXXXXX
(descrição) possui o maior valor unitário R$XXXX,XX”. Crie um select que utiliza esta função*/
delimiter $$
create procedure dados(out saida varchar(255)) deterministic 
begin
declare cod bigint;
declare descricao varchar(255);
declare preco decimal(10,2);
set cod = (select pr.codproduto from produto pr order by valorunitario desc limit 1);
set descricao = (select pr.descricao from produto pr order by valorunitario desc limit 1);
set preco = (select pr.valorunitario from produto pr order by valorunitario desc limit 1);
set saida = concat(cod, " - " , descricao," R$",preco);
end $$
delimiter ;
drop procedure dados;
call dados(@sei);
select @sei;



delimiter $$
create function dadosf(idproduto bigint, proddesc varchar(255), valor decimal(10,2))
returns respCompleta varchar(255) deterministic 
delimiter ;

select 
/*4. Crie uma função que receba como parâmetros o código do produto com maior valor unitário e o
código do produto com menor valor unitário. Utilize as funções dos exercícios 2 e 3. Retorne a
soma dos dois.*/
delimiter $$
create function somaValores(idCaro bigint, idBarato bigint) returns decimal(10,2) deterministic
begin
declare caro decimal(10,2);
declare barato decimal(10,2);
declare soma decimal(10,2);
set caro =(select valorunitario from produto where codproduto = idCaro);
set barato = (select valorunitario from produto where codproduto = idBarato);
set soma = (caro + barato);
return soma;
end $$
delimiter ;
select  somaValores(@seila,(select pr.codproduto from produto pr order by valorunitario asc limit 1)  ); 
/*5. Crie uma função que retorne a média do valor unitário dos produtos. Crie uma consulta que utilize
esta função.*/
delimiter $$
create function media(valor decimal(10,2)) returns decimal(10,2) deterministic 
begin
declare media decimal(10,2);
set media = (select avg(valor) from produto ) ;
return media;
end $$
delimiter ;
drop function media;
select media(pr.valorUnitario) from produto pr group by codproduto;


/*6. Faça uma função que retorna o código do cliente com a maior quantidade de pedidos um ano/mês.
Observe que a função deverá receber como parâmetros um ano e um mês. Deve ser exibido a
seguinte expressão: “O cliente XXXXXXX (cód) – XXXXXXX (nome) foi o cliente que fez a maior
quantidade de pedidos no ano XXXX mês XX com um total de XXX pedidos”.*/
delimiter $$
create function lista6(ano int, mes int) returns varchar(255) deterministic 
begin 
declare respostal6 varchar(255);
declare nomee varchar(255);
declare cod bigint;
declare quantPed bigint;
select cd.CodCliente, cd.nome, count(pd.CodPedidos) as ranking into cod,nomee,quantPed from
pedido pd inner join cliente cd on pd.codcliente = cd.codcliente where
month(Datapedido) = mes and year(Datapedido)=ano group by cd.CodCliente order by quantPed desc limit 1 ;
set respostal6 = concat("O cliente", cod, "-",nomee," foi o cliente que fez a maior quantidade de pedidos no ano",ano," mes ",mes,"com o total de pedidos de",quantPed,"pedidos");
return respostal6;
end $$
delimiter ;
drop function lista6;
select lista6(2015,08);
