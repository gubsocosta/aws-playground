#!/bin/bash

set -e

## Verifica se o Docker esta instalado
if ! command -v docker  &> /dev/null; then
    echo "❌ Docker não está instalado. Por favor, instale o Docker antes de continuar."
    exit 1
fi

## Verifica se o Docker Compose esta instalado
if ! command -v docker compose  &> /dev/null; then
    echo "❌ Docker Compose não está instalado. Por favor, instale o Docker Compose antes de continuar."
    exit 1
fi

## Inicia os containers
echo "🚀 Iniciando os containers..."
docker compose up -d --build

## Realiza a instalação das dependências do laravel-app
echo "📦 Instalando as dependências do laravel-app..."
docker compose exec laravel-app sh -c "composer install"

## Cria o arquivo .env do laravel-app
echo "📝 Criando o arquivo .env do laravel-app..."
docker compose exec laravel-app sh -c "cp .env.example .env"

## Gera a chave de aplicação do laravel-app
echo "🔑 Gerando a chave de aplicação do laravel-app..."
docker compose exec laravel-app sh -c "php artisan key:generate"

## Cria ambiente virtual do chalice-app
echo "🐍 Criando ambiente virtual do chalice-app..."
docker compose exec chalice-app sh -c "python -m venv .venv"

## Instala as dependências do chalice-app
echo "📥 Instalando as dependências do chalice-app..."
docker compose exec chalice-app sh -c ". .venv/bin/activate && pip install -r requirements.txt && pip install -r requirements-dev.txt"

echo "✅ Setup concluído"