/*)1 Mostre o nome dos Clientes e seu endereço completo, dos clientes que realizaram um pedido
no ano de 2015. ordene pela ordem alfabética. */
SELECT Nome, Endereco FROM cliente WHERE CodCliente in (SELECT CodCliente FROM pedido WHERE year(DataPedido) = 2015) ORDER BY Nome;
/*-2-Mostre o nome do produto e seu valor unitário. Somente devem ser exibidos os produtos que--
--tiveram pelo menos 5 e no máximo 7 itens em um único pedido. Ordene em ordem
--decrescente pelo valor unitário dos produtos. COM VISAO--*/
CREATE VIEW respostaquestao2 AS(
SELECT Descricao, ValorUnitario from produto where CodProduto IN
(select codproduto  from (select CodPedido, CodProduto, sum(quantidade) as total FROM itempedido group by CodPedido,CodProduto)
 temp where total>=5 and total <=7)ORDER BY ValorUnitario DESC );
 
 SELECT * FROM respostaquestao2;
 delete view from respostaquestao2;
 
 /*M3ostre a quantidade de pedidos dos clientes que moram no RS ou em SC. , sum(pedido.CodPedido)*/
 SELECT count(pedido.CodPedido) from pedido where pedido.codCliente IN 
 (SELECT cliente.CodCliente FROM cliente where uf like '%RS%' or '%SC%') group by pedido.CodCliente;  
 
 /*4) Mostre o código do produto, o nome e o valor unitário dos produtos que 
 possuam pedidos para serem entregues entre os dias 01/12/2014 e 31/01/2015. Ordene a 
 lista pelo valor unitário decrescente dos produtos*/
 
 SELECT p.CodProduto, p.Descricao AS Nome , p.ValorUnitario AS preço FROM produto p Where p.CodProduto >any
 (select ip.CodPedido FROM itempedido ip Where ip.CodPedido IN 
 (select pd.CodPedido FROM pedido pd where PrazoEntrega between "2014/12/01" and "2015/01/31" )) order by p.ValorUnitario desc; 
 
 /*5) Exiba os dados dos clientes que fizeram pedidos com mais de 60 itens, observe que esta é a
quantidade total de itens, independentemente de serem produtos iguais ou diferentes. */
SELECT * from cliente c WHERE c.CodCliente >ANY
(select p.CodPedido FROM pedido p Where p.CodPedido IN 
(select it.CodPedido FROM itempedido it where it.quantidade>60));

/*6) Crie uma consulta que exiba o código do cliente, o nome do cliente e o número dos seus
pedidos ordenados pelo nome e posteriormente pelo código do pedido. Somente devem ser
exibidos os pedidos dos vendedores que possuem a faixa de comissão “A”. */
 SELECT distinct  c.CodCliente, c.Nome, p.CodPedido AS NumeroPedidos  
 FROM cliente c left join pedido p ON c.CodCliente = p.CodCliente where Codvendedor IN
( SELECT v.CodVendedor FROM vendedor v WHERE v.FaixaComissao like 'A') order by c.nome, p.CodPedido;

/*7) Crie uma consulta que exiba o nome do cliente, endereço, cidade, UF, CEP, código do pedido
e prazo de entrega dos pedidos que NÃO sejam de vendedores que ganham menos de R$
1500,00.*/
SELECT distinct c.Nome, c.Endereco, c.Cidade, c.Uf, c.Cep, p.CodPedido, p.PrazoEntrega 
FROM cliente c inner join pedido p on c.CodCliente = p.CodCliente Where p.CodVendedor in
(SELECT v.CodVendedor FROM vendedor v WHERE v.SalarioFixo > 1500)  order by c.Nome asc;

/*8) Crie uma consulta que exiba o nome do cliente, cidade e estado, dos clientes que fizeram
algum pedido no ano de 2015. Ordene os resultados pelos nomes dos clientes em ordem
alfabética*/

SELECT c.Nome, c.cidade,c.Uf FROM cliente c WHERE c.CodCliente IN 
(select p.CodCliente from pedido p where year(DataPedido) =2015) order by c.Nome asc;

/*9) Crie uma consulta que exiba o código do pedido e o somatório da quantidade de itens desse
pedido. Devem ser exibidos somente os pedidos em que o somatório das quantidades de itens
de um pedido seja maior que a média da quantidade de itens de todos os pedidos. */

select ip.CodPedido, quantidade
from itempedido ip where quantidade >any (select avg(quantidade) from itempedido);

/*10) Crie uma consulta que exiba o nome do cliente, o nome do vendedor de seu último pedido e o
estado do cliente. Devem ser exibidos apenas os clientes do Rio Grande do Sul e apenas o
último vendedor. */

select c.nome as comprador,v.nome AS vendedor from cliente c 
right join pedido p on  p.CodCliente=c.codCliente 
right join vendedor v on p.CodVendedor = v.Codvendedor 
where uf like 'RS' and DataPedido in 
(select max(DataPedido) from pedido p group by DataPedido) ;

/*11) Selecione o nome do produto e o valor unitário dos produtos que possuem o valor unitário
maior que todos os produtos que comecem com a letra L. A lista deve ser ordenada em ordem
alfabética*/

select distinct p.descricao, p.ValorUnitario  from produto p where p.ValorUnitario >all
(select  sum(ValorUnitario) from produto p where descricao like 'L%' and 'l%' group by CodProduto) order by p.descricao asc;

/*12) Selecione o código do produto, o nome do produto e o valor unitário dos produtos que
possuam pelo menos um pedido com mais de 9 itens em sua quantidade. A lista deve ser
ordenada pelo valor unitário em ordem decrescente.*/
select * from produto pr where pr.CodProduto IN 
(select it.CodPedido from itempedido it Where quantidade >9) order by pr.ValorUnitario asc;

/*13) Selecione o código do vendedor e o nome dos vendedores que não tenham vendido nenhum
pedido com prazo de entrega em Agosto de 2015. A lista deve ser ordenada pelo nome dos
vendedores em ordem alfabética.*/
select distinct p.CodVendedor ,v.nome as vendedores from vendedor v inner join pedido p on v.CodVendedor = p.CodVendedor where p.CodPedido !=any
(select Codpedido from pedido  where year(PrazoEntrega)=2015 and month(PrazoEntrega)=8) order by vendedores asc; 

/*14) Selecione o código do cliente e o nome dos clientes que tenham feitos pedidos em Abril de
2014. A lista deve ser ordenada pelo nome dos clientes em ordem alfabética*/

select distinct c.CodCliente, c.Nome from cliente c where c.codCliente in 
(select p.codcliente from pedido p where year(DataPedido)=2014 and month(DataPedido) =8) order by c.nome asc;