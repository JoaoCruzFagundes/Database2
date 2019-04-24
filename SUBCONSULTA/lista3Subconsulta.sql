use compubras;
/*1) Exiba o nome, endereço, cidade e o CEP dos clientes que moram em Santa Catarina e
que tenham pelo menos um pedido feito onde o prazo de entrega é entre 16 e 20 dias.*/ 
select cl.nome, cl.endereco, cl.cidade, cl.cep from cliente cl where uf like '%SC%' and cl.codcliente in
(select cl.codcliente from cliente cl join pedido pd on cl.codcliente =pd.codcliente where datediff(PrazoEntrega, DataPedido));

/*	2) Exiba o nome, endereço, cidade e o CEP dos clientes que moram no Rio Grande do Sul e
tenham pedidos realizados por algum vendedor que tenha o nome iniciando com a letra A.
Além disso deve ser exibido apenas os clientes que tiveram pedidos no ano de 2015.
A lista deve estar ordenada em ordem alfabética e sem clientes repetidos.*/
select cl.nome, cl.endereco, cl.cidade, cl.cep from cliente cl  where cl.uf like 'RS' and cl.codcliente in
(select pd.codCliente from pedido pd where year(datapedido)=2015 and pd.codpedido in
(select pd.codpedido from vendedor v join pedido pd on v.codvendedor = pd.codvendedor where v.nome like 'A%'));

/*3) Exiba o nome, salário e a faixa de comissão dos vendedores que recebem mais que R$ 
1800,00 que tenham realizado algum pedido em Dezembro de 2014 para clientes que moram 
ou em Santa Catarina ou no Rio Grande do Sul. (2 sub-consultas)*/
create view pesquisa as select distinct v.nome, v.salarioFixo, v.faixaComissao from vendedor v where v.salarioFixo >1800 in
(select pd.codvendedor from pedido pd where year(dataPedido)=2014 and month(dataPedido)=12 and pd.codcliente in
(select pd.codcliente from pedido pd right join cliente cl on cl.codcliente = pd.codcliente where cl.uf like 'SC' OR 'RS'));

/*4) Exiba um ranking contendo o nome e o total de vendas efetuadas por vendedor durante o ano de 2015.
 Note que não devem aparecer vendedores que efetuaram nenhuma venda no ano*/
 select distinct v.nome, temp.total from vendedor v join 
 (select pd.codvendedor , pd.codpedido ,sum(quantidade* valorUnitario) as total from produto pr join itempedido it on pr.codProduto = it.codProduto
 inner join pedido pd on pd.codpedido = it.codpedido group by pd.codpedido) as temp on v.codvendedor = temp.codvendedor group by v.nome;
 
 /*5) Exiba um ranking contendo o nome e o total de pedidos efetuados por cliente durante todo o tempo da empresa*/
 select cl.nome, temp.total from cliente cl  join
 (select cl.codcliente, count(codPedido) as total from cliente cl 
 join pedido pd on cl.codcliente = pd.codcliente group by cl.CodCliente) as temp
 on cl.codcliente = temp.codcliente order by temp.total desc;
 
 /*6) Exiba o nome e a comissão dos vendedores. 
 A consulta externa deverá ser na tabela vendedor e existem duas sub-consultas (uma dentro da outra). 
 A lista deve ser ordenada pelo valor das comissões. 
 Além disso, as comissões devem ter o valor exibido arredondado (2 números depois da vírgula), 
 a comissão para todos os vendedores é 10% do total vendido.*/
 select v.nome ,  comissao from vendedor v where codvendedor in
 (select round(temp.total,2) as comissao from pedido pd join 
 (select it.codPedido, sum(quantidade*valorUnitario)*0.10 as total from produto pr join 
 itempedido it on pr.codproduto = it.codproduto group by it.CodPedido) as temp on pd.codpedido = temp.codpedido group by codvendedor);
 
 /*7) Exiba um ranking com o nome do cliente e o total comprado por este cliente no ano de 2015. 
 Os clientes que devem integrar o ranking devem morar no Rio Grande do Sul ou em Santa Catarina.
 Além disso, o total devem ter o valor exibido arredondado (2 números depois da vírgula).
 A consulta externa é em cliente.*/
 select cl.nome, total from cliente cl inner join pedido pd on pd.codcliente = cl.codcliente join 
 (select it.codpedido ,round(coalesce(sum(quantidade*valorUnitario)*0.10, 0),2) as total from produto pr join 
 itempedido it on pr.codproduto = it.codproduto group by it.CodPedido ) 
 as temp on pd.codpedido = temp.codpedido where cl.uf like 'RS' or 'SC' ;
 
 /*8) Exiba um ranking com o nome do vendedor e o total vendido por ele no ano de 2014. 
 Além disso, o total devem ter o valor exibido arredondado (2 números depois da vírgula).
 A consulta externa é em vendedor*/
 
 
 
 
 /*9) Exiba o código do produto, nome e a quantidade vendida dos produtos que tiveram pedido s entre os dias 12/08/2014 e 27/10/2014.
 Os resultados devem ser ordenados pela quantidade e a consulta externa é na tabela produto.
*/
 
 
