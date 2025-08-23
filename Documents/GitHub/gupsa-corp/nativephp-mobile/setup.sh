#!/bin/bash

# Gupsa Mobile - 초기 설정 스크립트
# Initial setup for development

echo "🛠️ Gupsa Mobile 개발 환경을 설정합니다..."
echo ""

# PHP 버전 확인
echo "📋 시스템 요구사항 확인 중..."
PHP_VERSION=$(php -r "echo PHP_VERSION;" 2>/dev/null)
if [ $? -ne 0 ]; then
    echo "❌ PHP가 설치되지 않았습니다."
    exit 1
fi

PHP_MAJOR=$(echo $PHP_VERSION | cut -d. -f1)
PHP_MINOR=$(echo $PHP_VERSION | cut -d. -f2)

if [ "$PHP_MAJOR" -lt 8 ] || ([ "$PHP_MAJOR" -eq 8 ] && [ "$PHP_MINOR" -lt 2 ]); then
    echo "❌ PHP 8.2 이상이 필요합니다. 현재: $PHP_VERSION"
    exit 1
else
    echo "✅ PHP 버전: $PHP_VERSION"
fi

# Composer 확인
if ! command -v composer &> /dev/null; then
    echo "❌ Composer가 설치되지 않았습니다."
    exit 1
else
    echo "✅ Composer 설치됨"
fi

# Composer 의존성 설치
if [ ! -d "vendor" ]; then
    echo ""
    echo "📦 Composer 의존성을 설치합니다..."
    composer install
    if [ $? -ne 0 ]; then
        echo "❌ Composer 설치 실패"
        exit 1
    fi
else
    echo "✅ Composer 의존성이 이미 설치되어 있습니다."
fi

# .env 파일 설정
if [ ! -f ".env" ]; then
    echo "📝 환경 설정 파일을 생성합니다..."
    cp .env.example .env
    echo "✅ .env 파일 생성됨"
else
    echo "✅ .env 파일이 이미 존재합니다."
fi

# 애플리케이션 키 생성
if ! grep -q "APP_KEY=base64:" .env; then
    echo "🔑 애플리케이션 키를 생성합니다..."
    php artisan key:generate
    echo "✅ APP_KEY 생성됨"
else
    echo "✅ APP_KEY가 이미 설정되어 있습니다."
fi

# 필요한 디렉토리 생성
echo "📁 필요한 디렉토리를 생성합니다..."
mkdir -p bootstrap/cache
mkdir -p storage/{app/public,framework/{cache/data,sessions,testing,views},logs}
chmod -R 755 storage bootstrap/cache
echo "✅ 디렉토리 구조 생성됨"

# 데이터베이스 파일 생성
if [ ! -f "database/database.sqlite" ]; then
    echo "🗄️ SQLite 데이터베이스를 생성합니다..."
    touch database/database.sqlite
    echo "✅ 데이터베이스 파일 생성됨"
else
    echo "✅ 데이터베이스 파일이 이미 존재합니다."
fi

echo ""
echo "🎉 설정이 완료되었습니다!"
echo ""
echo "다음 단계:"
echo "  1. ./start.sh 실행하여 서버 시작"
echo "  2. 브라우저에서 http://localhost:9997 접속"
echo ""
echo "추가 명령어:"
echo "  ./dev.sh     - 개발 모드로 시작"
echo "  ./fresh.sh   - 완전히 새로 설정"
echo ""