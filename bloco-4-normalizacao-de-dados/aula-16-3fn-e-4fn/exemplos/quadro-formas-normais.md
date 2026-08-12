# O quadro das formas normais

Uma página para consultar em qualquer projeto, dentro ou fora do curso.

## As quatro formas normais

| Forma | Proíbe | Como se reconhece | Cura |
|---|---|---|---|
| **1FN** | valor não atômico | lista dentro da célula; `telefone1`, `telefone2` | o multivalorado vira **tabela própria** |
| **2FN** | dependência **parcial** | atributo que depende de metade da chave composta | o determinante vira chave de uma **tabela nova** |
| **3FN** | dependência **transitiva** | atributo não-chave determinando outro não-chave | idem, e o determinante fica como chave estrangeira |
| **4FN** | duas multivaloradas **independentes** | linhas que se multiplicam sem significar nada | **uma tabela para cada conjunto** |

As formas são **cumulativas**: para estar na 3FN, o esquema já tem de estar na 2FN e na 1FN.

## O roteiro, em cinco perguntas

```
   1. Alguma célula guarda mais de um valor?               → 1FN
   2. A chave é composta? Algum atributo depende
      só de uma parte dela?                                 → 2FN
   3. Algum atributo não-chave determina outro?            → 3FN
   4. Há duas listas independentes na mesma tabela?        → 4FN
   5. Cada decomposição é sem perda?                       → depois de cada passo
```

## O teste da decomposição sem perda

> **A coluna pela qual você separou é chave em pelo menos uma das duas tabelas resultantes?**

Se não for, a remontagem inventa linhas que nunca existiram. E a conferência de dois minutos:

1. toda coluna original aparece em alguma tabela nova?
2. remontando uma linha específica, ela volta idêntica?
3. as três anomalias da Aula 13 sumiram?

## Os cinco enganos que mais aparecem

| Engano | Por que é engano |
|---|---|
| resolver a 1FN com `telefone1`, `telefone2`, `telefone3` | não está em 1FN — quem tem quatro não cabe, e procurar exige olhar em três lugares |
| analisar a 2FN numa tabela de **chave simples** | não há parte de que depender: ela já está em 2FN |
| chamar de 2FN o que é 3FN | **olhe a chave primeiro**: chave simples ⇒ é transitiva |
| disparar a 4FN ao ver **um** multivalorado | sem duas listas independentes, não há o que decompor |
| decompor sem conferir | o único jeito de piorar um esquema normalizando |

## O que a normalização **não** faz

- **Não decide o que é entidade.** Isso é o teste das três perguntas da Aula 03;
- **Não descobre regra de negócio.** Dependência funcional se confirma perguntando ao cliente, nunca olhando os dados;
- **Não melhora desempenho.** Ela elimina contradição; velocidade é assunto do modelo físico, que este curso não cobre;
- **Não substitui a modelagem conceitual.** Os dois caminhos devem chegar ao mesmo esquema — quando não chegam, um dos dois está errado.

---

⬅️ [Voltar à Aula 16](../README.md)
