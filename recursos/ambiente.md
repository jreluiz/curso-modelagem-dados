# 🛠️ Preparação do Ambiente

> 💡 **Boa notícia:** nos **Blocos 1 e 2 você precisa apenas de um editor de texto e do Git.** Os diagramas são escritos em Mermaid, que o GitHub renderiza sozinho — nada a instalar. A **ferramenta CASE** entra no **Bloco 3**, na Aula 12.

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

## 3. A ferramenta CASE (a partir do Bloco 3)

A partir da Aula 12 o curso usa uma **ferramenta CASE**: um programa que desenha o modelo, verifica consistência e converte o conceitual em lógico. Escolha **uma** das duas.

### brModelo — a recomendada

É gratuita, brasileira, nasceu no meio acadêmico e é a única da lista que desenha em **notação de Chen**, a mesma das Aulas 06 a 11.

1. Baixe em **[sis4.com/brModelo](https://www.sis4.com/brModelo/)**;
2. É um programa **Java** — se ele não abrir, o que falta é o Java. Confira com:

```bash
java -version
```

Se responder "command not found", instale o [Java](https://www.java.com/pt-BR/download/) e tente de novo.

3. Abra e faça o teste de dois minutos: crie duas entidades, ligue com um losango, ponha cardinalidade nas duas pontas e mande **converter para o modelo lógico**. Se saiu um esquema de tabelas, seu ambiente está pronto.

> ⚠️ **A ferramenta escreve a cardinalidade no formato `(min,max)`**, que **não** é o do curso: o par ao lado de uma entidade diz quantas vezes **cada ocorrência dela** participa do relacionamento. É a colocação oposta à do `1`/`N` das aulas. O teste que resolve sem decorar convenção: leia a ligação em voz alta — *"uma editora publica muitos livros"* — e veja se o diagrama afirma isso.

### draw.io — a alternativa sem instalar

Se você estiver num laboratório onde não pode instalar programas, use o **[draw.io](https://app.diagrams.net/)**, que roda no navegador. Ele tem estêncil de ER e desenha as formas de Chen à mão — mas **não converte para o modelo lógico**: essa parte você faz no papel, com as regras da Aula 07.

## 4. Para rascunhar

Nada disso é obrigatório, mas ajuda:

- **[dbdiagram.io](https://dbdiagram.io/)** — rápido, notação pé-de-galinha, bom para esboçar tabelas;
- **[mermaid.live](https://mermaid.live)** — o mais próximo do que você entrega, porque é a mesma sintaxe.

> 📏 **Regra do curso:** rascunhe onde quiser, **entregue em Mermaid**. A imagem exportada da ferramenta acompanha a entrega quando o modelo é grande demais para o Mermaid — mas nunca sozinha. Imagem não faz *diff*, não recebe comentário de linha no Pull Request e envelhece mal.

## ✅ Checklist final

Para começar o curso:

- [ ] Repositório `exercicios-modelagem-dados` criado, público e clonado;
- [ ] Um commit de teste já apareceu no GitHub;
- [ ] Editor com preview de Markdown funcionando (ou [mermaid.live](https://mermaid.live) aberto num favorito);
- [ ] Um diagrama Mermaid de teste renderizou — copie o do [guia de notações](notacoes-der.md) e confira.

Para o Bloco 3 (pode ficar para antes da Aula 12):

- [ ] brModelo abre, ou o draw.io está acessível no seu navegador;
- [ ] o teste de dois minutos da seção 3 produziu um esquema lógico.

---

🏠 [Voltar ao início](../README.md)
