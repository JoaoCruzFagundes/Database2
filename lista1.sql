/*) Mostre o nome dos Clientes e seu endereço completo, dos clientes que realizaram um pedido
no ano de 2015. ordene pela ordem alfabética. */
SELECT Nome, Endereco FROM cliente WHERE CodCliente in (SELECT CodCliente FROM pedido WHERE year(DataPedido) = 2015) ORDER BY Nome;

/*--Mostre o nome do produto e seu valor unitário. Somente devem ser exibidos os produtos que--
--tiveram pelo menos 5 e no máximo 7 itens em um único pedido. Ordene em ordem
--decrescente pelo valor unitário dos produtos. COM VISAO--*/
CREATE VIEW respostaquestao2 AS(
SELECT Descricao, ValorUnitario from produto where CodProduto IN
(select codproduto  from (select CodPedido, CodProduto, sum(quantidade) as total FROM itempedido group by CodPedido,CodProduto)
 temp where total>=5 and total <=7)ORDER BY ValorUnitario DESC );
 
 SELECT * FROM respostaquestao2;
 delete view from respostaquestao2;
 
 /*Mostre a quantidade de pedidos dos clientes que moram no RS ou em SC. , sum(pedido.CodPedido)*/
 SELECT  CodCliente from pedido where codCliente IN (SELECT CodCliente FROM cliente where uf like '%RS%' or '%SC%');  
 
 SELECT CodCliente  , count(uf)FROM cliente where uf like '%RS%' or '%SC%' in (SELECT  CodCliente from pedido where codCliente ) group by uf;