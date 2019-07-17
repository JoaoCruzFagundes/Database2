use compubras;
/*1) Exiba o código, o nome e o valor unitário dos produtos que tiveram mais 
que 9 unidades vendidas em apenas um pedido (note que não é o somatório total de
 unidades vendidas é apenas em um único pedido).*/
 select pr.codProduto,pr.descricao, pr.valorUnitario from produto pr where pr.codProduto in
 (select pr.codproduto from itempedido it join produto pr on it.codproduto = pr.codproduto where quantidade>9 )order by codproduto;
 
 /*2) Exiba o código, o nome do cliente, o endereço, a cidade, o cep, o estado e a IE
 dos clientes que efetuaram pedidos entre 25/09/2014 e 05/10/2015.*/
 
 select * from cliente cl ;
 
 select  pd.codcliente, pd.datapedido from pedido pd where year(datapedido)>2014 and year(datapedido)<2015 and month(datapedido)>9  