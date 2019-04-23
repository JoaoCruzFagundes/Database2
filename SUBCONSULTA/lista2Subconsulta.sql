use compubras;
/*1) Crie uma consulta que exiba o código do cliente, o nome do cliente e o número dos seus
pedidos ordenados pelo nome e posteriormente pelo código do pedido. Somente devem
ser exibidos os pedidos dos vendedores que possuem a faixa de comissão “A”.*/
 /*select cl.nome, cl.codCliente, pr.descricao, pd.codPedido, v.FaixaComissao from cliente cl 
 inner join pedido pd on cl.codCliente = pd.codCliente 
inner join itempedido it on it.codpedido = pd.codpedido
inner join produto pr on pr.codProduto = it.codProduto
inner join vendedor v on pd.codvendedor = v.codvendedor where v.CodVendedor IN 
(SELECT CodVendedor from vendedor v where FaixaComissao like 'A') order by descricao, codPedido;*/

select cl.codcliente, cl.nome, pd.codPedido from cliente cl join pedido pd on cl.CodCliente =pd.CodCliente 
inner join itempedido it on it.codpedido = pd.codpedido
inner join produto pr on pr.codProduto = it.codProduto where cl.codcliente in
(select cl.codcliente from cliente cl join pedido pd on pd.CodCliente =cl.CodCliente join vendedor v on v.CodVendedor =pd.CodVendedor
where v.FaixaComissao like 'A') order by pr.descricao, pd.CodPedido ;


/*2) Crie uma consulta que exiba o nome do cliente, endereço, cidade, UF, CEP, código do
pedido e prazo de entrega dos pedidos que NÃO sejam de vendedores que ganham
menos de R$ 1500,00*/

SELECT distinct cl.nome, cl.endereco,cl.cidade,cl.uf, cl.cep, pd.codpedido,pd.prazoEntrega from cliente cl inner join pedido pd
on pd.CodCliente = cl.CodCliente where codPedido IN 
(select CodPedido from pedido where codVendedor IN 
(select codVendedor from vendedor where salarioFixo < 1500)) ORDER BY cl.nome,codPedido ASC;

/*3) Crie uma consulta que exiba o nome do cliente, cidade e estado, 
dos clientes que fizeram algum pedido no ano de 2015. Ordene os resultados pelos 
nomes dos clientes em ordem alfabética*/
SELECT distinct cl.nome, cl.cidade,cl.uf from cliente cl where CodCliente IN 
(select codpedido from pedido pd where year(datapedido) = 2015);


/*4) Crie uma consulta que exiba o código do pedido e o somatório da quantidade de itens desse pedido. 
Devem ser exibidos somente os pedidos em que o somatório 
das quantidades de itens de um pedido seja maior que a média da quantidade de itens de todos os pedidos. */
select pd.codpedido ,count(Quantidade) as total2 from pedido pd join 
itempedido it on pd.codpedido = it.codpedido where total >
(select  avg(total) as media from pedido pd inner join 
(select pd.codpedido ,count(Quantidade) as total from pedido pd join 
itempedido it on pd.codpedido = it.codpedido group by pd.CodPedido)
 as temp on pd.Codpedido = temp.codPedido group by pd.codPedido) group by pd.CodPedido;
 
 /*5) Crie uma consulta que exiba o nome do cliente, o nome do vendedor de seu último pedido e o estado do cliente.
 Devem ser exibidos apenas os clientes do Rio Grande do Sul e apenas o último vendedor*/
 
 select cl.nome, v.nome, max(DataPedido) as ultimopedido from cliente cl inner join pedido pd on cl.Codcliente = pd.Codcliente 
 inner join vendedor v on pd.CodVendedor = v.CodVendedor where cl.uf like '%RS%'
group by cl.nome;

/*6) Crie uma consulta que exiba o nome do cliente, o nome do vendedor de seu primeiro pedido e o estado do cliente.
 Devem ser exibidos apenas os clientes de Santa Cataria e apenas o primeiro vendedor. */
 
select cl.nome, v.nome, min(DataPedido) as primeiro from pedido pd inner join vendedor v on v.CodVendedor = pd.CodVendedor 
right join cliente cl on cl.CodCliente = pd.CodCliente  where cl.CodCliente in 
(select cl.codCliente from cliente cl where uf like '%SC%' )group by cl.nome ; 

/*7) Selecione o nome do produto e o valor unitário dos produtos que possuem o valor
 unitário maior que todos os produtos que comecem com a letra L.
 A lista deve ser ordenada em ordem alfabética. */
 
 select pr.descricao, pr.valorUnitario from produto pr where pr.valorUnitario >any
 (select sum(valorUnitario) from produto pr where descricao like 'L%' group by CodProduto);
 
 /*8) Selecione o código do produto, o nome do produto e o 
 valor unitário dos produtos que possuam pelo menos um pedido com mais de 9 itens em sua quantidade. 
 A lista deve ser ordenada pelo valor unitário em ordem decrescente. */
 
 select pr.CodProduto, pr.Descricao, pr.ValorUnitario from produto pr where pr.CodProduto in 
 (select distinct pr.CodProduto from produto pr join itempedido it on it.codProduto = pr.codProduto where it.Quantidade >9 ) 
 order by valorUnitario desc;
 
 /*9) Selecione o código do vendedor e o 
 nome dos vendedores que não tenham vendido nenhum pedido com prazo de entrega em Agosto de 2015.
 A lista deve ser ordenada pelo nome dos vendedores em ordem alfabética. */
 
 select v.codvendedor, v.nome from vendedor v where v.nome in
( select distinct v.nome from vendedor v join pedido pd on v.Codvendedor =pd.Codvendedor 
 where year(PrazoEntrega)<>2015 and month(PrazoEntrega)<> 8) order by v.nome asc;
 
 /*10)  Selecione o código do cliente e o nome dos clientes que tenham feitos pedidos em Abril de 2014.
 A lista deve ser ordenada pelo nome dos clientes em ordem alfabética */
 select cl.codCliente, cl.nome from cliente cl where cl.nome in
 (select distinct cl.nome from cliente cl right join pedido pd  on cl.CodCliente = pd.CodCliente 
 where year(PrazoEntrega)<>2014 and month(PrazoEntrega)<> 4) order by cl.nome asc;
 



