-----------------CREATE-----------------------------
--Criando Nó
create(u1:universidade{nome:"Ufersa Mossoró", id:1}) 
--Criando Cursos
CREATE(curso1:categoria{nome:"graduação",id:1}) 
CREATE(curso2:categoria{nome:"Pós-Graduação",id:2}) 
 
--Criando Disciplinas
create(d1:disciplina{nomeDisciplina:"Banco de Dados Avançados.",Mostrar:"Disciplina Ofertada"})
create(d2:disciplina{nomeDisciplina:"PAA.",Mostrar:"Disciplina Ofertada"})
create(d3:disciplina{nomeDisciplina:"Engenharia de Software",Mostrar:"Disciplina Ofertada"})
create(d4:disciplina{nomeDisciplina:"Metodologia Científica",Mostrar:"Disciplina Ofertada"})
--Criando Professores
CREATE(p1:professor{nome:"Angélica", cidade: 'Mossoró'}) 
CREATE(p2:professor{nome:"Lima Junior", cidade: 'Mossoró'}) 
CREATE(p3:professor{nome:"Cicília", cidade: 'Mossoró'})
CREATE(p4:professor{nome:"Patrício", cidade: 'Natal'})
--Criando Relação
CREATE (u1)-[r1:Possui {Nível: "Possui"}]->(curso1)
CREATE (u1)-[r2:Possui {Nível: "Possui"}]->(curso2)

--Criando Relação Disciplina - Curso
CREATE(d1)-[r3:Pertence {Nível: "PertenceGrad"}]->(curso1)
CREATE(d2)-[r4:Pertence {Nível: "PertencePos"}]->(curso2)
CREATE(d3)-[r5:Pertence {Nível: "PertencePos"}]->(curso2)
CREATE(d4)-[r6:Pertence {Nível: "PertencePos"}]->(curso2)

--Criando Relação Professor - Disciplina
CREATE(p1)-[r7:Leciona {Nível: "Leciona"}]->(d1)
CREATE(p2)-[r8:Leciona {Nível: "Leciona"}]->(d2)
CREATE(p3)-[r9:Leciona {Nível: "Leciona"}]->(d3)
CREATE(p4)-[r10:Leciona {Nível: "Leciona"}]->(d4)

-----------------SELECT------------------------------
--mostrar todos os resultados
MATCH (n) RETURN n 
-- seleciona os professores 
match(prof:professor) return prof 
--retorna as categoria dos cursos
MATCH (c:categoria) RETURN c.id, c.nome 

-- exibir qual professor Leciona cada disciplina
MATCH a=()-[r:Leciona]->() RETURN a 
MATCH (n:professor), (m:disciplina) return n,m

-- exibir quais cursos disponiveis na ufersa
MATCH c=()-[r:Possui]->() RETURN c  
-- Que disciplina perterce a cada categoria
MATCH n=()-[r:PertenceA]->() RETURN n 

------------------UPDATE-----------------------------
--Altera o nome do nó
MATCH (professor:professor) RETURN professor 	
--Altera a cidade de um professor
MATCH (p1 {nome: 'Angélica' }) SET p1.cidade = 'Mossoró' RETURN p1.cidade  

----------------DELETE--------------------------------
--Deleta disciplina pelo nomeDisciplina 
MATCH (d4:disciplina {nomeDisciplina: 'Metodologia Científica' }) DETACH DELETE d4

 --deleta o relacionamento do professor p1
MATCH (p1:professor {nome:"Patrício"})-[r:Leciona]-() delete r

 --deleta o relacionamento da disciplina
MATCH (d3:disciplina{nomeDisciplina:"PAA."})-[r:Pertence]-() delete r

-- deleta os cursos de graduação
MATCH (cat:categoria{nome:'graduação'}) DETACH delete cat 

-- deletar os dados
MATCH(n) detach delete n 

