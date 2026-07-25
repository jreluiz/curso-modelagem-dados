# 👥 Trabalho em Dupla — Modelagem via Pull Request

> 📅 **Quando:** Bloco 3, após a [Aula 10](../bloco-3-modelo-relacional/aula-10-mapeamento-er-relacional/README.md).
> 🎯 **O que se aprende aqui e em nenhum outro lugar:** defender uma decisão de modelagem para alguém que discorda — e mudar de ideia quando o argumento do outro é melhor.

Modelar sozinho esconde um problema: você nunca descobre que o seu modelo só faz sentido na sua cabeça. Este trabalho existe para que **outra pessoa leia o seu DER e pergunte "por quê?"**.

E o Pull Request é o lugar natural para isso: o comentário de linha do GitHub foi feito para dizer *"essa cardinalidade está invertida — e olha o caso que quebra"*.

## 📋 Formato

- **Dupla**, com um repositório compartilhado;
- **Ninguém commita no `main`.** Todo trabalho entra por Pull Request revisado pelo colega;
- **Mínimo de 3 PRs por pessoa**, com revisão de verdade — "LGTM 👍" não conta como revisão;
- O tema vem do [catálogo de minimundos](../recursos/minimundos.md) (⭐⭐ ou ⭐⭐⭐) ou é proposto pela dupla.

> ⚠️ A **Biblioteca Universitária** não pode ser escolhida: o modelo dela está publicado na Aula 08.

## 🛠️ Preparação

```bash
# Aluno A cria o repositório no GitHub e adiciona B como collaborator
# (Settings → Collaborators → Add people)

git clone https://github.com/ALUNO-A/modelagem-<tema>.git
cd modelagem-<tema>

# Cada rodada de trabalho começa assim:
git checkout main
git pull
git checkout -b der-conceitual        # branch com nome do que você vai fazer
# ... trabalha ...
git add . && git commit -m "Adiciona DER conceitual com 7 entidades"
git push -u origin der-conceitual
# Abre o PR no GitHub e pede a revisão do colega
```

> 📏 Configure a proteção do `main`: **Settings → Branches → Add rule → Require a pull request before merging**. Sem isso, a primeira pressa acaba com o combinado.

## 🔄 As três rodadas

### Rodada 1 — Divisão

| Quem | Entrega | Branch |
|---|---|---|
| **A** | Enunciado do minimundo (3–5 parágrafos) + DER conceitual em Mermaid + lista de regras de negócio | `der-conceitual` |
| **B** | Mapeamento para o esquema relacional + análise de normalização até 3FN | `esquema-relacional` |

B só pode começar depois que o PR de A estiver aberto — mas **não precisa esperar o merge**. Trabalhar sobre um modelo em revisão é realista e é onde as divergências aparecem.

### Rodada 2 — Revisão cruzada

Cada um revisa o PR do outro **com comentários de linha**, cobrindo obrigatoriamente:

- [ ] Toda cardinalidade lida em voz alta, nas duas direções — alguma frase é falsa?
- [ ] Toda participação: existe algum `(0,N)` que deveria ser `(1,N)`?
- [ ] Os [sete erros clássicos](../bloco-2-modelagem-conceitual/aula-08-estudo-de-caso-der/README.md#3-os-sete-erros-clássicos) da Aula 08;
- [ ] Toda entidade fraca passa no teste da identificação (Aula 06)?
- [ ] Alguma especialização não paga o próprio custo (Aula 07)?
- [ ] Cada decomposição de normalização é **sem perda**?

> 💡 **Uma revisão boa faz perguntas, não dá ordens.** *"Um cliente pode ter dois endereços de entrega ativos?"* é melhor que *"está errado"* — porque metade das vezes quem está errado é quem pergunta, e a pergunta descobre isso sem custo.

### Rodada 3 — Troca de papéis

Depois dos merges, **invertam**: agora **B** propõe uma extensão do minimundo (um requisito novo e realista, que o cliente "esqueceu de mencionar") e **A** ajusta o esquema e a normalização.

É a rodada que mais ensina: modelo bom é o que aguenta um requisito novo sem ser refeito.

## 📦 O que entregar

Estrutura do repositório ao final:

```
modelagem-<tema>/
├── README.md              # a entrega principal (ver abaixo)
├── minimundo.md           # o enunciado, em português corrido
├── der.md                 # o DER em Mermaid + regras de negócio
├── esquema-relacional.md  # o mapeamento, regra por regra
├── normalizacao.md        # a análise 1FN → 3FN, relação por relação
└── divergencias.md        # ⭐ o diferencial deste trabalho
```

### `README.md`

- Nome dos dois integrantes e o que cada um fez, por rodada;
- O DER renderizado (Mermaid direto no arquivo);
- Link para os demais arquivos;
- **Link para os PRs** — é a prova de que o processo aconteceu.

### `divergencias.md` — o coração do trabalho

Registre **duas divergências reais** que a dupla teve. Para cada uma:

1. **O ponto** — qual decisão de modelagem estava em disputa;
2. **O argumento de cada lado** — escrito de forma que os dois se reconheçam;
3. **Como foi resolvido** — quem convenceu quem, e com qual evidência;
4. **O que teria acontecido** se a outra opção tivesse ganhado — um caso concreto que quebraria.

> ⚠️ Se a dupla não teve **nenhuma** divergência, uma das duas coisas aconteceu: ou uma pessoa aceitou tudo sem ler, ou uma pessoa fez o trabalho todo. Nos dois casos, o objetivo do trabalho se perdeu — **provoquem a discussão de propósito**: cada um escolhe uma decisão do outro e tenta derrubá-la.

## ✅ Requisitos obrigatórios

Do modelo:

- [ ] Mínimo de **6 entidades**;
- [ ] Pelo menos um relacionamento **N:M** com **atributo próprio**;
- [ ] Pelo menos uma **entidade fraca** ou uma **especialização**, com a classificação justificada;
- [ ] Todas as cardinalidades em `(min,max)`, nos dois lados;
- [ ] Lista **numerada** de regras de negócio que o diagrama não expressa;
- [ ] Esquema relacional com PKs, FKs e **ação referencial escolhida e justificada** para cada FK;
- [ ] Análise de normalização relação por relação, com a **verificação de perda** de cada decomposição.

Do processo:

- [ ] Mínimo de **3 PRs por pessoa**, cada um com pelo menos **3 comentários de linha** do colega;
- [ ] Nenhum commit direto no `main`;
- [ ] Pelo menos **um PR em que o autor mudou o modelo** por causa da revisão — e o commit que mostra a mudança;
- [ ] `divergencias.md` com duas divergências documentadas.

## 🌶️ Extras para ir além

- Escrever o **DDL** do esquema e provar que roda no PostgreSQL (antecipa a Aula 13);
- Incluir um **`INSERT` que o modelo recusa** e explicar qual restrição o impediu;
- Modelar a extensão da Rodada 3 **antes** de ela ser proposta, e apostar em qual requisito o colega vai inventar;
- Fazer o mesmo minimundo em **duas modelagens defensáveis** e escrever a comparação — é o exercício mais difícil e o que mais ensina.

## 🧭 Como isso é avaliado

Não é o desenho mais bonito que vence. Em ordem de peso:

1. **A justificativa das decisões** — um modelo mediano bem defendido vale mais que um modelo ótimo sem argumento;
2. **A qualidade da revisão que você fez no colega** — encontrar o erro alheio prova que você entendeu;
3. **A coerência entre DER, esquema e normalização** — os três precisam contar a mesma história;
4. **O registro da divergência** — é a prova de que houve pensamento, e não divisão de tarefas.

---

🏠 [Voltar ao início](../README.md)
