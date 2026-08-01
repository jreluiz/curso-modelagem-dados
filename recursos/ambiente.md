# 🛠️ Preparação do Ambiente

> 💡 **Boa notícia:** nos Blocos 1 e 2 você precisa apenas de um editor de texto e do Git. O PostgreSQL entra na Aula 11 — mas instale antes, para não perder aula com download.

## 1. O repositório de exercícios

É onde tudo que você produzir vai morar. Uma pasta por aula, do primeiro ao último dia.

1. No GitHub, crie um repositório **público** chamado `exercicios-modelagem-dados`, marcando "Add a README file";
2. Clone na sua máquina:

```bash
git clone https://github.com/SEU-USUARIO/exercicios-modelagem-dados.git
cd exercicios-modelagem-dados
```

3. Teste o ciclo completo agora, sem esperar a primeira aula:

```bash
mkdir aula-00-teste
echo "# Teste" > aula-00-teste/README.md
git add .
git commit -m "Testa o ciclo de entrega"
git push
```

Se o arquivo apareceu no GitHub, seu ambiente de entrega está pronto.

> ⚠️ Repositório **público**. Se estiver privado, ninguém consegue revisar seu modelo — e revisão por par é metade do curso.

## 2. Editor de texto com preview de Markdown

Qualquer editor serve, mas você vai escrever muito Markdown com diagramas dentro. O [VS Code](https://code.visualstudio.com/) resolve os dois:

- `Cmd/Ctrl + Shift + V` abre o **preview** do Markdown, já com os diagramas Mermaid renderizados;
- Instale a extensão **Markdown Preview Mermaid Support** se o diagrama aparecer como texto cru.

Alternativa sem instalar nada: [mermaid.live](https://mermaid.live) — cole o diagrama e veja o resultado na hora. É onde você vai depurar o diagrama que não renderiza.

## 3. PostgreSQL (a partir da Aula 11)

### macOS

```bash
brew install postgresql@15
brew services start postgresql@15
```

Se o comando `psql` não for encontrado depois disso, acrescente ao seu `~/.zshrc`:

```bash
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
```

### Windows

Baixe o instalador em [postgresql.org/download/windows](https://www.postgresql.org/download/windows/). Durante a instalação:

- **Anote a senha** do usuário `postgres` — ela é pedida em todo acesso e não há como recuperá-la sem trabalho;
- Mantenha a porta padrão **5432**;
- Marque o **pgAdmin 4** para instalar junto.

### Linux (Debian/Ubuntu)

```bash
sudo apt update
sudo apt install postgresql postgresql-client
sudo systemctl start postgresql
```

### Verificação (nos três sistemas)

```bash
psql --version
```

Deve responder algo como `psql (PostgreSQL) 15.x`. Se responder "command not found", a instalação não terminou ou o `PATH` não foi atualizado — reabra o terminal antes de concluir que deu errado.

## 4. O banco do curso

```bash
createdb curso_bd          # macOS e Linux
psql -d curso_bd           # abre o terminal do banco
```

No Windows, ou se o `createdb` reclamar de usuário, use:

```bash
psql -U postgres
```

e, já dentro do `psql`:

```sql
CREATE DATABASE curso_bd;
\c curso_bd
```

### Os comandos do `psql` que valem decorar

| Comando | O que faz |
|---------|-----------|
| `\l` | Lista os bancos |
| `\c curso_bd` | Conecta a um banco |
| `\dt` | Lista as tabelas do banco atual |
| `\d aluno` | Mostra a estrutura da tabela `aluno` (colunas, tipos, chaves, restrições) |
| `\d+ aluno` | O mesmo, com tamanho e descrição |
| `\di` | Lista os índices |
| `\i arquivo.sql` | Executa um script |
| `\x` | Alterna a saída para vertical (salva vidas em tabela larga) |
| `\timing` | Passa a mostrar o tempo de cada consulta |
| `\?` | Ajuda dos comandos `\` |
| `\q` | Sai |

> 💡 `\d nome_da_tabela` é o comando mais útil do curso: ele mostra o seu modelo lógico como o banco realmente o entendeu. Use-o toda vez que uma restrição não se comportar como você esperava.

Para rodar um script sem entrar no `psql`:

```bash
psql -d curso_bd -f ex01.sql
```

E para parar no primeiro erro em vez de seguir adiante deixando estrago:

```bash
psql -d curso_bd -v ON_ERROR_STOP=1 -f ex01.sql
```

## 5. Cliente gráfico (opcional, mas recomendado)

Escolha **um**:

- **[pgAdmin 4](https://www.pgadmin.org/)** — vem com o instalador do Windows. Feito só para PostgreSQL, mostra bem as restrições e o plano de execução;
- **[DBeaver Community](https://dbeaver.io/)** — funciona com qualquer banco, tem editor de SQL confortável e **gera o diagrama do banco** a partir das tabelas existentes (útil na Aula 13 para conferir se o seu DDL produziu o modelo que você desenhou).

> ⚠️ Cliente gráfico é conforto, não substituto. As aulas mostram os comandos no `psql` porque é o que existe em qualquer servidor, e porque clicar não ensina a ler mensagem de erro.

## 6. Ferramentas de diagrama (opcional)

O curso versiona diagramas em **Mermaid**, que é texto. Mas para rascunhar no papel digital:

- **[dbdiagram.io](https://dbdiagram.io/)** — rápido, notação pé-de-galinha (a mesma do Mermaid), exporta SQL;
- **[draw.io](https://app.diagrams.net/)** — desenho livre, tem estêncil de ER;
- **[brModelo](https://www.sis4.com/brModelo/)** — gratuito e brasileiro, desenha em **notação de Chen**. Útil se você for acompanhar os diagramas do livro-base.

> 📏 **Regra do curso:** rascunhe onde quiser, **entregue em Mermaid**. Imagem não faz *diff*, não recebe comentário de linha no Pull Request e envelhece mal.

## ✅ Checklist final

- [ ] Repositório `exercicios-modelagem-dados` criado, público e clonado;
- [ ] Um commit de teste já apareceu no GitHub;
- [ ] Editor com preview de Markdown funcionando (ou [mermaid.live](https://mermaid.live) aberto num favorito);
- [ ] Um diagrama Mermaid de teste renderizou — copie o do [guia de notações](notacoes-der.md) e confira;
- [ ] `psql --version` responde (pode ficar para antes da Aula 11);
- [ ] Banco `curso_bd` criado e `\dt` executa sem erro (idem).

---

🏠 [Voltar ao início](../README.md)
