# 🎓 Projeto Final — Do Minimundo ao Banco Rodando

> 📅 **Quando:** Bloco 4, após a [Aula 15](../bloco-4-sql-basico/aula-15-juncoes-e-agregacao/README.md).
> 🎯 **O que é:** o curso inteiro numa entrega só — um texto em português vira um banco de dados íntegro, normalizado e consultável.

Individual. Tema de sua escolha.

## 🎯 O que se prova aqui

Que você consegue, sozinho, atravessar o caminho inteiro:

```
   texto em português  →  DER  →  esquema relacional  →  banco rodando  →  respostas
       (§1)              (§2)          (§3, §4)             (§5, §6)         (§7)
```

## 🌍 Escolhendo o tema

Três critérios, nesta ordem:

1. **Você entende o domínio?** Modelar bem exige saber quando o enunciado está mentindo. O trabalho de alguém da família, um hobby, a rotina de um lugar que você frequenta — vale mais que um tema "impressionante" que você conhece de fora;
2. **Tem tamanho suficiente?** Mínimo de 5 entidades, um N:M, e um autorrelacionamento ou uma tabela dependente;
3. **Cabe em duas semanas?** Modelar o Instagram inteiro não é ambição, é falta de recorte. **Recortar é a primeira habilidade do modelador.**

Pode ser um do [catálogo de minimundos](../recursos/minimundos.md) (prefira os ⭐⭐ e ⭐⭐⭐) ou de autoria própria — esta última é incentivada. A Biblioteca Universitária está fora: o modelo dela está publicado.

## ✅ Requisitos obrigatórios

### 1. Minimundo

- [ ] Enunciado de **3 a 5 parágrafos**, em português corrido, **sem nomear entidades ou tabelas** — escrito como um cliente descreveria o negócio;
- [ ] Lista **numerada** de regras de negócio que o diagrama não expressa;
- [ ] Uma seção de **decisões de recorte**: o que ficou de fora e por quê.

### 2. Modelo conceitual

- [ ] **DER em Mermaid**, renderizando no GitHub;
- [ ] Mínimo de **5 entidades**;
- [ ] Pelo menos um relacionamento **N:M**;
- [ ] Pelo menos um **autorrelacionamento** ou uma **tabela dependente**, com a escolha justificada;
- [ ] Todos os relacionamentos com o símbolo completo nos dois lados, e uma linha dizendo **o que cada um afirma sobre o mundo**;
- [ ] A **leitura em voz alta** (Aula 08): uma frase por relacionamento, com ✅ ou ❌;
- [ ] Registro em texto de tudo que o Mermaid não expressa.

### 3. Modelo lógico

- [ ] **Esquema relacional** completo, com PKs, FKs e domínios explícitos;
- [ ] Indicação de **qual regra de mapeamento** gerou cada tabela;
- [ ] **Ação referencial** (`ON DELETE`) escolhida e justificada para **cada** FK;
- [ ] Uma seção sobre **o que se perdeu** na tradução do DER.

### 4. Normalização

- [ ] Análise **tabela por tabela**: em que forma normal está e **por quê**;
- [ ] As dependências funcionais escritas em português, no formato `X → Y`;
- [ ] Se alguma tabela não estiver em 3FN, a decomposição, com a dependência que a motivou;
- [ ] Justificativa escrita de qualquer redundância mantida de propósito (valor histórico, por exemplo).

### 5. Banco físico

- [ ] **Script DDL** que roda do zero no PostgreSQL, com `psql -v ON_ERROR_STOP=1`;
- [ ] Todas as PKs, FKs, `NOT NULL` e `UNIQUE`;
- [ ] Mínimo de **4 restrições `CHECK`** traduzindo regras reais do seu minimundo, sendo pelo menos uma comparando **duas colunas** da mesma linha;
- [ ] Todas as restrições **nomeadas** no padrão do curso (`tabela_pk`, `tabela_coluna_fk`, `tabela_coluna_ck`, `tabela_coluna_uk`);
- [ ] O script pode ser rodado **duas vezes seguidas** sem erro.

### 6. Carga de dados

- [ ] Mínimo de **5 linhas por tabela**, na ordem correta de dependências;
- [ ] Dados **coerentes**: nomes reais, datas plausíveis, valores que fazem sentido no domínio;
- [ ] Pelo menos **três casos de borda** propositais que exercitem consultas interessantes (uma linha sem dependentes, um vazio com significado documentado, um caso que quase viola um `CHECK`).

### 7. Consultas

Seis consultas, cada uma com um comentário dizendo **a pergunta em português**:

- [ ] Duas com **junção de duas tabelas**;
- [ ] Uma com junção de **três ou mais** tabelas;
- [ ] Uma com `GROUP BY` e função de agregação;
- [ ] Uma com `GROUP BY` + `HAVING`, e um comentário explicando por que o filtro está no `HAVING` e não no `WHERE`;
- [ ] Uma **`VIEW`** com pelo menos um campo derivado, mais uma consulta sobre ela.

### 8. Processo

- [ ] Mínimo de **10 commits** distribuídos ao longo do desenvolvimento (não 10 no último dia);
- [ ] Mensagens de commit descritivas, em português.

## 📦 Estrutura do repositório

```
projeto-<seu-tema>/
├── README.md              # a porta de entrada
├── 01-minimundo.md        # enunciado + regras de negócio + recorte
├── 02-der.md              # DER em Mermaid + leitura em voz alta
├── 03-esquema-logico.md   # mapeamento regra a regra + ações referenciais
├── 04-normalizacao.md     # análise tabela por tabela
└── sql/
    ├── 01-ddl.sql
    ├── 02-carga.sql
    └── 03-consultas.sql
```

### O `README.md` precisa ter

- O que é o sistema, em **um parágrafo**;
- O **DER renderizado**;
- Como rodar, com os comandos exatos, copiáveis;
- **Cinco perguntas** que o seu banco responde, com o resultado real de cada uma colado;
- Uma seção **"o que eu faria com mais tempo"** — e ela precisa ser específica. "Melhoraria o modelo" não conta; "modelaria o histórico de preços, que hoje é sobrescrito" conta.

## 🌶️ Extras para ir além

- **`LEFT JOIN` revelador**: uma consulta em que o `INNER JOIN` esconde linhas que importam, com as duas versões e a explicação da diferença;
- **Transação**: um caso do seu domínio em que dois comandos precisam acontecer juntos, com `BEGIN`/`COMMIT` e uma demonstração de `ROLLBACK`;
- **Usuário só-leitura**: crie uma identidade que consulta e não escreve, e mostre o `permission denied` que ela recebe ao tentar um `INSERT`;
- **Modelagem alternativa**: uma decisão do seu modelo feita de outra forma, com a comparação honesta das duas.

## 📤 Entrega

Repositório público, mais uma **demonstração de 5 minutos** (ao vivo ou gravada) mostrando:

1. O DER e **uma decisão** que você tomou e por quê;
2. O script rodando do zero — `dropdb`, `createdb`, DDL, carga;
3. Duas consultas respondendo perguntas do seu domínio;
4. **Um erro sendo recusado pelo banco** — um `INSERT` que viola uma FK ou um `CHECK`. Este item não é opcional: é onde se vê que as restrições existem;
5. O trecho do modelo de que você mais se orgulha.

## 🧭 Como isso é avaliado

Em ordem de peso:

1. **Coerência entre as fases** — o DER, o esquema, o DDL e as consultas precisam contar a **mesma** história. Um DER com 7 entidades e um DDL com 5 tabelas reprova por incoerência, mesmo que as 5 estejam perfeitas;
2. **Justificativa das decisões** — cada escolha não óbvia (chave, cardinalidade, tabela dependente, ação referencial, redundância mantida) tem uma linha explicando;
3. **Fidelidade ao minimundo** — o modelo representa o que o enunciado diz, inclusive nas partes chatas;
4. **O banco roda** — do zero, sem intervenção manual;
5. **As consultas respondem perguntas de verdade** — não `SELECT * FROM tabela` seis vezes.

> 📏 **O critério que resume tudo:** um colega que nunca viu o seu tema consegue ler o repositório, entender o domínio, rodar o banco e fazer uma pergunta nova? Se sim, o projeto está pronto.

---

🏠 [Voltar ao início](../README.md)
