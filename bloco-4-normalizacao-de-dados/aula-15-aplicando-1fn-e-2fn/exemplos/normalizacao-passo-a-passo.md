# A normalização do caso de eventos, passo a passo

Da tabela única até a 3FN, com a conferência de cada passo. É o formato de entrega do `ex01`.

## Passo 0 — o esquema de partida

```
   INSCRICAO(cod_ev, matricula, nome_aluno, curso, titulo_evento,
             carga_horaria, sala, capacidade_sala, palestrantes,
             data_inscricao)
   CHAVE: (cod_ev, matricula)
```

**Anomalias presentes:** alteração (nome do aluno e título do evento repetidos), inserção (evento sem inscrito não cabe), exclusão (apagar a última inscrição some com o evento).

## Passo 1 — 1FN

**O que viola:** `palestrantes` guarda uma lista.

```
   INSCRICAO(cod_ev, matricula, nome_aluno, curso, titulo_evento,
             carga_horaria, sala, capacidade_sala, data_inscricao)

   PALESTRANTE_EVENTO(cod_ev, nome_palestrante)
      chave: (cod_ev, nome_palestrante)
```

**Conferência:** a coluna `palestrantes` desapareceu e nenhum palestrante se perdeu — cada valor da lista virou uma linha. A separação foi por `cod_ev`, que é chave em `INSCRICAO`? Não, mas está lá como parte da chave, e é chave estrangeira na tabela nova: dá para remontar.

## Passo 2 — 2FN

**O que viola:** cinco dependências parciais (`matricula →` duas colunas, `cod_ev →` quatro).

```
   ALUNO(matricula, nome_aluno, curso)

   EVENTO(cod_ev, titulo_evento, carga_horaria, sala, capacidade_sala)

   INSCRICAO(matricula → ALUNO, cod_ev → EVENTO, data_inscricao)
      chave: (cod_ev, matricula)

   PALESTRANTE_EVENTO(cod_ev → EVENTO, nome_palestrante)
```

**Conferência:**

| Teste | Resultado |
|---|---|
| Toda coluna original aparece em alguma tabela? | sim, as dez |
| `matricula` é chave em `ALUNO` e está em `INSCRICAO`? | sim — sem perda |
| `cod_ev` é chave em `EVENTO` e está em `INSCRICAO`? | sim — sem perda |
| Remontar a inscrição `(101, 2023101)` devolve a linha original? | sim |
| Cadastrar evento sem inscrito? | **agora cabe** |
| Corrigir o nome da Ana? | uma linha só |

## Passo 3 — 3FN

**O que viola:** em `EVENTO`, `sala → capacidade_sala` — um atributo não-chave determinando outro. Dependência **transitiva**, não parcial: a chave `cod_ev` tem uma coluna só.

```
   EVENTO(cod_ev, titulo_evento, carga_horaria, sala → SALA)

   SALA(sala, capacidade_sala)
```

**Conferência:** a separação foi por `sala`, que é chave em `SALA` e continua em `EVENTO` como chave estrangeira — sem perda. E a sala nova, ainda sem evento marcado, agora cabe.

## O esquema final

```
   ALUNO(matricula, nome_aluno, curso)
   SALA(sala, capacidade_sala)
   EVENTO(cod_ev, titulo_evento, carga_horaria, sala → SALA)
   INSCRICAO(matricula → ALUNO, cod_ev → EVENTO, data_inscricao)
   PALESTRANTE_EVENTO(cod_ev → EVENTO, nome_palestrante)
```

Cinco tabelas, nenhuma anomalia das três, e cada fato escrito uma vez só.

> 💡 **O caminho não foi único, o destino foi.** Alguém que começasse pela 3FN chegaria às mesmas cinco tabelas. A ordem 1FN → 2FN → 3FN existe para você não ter de enxergar tudo de uma vez — é um roteiro, não uma lei da natureza.

> ⚠️ **Uma decisão que não é da normalização.** `PALESTRANTE_EVENTO` guarda o **nome** do palestrante como parte da chave. Se a secretaria passar a registrar instituição e telefone dele, isso vira entidade própria — é o teste da Aula 03, não uma forma normal. Normalização arruma dependência; ela não decide o que é entidade.

---

⬅️ [Voltar à Aula 15](../README.md)
