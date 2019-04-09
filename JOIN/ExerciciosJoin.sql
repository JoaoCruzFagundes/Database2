/*1) Mostrar a quantidade pedida para um determinado produto com um determinado
código a partir da tabela item de pedido.*/
select distinct it.quantidade, pr.descricao from 
itempedido it inner join produto pr on it.CodProduto= pr.CodProduto;

/*2) Listar a quantidade de produtos que cada pedido contém.*/
select count(it.Quantidade) AS total from itempedido it 
join pedido pd on it.CodPedido = pd.CodPedido GROUP BY it.CodPedido; 

/*3) Ver os pedidos de cada cliente, listando nome do cliente e número do pedido*/
select distinct cl.nome, pd.CodPedido from pedido pd 
inner join cliente cl on pd.CodCliente = cl.Codcliente;

/*4) Listar todos os clientes com seus respectivos pedidos. Os clientes que não têm
pedidos também devem ser apresentados.*/
select distinct cl.nome, pd.CodPedido from pedido pd 
right join cliente cl on pd.codcliente = cl.codcliente order by cl.nome asc;

/*5) Clientes com prazo de entrega superior a 10 dias e que pertençam aos estados do
Rio Grande do Sul ou Santa Catarina.*/
select cl.nome, cl.uf, pd.PrazoEntrega as entrega_em from pedido pd 
right join cliente cl on pd.codcliente=cl.codcliente 
where datediff(PrazoEntrega,DataPedido)>10 and cl.uf like '%RS%' or '%SC%'  ;

/*6) Mostrar os clientes e seus respectivos prazos de entrega, 
ordenando do maior para o menor.*/
select cl.nome, pd.prazoEntrega from pedido pd 
left join cliente cl on pd.codcliente = cl.codcliente order by pd.prazoEntrega desc; 

/*7) Apresentar os vendedores, em ordem alfabética, que emitiram pedidos com prazos
de entrega superiores a 15 dias e que tenham salários fixos iguais ou superiores a
R$ 1.000,00*/
select distinct v.nome, v.SalarioFixo as salario, pd.CodPedido from pedido pd 
left join vendedor v on pd.Codvendedor = v.CodVendedor 
WHERE datediff(PrazoEntrega,DataPedido) >15 and v.SalarioFixo>1000;

/*8) Os vendedores têm seu salário fixo acrescido de 20% da soma dos valores dos
pedidos. Faça uma consulta que retorne o nome dos funcionários e o total de
comissão, desses funcionários.*/
select v.nome, 0,2*sum(pr.ValorUnitario * it.Quantidade) as comissao from vendedor v 
inner join  pedido pd on v.codvendedor =pd.codvendedor 
right join itempedido it on pd.codpedido=it.codpedido 
inner join produto pr on pr.Codproduto = it.codproduto group by v.codVendedor order by v.nome asc ; 

/*9) Os clientes e os respectivos vendedores que fizeram algum pedido para esse
cliente, juntamente com a data do pedido.*/
select cl.nome as clientes, v.nome as vendedores,pd.DataPedido from pedido pd 
left join vendedor v on pd.codvendedor = v.codvendedor 
inner join cliente cl on cl.codcliente = pd.codcliente;

/*10) Liste o nome do cliente e a quantidade de pedidos de cada cliente*/
select cl.nome, count(pd.CodPedido) as npedidos from cliente cl left join pedido pd on cl.codCliente = pd.codCliente group by cl.codCliente;

/*11) Liste o nome do cliente, o código do pedido e a quantidade total de produtos por
pedido.*/
select cl.nome ,pd.CodPedido, count(it.quantidade) as produtos from pedido pd 
left join cliente cl on pd.codCliente = cl.codCliente 
inner join itempedido it on pd.codPedido = it.Codpedido group by cl.nome;

/*12) Liste o nome do cliente, o código do pedido e o valor total do pedido*/
select cl.nome, pd.CodPedido, sum(pr.ValorUnitario*it.Quantidade) as totalAPagar from pedido pd 
inner join cliente cl on pd.CodCliente = cl.CodCliente 
right join itempedido it on it.Codpedido=pd.CodPedido 
inner join produto pr on it.CodProduto =pr.CodProduto group by cl.nome;

/*13) Liste os produtos, a quantidade vendida e a data dos pedidos realizados no mês de
maio de 2015, começando pelos mais vendidos.*/
select pr.Descricao, count(quantidade) as pedidosTotais, pd.DataPedido from produto pr 
inner join itempedido it on pr.CodProduto = it.CodProduto 
inner join pedido pd on it.CodPedido = pd.CodPedido group by pr.Descricao;

/* 14) Liste os produtos, do mais caro para o mais barato, dos pedidos no mês de junho
(considerando todos os anos)*/
select pr.descricao, pr.valorunitario, pd.datapedido from pedido pd 
right join itempedido it on it.CodPedido =pd.CodPedido 
inner join produto pr on it.CodProduto = pr.CodProduto 
where month(DataPedido)=5 order by pr.ValorUnitario asc;

/*15) Exiba a relação dos pedidos mais caros de todos os tempos. Esta relação deve
conter o nome do cliente, do vendedor, o código do pedido e o valor total do pedido.*/ 
select cl.nome, v.nome, pd.codpedido, sum(Quantidade*ValorUnitario) as total from pedido pd 
left join vendedor v on pd.codvendedor = v.codvendedor 
inner join cliente cl on pd.codcliente = cl.codcliente 
right join itempedido it on it.codpedido = pd.codpedido 
inner join produto pr on it.codproduto = pr.codproduto group by cl.nome order by total desc limit 10;

/*16) Exiba a relação com os melhores vendedores (considerando apenas a quantidade
de pedidos) para o mês de setembro (incluindo todos os anos). Exiba o nome do
vendedor, o ano e o número total de pedidos daquele ano.*/
select v.nome, pd.DataPedido, count(pd.CodPedido) as vendas from pedido pd 
left join vendedor v on pd.CodVendedor= v.CodVendedor 
where month(DataPedido) = 9 group by v.nome order by vendas desc limit 10;

/*17) Liste o nome dos clientes e o total de pedidos de cada cliente, em ordem crescente
de pedidos. Os clientes sem pedidos também devem ser listados.*/
select cl.nome, count(pd.CodPedido) as carrinhos  from pedido pd 
right join cliente cl on pd.codcliente = cl.codcliente group by cl.nome order by carrinhos asc;

/*18) Exiba uma relação em ordem alfabética do código do cliente e nome dos clientes
que nunca fizeram nenhum pedido*/
select cl.CodCliente, cl.nome, pd.CodPedido as total from pedido pd 
inner join cliente cl on pd.codcliente =cl.codcliente where pd.Codpedido is null order by cl.nome asc ;

/*19) Mostre o código do produto, a descrição e o valor total obtido por cada produto ao
longo da história da loja. Ordene a lista pelo valor total dos produtos. Observe que
mesmo os produtos que nunca foram vendidos devem ser exibidos.*/
select pr.CodProduto, pr.Descricao, sum(ValorUnitario*Quantidade) as valorRendido from produto pr
left join itempedido it on pr.codProduto = it.CodProduto group by pr.CodProduto order by valorRendido asc;

/*20) Mostre todos os dados dos vendedores e a quantidade total de pedidos efetuados
por cada vendedor. A relação deve contar apenas os vendedores de faixa de
comissão “A” e ordenados pela quantidade total de pedidos. Mesmo os vendedores
sem pedidos devem ser listados.*/
select v.*, count(pd.CodPedido) as pedidos from pedido pd 
right join vendedor v on pd.CodVendedor = v.CodVendedor 
where FaixaComissao like 'A' group by v.CodVendedor order by pedidos asc; 
