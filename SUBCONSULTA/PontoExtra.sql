/*10) Crie uma consulta que retorne o nome do cliente
 e o total comprado por este no ano de 2014 e no ano de 2015.
 
 A consulta também deve retornar o saldo da diferença entre o total 
 comprado no ano de 2015 e o total de 2014, ordenada por este saldo.
 
 Não preocupe-se com os saldos que por eventualidade possuam o valor
 null. DICA: a sub-consulta será no lugar de uma tabela,
 ademais podem haver várias sub-consultas para as colunas desta tabela. */

SELECT c.nome,
       (pedido2014.soma + pedido2015.soma) AS "Total da soma",
       (pedido2014.soma - pedido2015.soma) AS "Diferenca"
FROM cliente c
INNER JOIN
  (SELECT sum(it.quantidade * pr.ValorUnitario) AS soma,
          pd.codCliente
   FROM pedido pd
   INNER JOIN itempedido it ON it.codPedido = pd.CodPedido
   INNER JOIN produto pr ON it.CodProduto = pr.CodProduto
   AND year(pd.dataPedido) = 2014
   GROUP BY pd.codCliente) AS pedido2014 ON c.CodCliente = pedido2014.CodCliente
INNER JOIN
  (SELECT sum(it.quantidade * pr.ValorUnitario) AS soma,
          pd.codCliente
   FROM pedido pd
   INNER JOIN itempedido it ON it.codPedido = pd.CodPedido
   INNER JOIN produto pr ON it.CodProduto = pr.CodProduto
   AND year(pd.dataPedido) = 2015
   GROUP BY pd.codCliente) AS pedido2015 ON c.CodCliente = pedido2015.CodCliente
ORDER BY diferenca DESC;

 