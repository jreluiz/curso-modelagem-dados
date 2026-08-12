# As dependências da tabela de inscrições

O documento de trabalho da normalização do caso de eventos: cada dependência funcional, a pergunta que a confirmou e quem respondeu. É o formato de entrega do `ex03`.

## O esquema de partida

```
   INSCRICAO(cod_ev, matricula, nome_aluno, curso,
             titulo_evento, carga_horaria, sala, data_inscricao)

   CHAVE: (cod_ev, matricula)
```

## As dependências

| # | Dependência | Pergunta feita | Resposta |
|:---:|---|---|---|
| DF-01 | `matricula → nome_aluno` | *"Um aluno pode aparecer com dois nomes?"* | não — o nome vem do cadastro acadêmico |
| DF-02 | `matricula → curso` | *"Um aluno pode estar em dois cursos?"* | não nesta instituição; se mudar, é uma DF a menos |
| DF-03 | `cod_ev → titulo_evento` | *"Dois eventos podem ter o mesmo código?"* | não — o código é gerado pela secretaria |
| DF-04 | `cod_ev → carga_horaria` | *"A carga horária varia por inscrito?"* | não — é do evento |
| DF-05 | `cod_ev → sala` | *"Um evento pode ocorrer em duas salas?"* | não — foi a RN-02 da Aula 09 |
| DF-06 | `(cod_ev, matricula) → data_inscricao` | *"A data é da pessoa, do evento ou da dupla?"* | da dupla — é quando **aquele** aluno se inscreveu |

## A leitura da lista

```
   DF-06  usa a chave INTEIRA        → dependência total, fica onde está
   DF-01  usa só `matricula`         → parcial ⚠️
   DF-02  usa só `matricula`         → parcial ⚠️
   DF-03  usa só `cod_ev`            → parcial ⚠️
   DF-04  usa só `cod_ev`            → parcial ⚠️
   DF-05  usa só `cod_ev`            → parcial ⚠️
```

Cinco dependências parciais, e cada uma delas é uma coluna que se repete a cada linha em que a metade correspondente da chave aparece. É a origem exata das três anomalias da Aula 13.

> ⚠️ **A DF-02 tem prazo de validade, e isso vale registrar.** Ela depende de uma regra da instituição — *"um aluno pertence a um curso só"*. No dia em que a dupla graduação for permitida, `matricula → curso` deixa de valer e `curso` vira uma tabela à parte. Dependência funcional não é verdade matemática: é **uma afirmação sobre o mundo**, e o mundo muda.

## O que fazer com isso

A lista acima é a entrada da Aula 15. As cinco parciais se resolvem separando `ALUNO` e `EVENTO` em tabelas próprias, e o que sobra em `INSCRICAO` é exatamente o que depende da chave inteira.

> 💡 Repare que o resultado dessa decomposição é o **mesmo esquema** que sairia do DER da Aula 09, convertido pelas regras da Aula 07. Normalização e modelagem conceitual chegam ao mesmo lugar por caminhos diferentes — e quando não chegam, uma das duas está errada e vale investigar qual.

---

⬅️ [Voltar à Aula 14](../README.md)
