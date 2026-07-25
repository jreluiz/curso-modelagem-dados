# Aula 04 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 04 — MER: Entidades e Atributos](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A04-01

Um DER contém uma caixa chamada `LIVRO_DE_BANCO_DE_DADOS`. Qual é o problema?

- **a)** A caixa descreve uma instância de entidade, e o DER só representa tipos;
- **b)** o nome está em maiúsculas, o que é contrário à convenção;
- **c)** o nome é longo demais para caber no diagrama;
- **d)** nenhum problema: nomes específicos tornam o modelo mais claro.

↩︎ *Aula 04, seção 1 — Conjunto de entidades × instância de entidade*

---

### Q-A04-02

O atributo `endereco` de um usuário deve ser decomposto em `logradouro`, `numero`, `bairro` e `cidade` quando:

- **a)** Sempre, porque atributos compostos são proibidos no modelo relacional;
- **b)** alguém precisar consultar ou ordenar por uma das partes — por exemplo, listar usuários por cidade;
- **c)** nunca, porque a decomposição gera colunas demais;
- **d)** o endereço tiver mais de 100 caracteres.

↩︎ *Aula 04, seção 2 — Atributos e seus quatro eixos*

---

### Q-A04-03

Por que resolver um atributo multivalorado com as colunas `telefone1`, `telefone2` e `telefone3` é uma má solução?

- **a)** Porque o SGBD não aceita mais de duas colunas com nomes parecidos;
- **b)** porque isso viola a integridade referencial das chaves estrangeiras;
- **c)** porque decide arbitrariamente que ninguém tem quatro telefones, cria colunas quase sempre vazias e torna a busca por um número uma consulta com três condições;
- **d)** porque atributos numerados precisam ser do tipo inteiro.

↩︎ *Aula 04, seção 2 — Atributos e seus quatro eixos*

---

### Q-A04-04

`data_devolucao` está nula num empréstimo. O que isso significa?

- **a)** Necessariamente que o livro ainda não foi devolvido;
- **b)** que o valor é igual a zero;
- **c)** que houve erro de digitação no cadastro;
- **d)** é ambíguo: pode ser "não se aplica", "desconhecido" ou "não informado" — e o modelo precisa documentar qual significado vale.

↩︎ *Aula 04, seção 2 — Atributos e seus quatro eixos*

---

### Q-A04-05

Escrever o **domínio** de cada atributo em português, durante a modelagem, tem qual efeito prático?

- **a)** Nenhum: domínio é sinônimo de tipo de dado e já está implícito;
- **b)** documenta o modelo, mas não influencia o banco final;
- **c)** substitui a necessidade de escolher tipos de dados na fase física;
- **d)** adianta metade do DDL — cada domínio vira uma restrição (`CHECK`, `NOT NULL`, `UNIQUE`) que o banco passa a verificar sozinho.

↩︎ *Aula 04, seção 3 — Domínio*

---

### Q-A04-06

`(matricula)` e `(matricula, nome)` identificam unicamente um usuário. Como se classifica cada um?

- **a)** Ambos são chaves candidatas;
- **b)** ambos são superchaves, e nenhum é candidato;
- **c)** `(matricula)` é superchave e chave candidata, por ser mínima; `(matricula, nome)` é superchave mas não candidata;
- **d)** `(matricula, nome)` é a candidata, por ser mais específica.

↩︎ *Aula 04, seção 4 — Chaves*

---

### Q-A04-07

Por que `email` costuma ser rejeitado como chave primária de `USUARIO`?

- **a)** Porque campos de texto não podem ser chave primária;
- **b)** porque ele muda — e toda referência a ele teria de mudar junto. Ele continua sendo chave alternativa (`UNIQUE`);
- **c)** porque e-mails podem conter caracteres especiais que o SGBD não aceita;
- **d)** porque um usuário pode ter vários e-mails, o que o torna multivalorado.

↩︎ *Aula 04, seção 4 — Chaves*

---

### Q-A04-08

Ao traduzir para Mermaid um modelo que tem `telefone` como atributo multivalorado, o que acontece?

- **a)** A informação se perde no diagrama, e por isso deve ser registrada em texto logo abaixo dele;
- **b)** o Mermaid desenha uma elipse dupla, como em Chen;
- **c)** o Mermaid recusa o diagrama e exibe erro de sintaxe;
- **d)** o atributo é convertido automaticamente em uma entidade separada.

↩︎ *Aula 04, seção 6 — O mesmo modelo em Mermaid*

---

⬅️ [Voltar à Aula 04](../README.md) | ➡️ [Revisão da Aula 05](../../../bloco-2-modelagem-conceitual/aula-05-relacionamentos-cardinalidade/revisao/README.md)
