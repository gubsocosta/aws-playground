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

## Realiza a instalação das dependências do laravel_app
echo "📦 Instalando as dependências do laravel_app..."
docker compose exec laravel_app sh -c "composer install"

## Cria o arquivo .env do laravel_app
echo "📝 Criando o arquivo .env do laravel_app..."
docker compose exec laravel_app sh -c "cp .env.example .env"

## Gera a chave de aplicação do laravel_app
echo "🔑 Gerando a chave de aplicação do laravel_app..."
docker compose exec laravel_app sh -c "php artisan key:generate"

echo "✅ Setup concluído"