/*1) Exiba o nome, endereço, cidade e o CEP dos clientes que moram em Santa Catarina e
que tenham pelo menos um pedido feito onde o prazo de entrega é entre 16 e 20 dias.*/ 
select cl.nome, cl.endereco, cl.cidade, cl.cep from cliente cl where uf like '%SC%' and cl.codcliente in
(select cl.codcliente from cliente cl join pedido pd on cl.codcliente =pd.codcliente where datediff(PrazoEntrega, DataPedido));

/*	2) Exiba o nome, endereço, cidade e o CEP dos clientes que moram no Rio Grande do Sul e
tenham pedidos realizados por algum vendedor que tenha o nome iniciando com a letra A.
Além disso deve ser exibido apenas os clientes que tiveram pedidos no ano de 2015.
A lista deve estar ordenada em ordem alfabética e sem clientes repetidos.*/
select cl.nome, cl.endereco, cl.cidade, cl.cep from cliente cl where cl.uf like 'RS' ;
select pd.
select v.nome as vendedor from vendedor v where v.nome like 'A%' 



