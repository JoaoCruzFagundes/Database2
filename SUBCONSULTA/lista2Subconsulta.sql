use compubras;
/*1) Crie uma consulta que exiba o código do cliente, o nome do cliente e o número dos seus
pedidos ordenados pelo nome e posteriormente pelo código do pedido. Somente devem
ser exibidos os pedidos dos vendedores que possuem a faixa de comissão “A”.*/
select cl.nome, cl.codCliente, pr.descricao, pd.codPedido, v.FaixaComissao from cliente cl 
inner join pedido pd on cl.codCliente = pd.codCliente 
inner join itempedido it on it.codpedido = pd.codpedido
inner join produto pr on pr.codProduto = it.codProduto
inner join vendedor v on pd.codvendedor = v.codvendedor where v.CodVendedor IN 
(SELECT CodVendedor from vendedor v where FaixaComissao like 'A') order by descricao, codPedido;

/*2) Crie uma consulta que exiba o nome do cliente, endereço, cidade, UF, CEP, código do
pedido e prazo de entrega dos pedidos que NÃO sejam de vendedores que ganham
menos de R$ 1500,00*/