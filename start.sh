#!/bin/bash

# Gupsa Mobile - 개발 서버 시작 스크립트
# Start development server on port 9997

echo "🚀 Gupsa Mobile 개발 서버를 시작합니다..."
echo ""

# 의존성 확인
if [ ! -d "vendor" ]; then
    echo "⚠️ Composer 의존성이 설치되지 않았습니다."
    echo "   composer install을 먼저 실행하세요."
    exit 1
fi

# .env 파일 확인
if [ ! -f ".env" ]; then
    echo "⚠️ .env 파일이 없습니다."
    echo "   setup.sh를 먼저 실행하세요."
    exit 1
fi

# APP_KEY 확인
if ! grep -q "APP_KEY=base64:" .env; then
    echo "🔑 애플리케이션 키를 생성합니다..."
    php artisan key:generate
fi

# 캐시 클리어
echo "🧹 캐시를 정리합니다..."
php artisan config:clear
php artisan route:clear
php artisan view:clear

# 서버 시작
echo "✅ 서버를 시작합니다 - http://localhost:9997"
echo ""
echo "브라우저에서 http://localhost:9997에 접속하세요!"
echo "서버를 중지하려면 Ctrl+C를 누르세요."
echo ""

php artisan serve --port=9997