#!/bin/bash

# Detalhes de depuração
#set -x

# Verifica se o Node.js está instalado
if ! command -v node &> /dev/null; then
  echo "❌ Node.js não encontrado."
  echo "👉 Para instalar o Node.js no Ubuntu/WSL, execute:"
  echo "    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -"
  echo "    sudo apt-get install -y nodejs"
  exit 1
fi

# Verifica se o Puppeteer está listado no package.json
if ! grep -q '"puppeteer"' package.json; then
  echo "❌ Puppeteer não está instalado no projeto."
  echo "👉 Para instalar, execute na raiz do projeto:"
  echo "    npm install puppeteer"
  exit 1
fi

# Verifica a versão do Puppeteer e alerta se for inferior à 22.8.2
VERSAO_ATUAL=$(npm list puppeteer | grep puppeteer@ | awk -F@ '{print $2}')
VERSAO_MINIMA="22.8.2"
if [ "$(printf '%s\n' "$VERSAO_MINIMA" "$VERSAO_ATUAL" | sort -V | head -n1)" != "$VERSAO_MINIMA" ]; then
  echo "⚠️  Atenção: Você está utilizando Puppeteer na versão $VERSAO_ATUAL."
  echo "   A versão recomendada é $VERSAO_MINIMA ou superior."
  echo "👉 Para atualizar, execute:"
  echo "    npm install puppeteer@latest"
fi

# Diretório do script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Função de log
log() {
  local log_file="$1"
  shift
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$log_file"
}

# Função de erro
error_exit() {
  local log_file="$1"
  shift
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] ❌ ERRO: $*" | tee -a "$log_file"
  exit 1
}

# Função principal
main() {
  # Validação de entrada
  if [ -z "$1" ]; then
    error_exit "./logs/pdf-generation-error.log" "Por favor, informe o mês da edição (ex: marco)."
  fi

  MES=$1
  PASTA="$SCRIPT_DIR/newsletters/$MES"
  LOG_FILE="$SCRIPT_DIR/logs/pdf-generation-$MES-$(date +'%Y-%m-%d').log"

  # Informações de depuração
  echo "Versão atual do Puppeteer: $VERSAO_ATUAL"
  echo "Versão minima do Puppeteer: $VERSAO_MINIMA"
  echo "Diretório do script: $SCRIPT_DIR"
  echo "Pasta da newsletter: $PASTA"
  echo "Arquivo de log: $LOG_FILE"

  # Verificações
  if [ ! -d "$PASTA" ]; then
    error_exit "$LOG_FILE" "A pasta '$PASTA' não existe."
  fi

  if [ ! -f "$PASTA/index.html" ]; then
    error_exit "$LOG_FILE" "Arquivo 'index.html' não encontrado em '$PASTA'."
  fi

  # Log de início
  log "$LOG_FILE" "🚀 Iniciando geração de PDF para edição de $MES"

  # Mudar para o diretório da edição
  cd "$PASTA" || error_exit "$LOG_FILE" "Falha ao acessar diretório $PASTA"

  # Executar conversor
  node "$SCRIPT_DIR/conversor.js" index.html output.pdf >> "$LOG_FILE" 2>&1

  # Verificar geração do PDF
  if [ -f "output.pdf" ]; then
    log "$LOG_FILE" "✅ PDF gerado com sucesso em $PASTA/output.pdf"
    echo "✅ PDF gerado com sucesso em $PASTA/output.pdf"
  else
    error_exit "$LOG_FILE" "Falha ao gerar o PDF."
  fi
}

# Executar script principal
main "$@"