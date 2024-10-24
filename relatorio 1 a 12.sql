-- Relatorio1

SELECT 
    e.nome AS nome_empregado, 
    e.cpf AS cpf_empregado, 
    e.dataAdm AS Data_Admissao, 
    e.salario AS Salario, 
    d.nome AS departamento, 
    t.numero AS Numero_Telefone  
FROM 
    empregado e
JOIN 
    departamento d ON e.Departamento_idDepartamento = d.idDepartamento
LEFT JOIN 
    telefone t ON e.cpf = t.Empregado_cpf  
WHERE 
    e.dataAdm BETWEEN '2019-01-01' AND '2022-03-31'
ORDER BY 
    e.dataAdm DESC;
    

-- Relatorio 2

SELECT 
    e.nome AS nome_empregado, 
    e.cpf AS cpf_empregado, 
    e.dataAdm AS Data_Admissao, 
    e.salario AS Salario, 
    d.nome AS departamento, 
    t.numero AS Numero_Telefone  
FROM 
    empregado e
JOIN 
    departamento d ON e.Departamento_idDepartamento = d.idDepartamento
LEFT JOIN 
    telefone t ON e.cpf = t.Empregado_cpf  
WHERE 
    e.salario < (SELECT AVG(salario) FROM empregado)
ORDER BY 
    e.nome ASC;

-- Relatorio 3

SELECT 
    d.nome AS Departamento,
    COUNT(e.cpf) AS Quantidade_de_Empregados,
    AVG(e.salario) AS Media_Salarial,
    AVG(e.comissao) AS Media_da_Comissao
FROM 
    petshop.Departamento d
LEFT JOIN 
    petshop.Empregado e ON d.idDepartamento = e.Departamento_idDepartamento
GROUP BY 
    d.idDepartamento, d.nome
ORDER BY 
    d.nome;
    
    
-- Relatorio 4

SELECT 
    e.nome AS Nome_Empregado,
    e.cpf AS CPF_Empregado,
    e.sexo AS Sexo,
    e.salario AS Salario,
    COUNT(v.idVenda) AS Quantidade_Vendas,
    SUM(v.valor) AS Total_Valor_Vendido,
    SUM(v.comissao) AS Total_Comissao_das_Vendas
FROM 
    petshop.Empregado e
LEFT JOIN 
    petshop.Venda v ON e.cpf = v.Empregado_cpf
GROUP BY 
    e.cpf, e.nome, e.sexo, e.salario
ORDER BY 
    Quantidade_Vendas DESC;
    
-- Relatorio 5

SELECT 
    e.nome AS Nome_Empregado,
    e.cpf AS CPF_Empregado,
    e.sexo AS Sexo,
    e.salario AS Salario,
    COUNT(DISTINCT isv.Venda_idVenda) AS Quantidade_Vendas_com_Servico,
    SUM(isv.valor) AS Total_Valor_Vendido_com_Servico,
    SUM(isv.desconto) AS Total_Comissao_das_Vendas_com_Servico
FROM 
    petshop.Empregado e
JOIN 
    petshop.itensServico isv ON e.cpf = isv.Empregado_cpf
GROUP BY 
    e.cpf, e.nome, e.sexo, e.salario
ORDER BY 
    Quantidade_Vendas_com_Servico DESC;

-- Relatorio 6

SELECT 
    p.nome AS Nome_do_Pet,
    v.data AS Data_do_Servico,
    s.nome AS Nome_do_Servico,
    isv.quantidade AS Quantidade,
    isv.valor AS Valor,
    e.nome AS Empregado_que_realizou_o_Servico
FROM 
    petshop.PET p
JOIN 
    petshop.itensServico isv ON p.idPET = isv.PET_idPET
JOIN 
    petshop.Servico s ON isv.Servico_idServico = s.idServico
JOIN 
    petshop.Venda v ON isv.Venda_idVenda = v.idVenda
JOIN 
    petshop.Empregado e ON isv.Empregado_cpf = e.cpf
ORDER BY 
    v.data DESC;

-- Relatorio 7

SELECT 
    v.data AS Data_da_Venda,
    v.valor AS Valor,
    v.desconto AS Desconto,
    (v.valor - v.desconto) AS Valor_Final,
    e.nome AS Empregado_que_realizou_a_Venda
FROM 
    petshop.Venda v
JOIN 
    petshop.Empregado e ON v.Empregado_cpf = e.cpf
JOIN 
    petshop.Cliente c ON v.Cliente_cpf = c.cpf
ORDER BY 
    v.data DESC;
    
    
-- relatorio 8


SELECT 
    s.nome AS Nome_do_Servico,
    SUM(isv.quantidade) AS Quantidade_Vendas,
    SUM(isv.valor) AS Total_Valor_Vendido
FROM 
    petshop.itensServico isv
JOIN 
    petshop.Servico s ON isv.Servico_idServico = s.idServico
GROUP BY 
    s.idServico, s.nome
ORDER BY 
    Quantidade_Vendas DESC
LIMIT 10;

-- relatorio 9

SELECT 
    f.tipo AS Tipo_Forma_Pagamento,
    COUNT(v.idVenda) AS Quantidade_Vendas,
    SUM(f.valorPago) AS Total_Valor_Vendido
FROM 
    petshop.FormaPgVenda f
JOIN 
    petshop.Venda v ON f.Venda_idVenda = v.idVenda
GROUP BY 
    f.tipo
ORDER BY 
    Quantidade_Vendas DESC;
    
-- Relatorio 10

SELECT 
    DATE(v.data) AS Data_Venda,
    COUNT(v.idVenda) AS Quantidade_Vendas,
    SUM(v.valor) AS Valor_Total_Venda
FROM 
    petshop.Venda v
GROUP BY 
    DATE(v.data)
ORDER BY 
    Data_Venda DESC;

-- Relatório 11
SELECT 
    p.nome AS Nome_Produto,
    p.valorVenda AS Valor_Produto,
    ic.quantidade AS Quantidade_Produto,
    f.nome AS Nome_Fornecedor,
    f.email AS Email_Fornecedor
FROM
    Produtos p
INNER JOIN 
    ItensCompra ic ON p.idProduto = ic.Produtos_idProduto
INNER JOIN 
    Compras c ON ic.Compras_idCompra = c.idCompra
INNER JOIN 
    Fornecedor f ON c.Fornecedor_cpf_cnpj = f.cpf_cnpj
ORDER BY 
    p.nome;
    
-- Relatório 12
SELECT 
    p.nome AS Nome_Produto,
    COUNT(ic.Produtos_idProduto) AS Quantidade_Total_Vendas,
    SUM(ic.valorCompra) AS Valor_Total_Recebido_Pela_Venda
FROM 
    Produtos p
INNER JOIN 
    ItensCompra ic ON p.idProduto = ic.Produtos_idProduto
GROUP BY 
    p.nome
ORDER BY 
    Quantidade_Total_Vendas DESC;














