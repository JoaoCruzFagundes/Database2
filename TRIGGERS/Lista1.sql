use compubras;
Use DB;
/*Valida o nome com quantidade de caracteres maior ou igual a 4 (quatro).*/
delimiter $$
create trigger nomeMaiorQueQuatro before insert on cliente
for each row
begin
set @nome = new.cliente.nome;
if (char_length(@nome) <= 4 or @nome = '') then
	set @nome = null;
end if; 
end$$ 
delimiter ;

-- Test with other DB
CREATE TABLE produtos (

referencia varchar(3) primary key,
descricao varchar(50) unique,
estoque int not null default 0

);
insert into produtos values ('001', 'Feijão', 10);
INSERT INTO Produtos VALUES ('002', 'Arroz', 5); 
INSERT INTO Produtos VALUES ('003', 'Farinha', 15);

CREATE TABLE ItensVenda ( 

Venda INT,
Produto VARCHAR(3), 
Quantidade INT 

);

/*Ao inserir e remover registro da tabela ItensVenda, o estoque do produto referenciado deve ser alterado na tabela Produtos. */
delimiter $$
create trigger vende before insert on produtos
for each row
begin
if(Estoque !=0) then
update produtos set estoque = estoque - NEW.Quantidade where referencia = new.produto;
end if;
end $$
delimiter ;

/*1) Faça um gatilho que só permita cadastrar clientes onde a UF seja válida.*/

delimiter $$
create function validaEstado(estado varchar(5)) returns boolean deterministic
begin
declare estado varchar(5);
case  estado
when "RS" then return true;
when "SC" then return true;
when "AC" then return true;
when "AL" then return true;
when "AP" then return true;
when "AM" then return true;
when "BA" then return true;
when "CE" then return true;
when "DF" then return true;
when "ES" then return true;
when "GO" then return true;
when "MA" then return true;
when "MT" then return true;
when "MS" then return true;
when "MG" then return true;
when "PA" then return true;
when "PB" then return true;
when "PR" then return true;
when "PE" then return true;
when "PI" then return true;
when "RJ" then return true;
when "RN" then return true;
when "RO" then return true;
when "RR" then return true;
when "SP" then return true;
when "SE" then return true;
when "TO" then return true;
else return false;
end case;
end$$
delimiter ;

delimiter $$
create trigger checaEstado before insert on cliente
for each row 
begin
if 
end $$
delimiter ;