const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

(async () => {
  console.log('🔍 Iniciando processo de conversão');
  console.log('📂 Diretório atual:', process.cwd());
  console.log('🛠️ Argumentos recebidos:', process.argv);

  const [inputHtml, outputPdf] = process.argv.slice(2);

  if (!inputHtml || !outputPdf) {
    console.error('❌ Uso: node conversor.js <input.html> <output.pdf>');
    process.exit(1);
  }

  console.log(`📄 HTML de entrada: ${inputHtml}`);
  console.log(`📑 PDF de saída: ${outputPdf}`);

  // Verificações adicionais
  if (!fs.existsSync(inputHtml)) {
    console.error(`❌ Arquivo de entrada não encontrado: ${inputHtml}`);
    process.exit(1);
  }

  try {
    const browser = await puppeteer.launch({
      headless: 'new',
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();
    
    const fullPath = path.resolve(inputHtml);
    console.log(`🔗 Caminho completo do HTML: ${fullPath}`);

    await page.goto(`file://${fullPath}`, { waitUntil: 'networkidle0' });

    await page.pdf({
      path: outputPdf,
      format: 'A4',
      margin: {
        top: '20mm',
        bottom: '20mm',
        left: '15mm',
        right: '15mm'
      },
      printBackground: true
    });

    await browser.close();

    console.log(`✅ PDF gerado com sucesso: ${outputPdf}`);
  } catch (error) {
    console.error('❌ Erro na geração do PDF:', error);
    process.exit(1);
  }
})();