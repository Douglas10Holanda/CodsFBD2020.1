#inserir e atualizar
HMSET aluno1 nome Adriano telefone 9999-9999 cidade_Natal Mossoró curso Computação turma 2018
HMSET aluno2 nome João telefone 8888-8888 cidade_Natal Fortaleza curso Contabilidade turma 2018
HMSET aluno3 nome Maria curso Computaco turma 2018

#Buscar
HMGET aluno3 nome telefone cidade_Natal curso turma

#Apagar
del aluno1

Key “*”
