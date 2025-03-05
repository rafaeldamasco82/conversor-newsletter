![Status da Action - Gerar PDF](https://github.com/rafaeldamasco82/conversor-newsletter/actions/workflows/gerar-pdf.yml/badge.svg)


# Newsletter PDF Converter

## 📝 Descrição
Ferramenta automatizada para conversão de newsletters HTML para PDF, com suporte para configurações personalizadas e geração via linha de comando ou GitHub Actions.

## ✨ Funcionalidades
- Conversão de HTML para PDF com configurações personalizáveis
- Script de geração local de PDFs
- Workflow do GitHub Actions para geração automatizada

## 🔧 Requisitos
- Node.js (versão 20 ou superior)
- Puppeteer (versão 22.8.2 ou superior)

## 🚀 Instalação
1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/conversor-newsletter.git
cd conversor-newsletter
```

2. Instale as dependências
```bash
npm install
```

## 📋 Configuração
### Configuração Global
O arquivo `pdf-config.json` pode ser personalizado para ajustar as configurações de geração do PDF.

Exemplo de configuração:
```json
{
  "format": "A4",
  "margin": {
    "top": "20mm",
    "bottom": "20mm",
    "left": "15mm",
    "right": "15mm"
  },
  "printBackground": true,
  "landscape": false,
  "scale": 1
}
```

## 💻 Uso Local
### Gerar PDF de uma newsletter
```bash
./gerar-pdf.sh <nome-do-mes>
```
Exemplo:
```bash
./gerar-pdf.sh marco
```

## 🤖 GitHub Actions
O workflow `gerar-pdf.yml` permite gerar PDFs diretamente no GitHub:
- Acesse a aba "Actions" do repositório
- Selecione o workflow "Gerar PDF da Newsletter"
- Escolha o mês da edição para gerar o PDF

## 📂 Estrutura do Projeto
```
conversor-newsletter/
│
├── conversor.js        # Script principal de conversão
├── gerar-pdf.sh        # Script para geração local de PDFs
├── package.json        # Configurações do projeto
└── newsletters/
    ├── marco/
    │   ├── index.html
    │  
    └── abril/
        ├── index.html
       
```

## 🛠️ Dependências
- Puppeteer: Biblioteca para conversão de HTML para PDF

## 🤝 Contribuição
1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas alterações (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 🔍 Solução de Problemas
- Verifique se todas as dependências estão instaladas
- Consulte os logs em `logs/` para diagnóstico de erros
- Certifique-se de que o arquivo `index.html` está presente na pasta da edição

