/*10) Crie uma consulta que retorne o nome do cliente
 e o total comprado por este no ano de 2014 e no ano de 2015.
 
 A consulta também deve retornar o saldo da diferença entre o total 
 comprado no ano de 2015 e o total de 2014, ordenada por este saldo.
 
 Não preocupe-se com os saldos que por eventualidade possuam o valor
 null. DICA: a sub-consulta será no lugar de uma tabela,
 ademais podem haver várias sub-consultas para as colunas desta tabela. */
 use compubras;
 select distinct cl.nome , sum(total2014 + total2015) as total from cliente cl 
 inner join pedido pd on cl.CodCliente = pd.CodCliente inner join itempedido it on it.codPedido = pd.CodPedido 
inner join produto pr on it.CodProduto = pr.CodProduto where pd.CodPedido in 
(select pd.CodPedido sum(it.quantidade*pr.valorUnitario) as total2014 from  pedido pd where year(dataPedido) = 2014 group by pd.CodPedido  
(select pd.CodPedido sum(it.quantidade*pr.valorUnitario) as total2015 from  pedido pd where year(dataPedido) = 2015)group by pd.CodPedido) 
group by cl.codCliente;

 
 
 select distinct cl.nome , sum(it.quantidade*pr.valorUnitario) as soma from cliente cl 
 inner join pedido pd on cl.CodCliente = pd.CodCliente inner join itempedido it on it.codPedido = pd.CodPedido 
 inner join produto pr on it.CodProduto = pr.CodProduto where pd.CodPedido in 
 (select  sum(it.quantidade*pr.valorUnitario) as temp2 from pedido pd where year(dataPedido) = 2014 or pd.CodPedido in
 (select  sum(it.quantidade*pr.valorUnitario) as temp from pedido pd where year(dataPedido) = 2015)  ) 
 group by cl.codCliente;
 
 
 
 
 select distinct cl.nome , sum(it.quantidade*pr.valorUnitario) as soma from cliente cl 
 inner join pedido pd on cl.CodCliente = pd.CodCliente inner join itempedido it on it.codPedido = pd.CodPedido 
 inner join produto pr on it.CodProduto = pr.CodProduto left join  
 (select  sum(it.quantidade*pr.valorUnitario) as temp2 from pedido pd where year(dataPedido) = 2014 or pd.CodPedido in
 (select  sum(it.quantidade*pr.valorUnitario) as temp from pedido pd where year(dataPedido) = 2015)) temp on it.codproduto = temp.codProduto 
 group by cl.codCliente;
 

 

 