# Roteiro do brModelo e checklist da conversão

O que fazer, na ordem, e o que conferir depois que a ferramenta converter. Serve para qualquer modelo — leve este arquivo aberto no `ex03`.

## 1. Antes de abrir a ferramenta

Tenha em mãos, no papel ou no editor:

- a **lista de regras numeradas** (Aula 04 e Aula 09);
- os **candidatos a entidade** já recusados ou aceitos por escrito (Aula 03);
- as **duas respostas** de cada lado de cada relacionamento — "quantos?" e "pode zero?" (Aula 06).

> 💡 Quem abre a ferramenta antes disso passa a modelar **arrastando caixa**, e o modelo vira o que é fácil de desenhar em vez do que é verdade no mundo.

## 2. O roteiro

```
   1. ENTIDADES        um retângulo por entidade aceita.
                       MAIÚSCULAS, singular, sem acento.

   2. ATRIBUTOS        clique na entidade, acrescente, marque o
                       identificador. Poucos por diagrama.

   3. RELACIONAMENTOS  losango ligado às duas entidades, nome com verbo.

   4. CARDINALIDADE    escolha o par (min,max) em cada ponta.
                       Leia a frase em voz alta antes de seguir.

   5. CONVERSÃO        Ferramentas → Converter para lógico.

   6. REVISÃO          o checklist da seção 3, item por item.

   7. EXPORTAÇÃO       imagem do diagrama para o repositório, e o
                       esquema lógico transcrito em texto no seu .md
```

> ⚠️ **A ferramenta usa `(min,max)`, o curso usa `1`/`N`/`M`.** O par escrito ao lado de uma entidade diz quantas vezes **cada ocorrência dela** participa do relacionamento — o que joga o "muitos" para o lado oposto:

```
   O curso   [EDITORA] ──1──  {PUBLICA}  ──N── [LIVRO]
                                           ↑ o "muitos" fica junto de LIVRO

   brModelo  [EDITORA] ─(1,n)─ {PUBLICA} ─(1,1)─ [LIVRO]
                         ↑ o "muitos" fica junto de EDITORA
```

O teste que resolve em cinco segundos, sem decorar convenção: leia *"uma editora publica muitos livros"* e veja se o diagrama afirma isso.

## 3. O checklist da conversão

Seis itens. Nenhum é opcional:

- [ ] **As chaves são as que identificam no mundo?** A ferramenta cria `id_tabela` em tudo. Se `isbn`, `cpf` ou `matricula` já identificam, decida qual fica — e escreva por quê;
- [ ] **A entidade fraca continua fraca?** A conversão costuma dar chave própria a ela e apagar a dependência de identificação;
- [ ] **As chaves estrangeiras estão do lado N?** Confira uma a uma contra o diagrama;
- [ ] **O que não aceita vazio está marcado?** A participação total do desenho vira coluna obrigatória — e a ferramenta raramente traz isso;
- [ ] **As políticas de exclusão foram escolhidas?** Recusar, propagar ou anular, uma por chave estrangeira (Aula 07, seção 5);
- [ ] **As regras que não viraram desenho estão na lista?** Prazo, limite, tempo — a conversão não as inventa nem as guarda.

## 4. O que entregar

| Artefato | Formato | Onde |
|---|---|---|
| Diagrama | imagem exportada **e** o Mermaid equivalente | pasta da aula |
| Esquema lógico | texto, no formato `TABELA(coluna, ...)` | o mesmo `.md` |
| Regras numeradas | lista `RN-NN` | o mesmo `.md` |
| Decisões | blocos `D-NN` com a alternativa descartada | o mesmo `.md` |

> ⚠️ **Imagem sozinha não é entrega.** Ela não faz *diff*, não recebe comentário de linha e envelhece mal — é por isso que o curso pede o Mermaid ao lado dela. A imagem serve para o modelo grande que o Mermaid não desenha bem; o texto serve para o resto da vida do projeto.

---

⬅️ [Voltar à Aula 12](../README.md)
