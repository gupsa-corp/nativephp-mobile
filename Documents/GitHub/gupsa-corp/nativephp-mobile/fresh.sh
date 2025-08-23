#!/bin/bash

# Gupsa Mobile - 완전 초기화 스크립트
# Complete fresh installation and cleanup

echo "🔄 Gupsa Mobile 완전 초기화를 시작합니다..."
echo ""

# 확인 프롬프트
read -p "⚠️ 모든 데이터와 설정이 초기화됩니다. 계속하시겠습니까? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ 초기화가 취소되었습니다."
    exit 1
fi

echo "🧹 기존 파일들을 정리합니다..."

# Composer 의존성 제거
if [ -d "vendor" ]; then
    echo "📦 Composer 의존성 제거 중..."
    rm -rf vendor
fi

# Composer lock 파일 제거
if [ -f "composer.lock" ]; then
    rm composer.lock
fi

# Node modules 제거 (있다면)
if [ -d "node_modules" ]; then
    echo "📦 Node modules 제거 중..."
    rm -rf node_modules
fi

# 캐시 파일 제거
echo "🗑️ 캐시 파일 제거 중..."
rm -rf bootstrap/cache/*
rm -rf storage/framework/cache/data/*
rm -rf storage/framework/sessions/*
rm -rf storage/framework/views/*
rm -rf storage/logs/*

# 데이터베이스 초기화
if [ -f "database/database.sqlite" ]; then
    echo "🗄️ 데이터베이스 초기화 중..."
    rm database/database.sqlite
    touch database/database.sqlite
fi

# .env 파일 초기화
if [ -f ".env" ]; then
    echo "⚙️ 환경설정 초기화 중..."
    rm .env
fi

echo "✅ 정리 완료!"
echo ""

# 새로 설정 시작
echo "🛠️ 새로운 설정을 시작합니다..."
./setup.sh

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 완전 초기화가 완료되었습니다!"
    echo ""
    echo "다음 명령어로 서버를 시작하세요:"
    echo "  ./start.sh"
    echo ""
else
    echo ""
    echo "❌ 설정 중 오류가 발생했습니다."
    echo "   수동으로 setup.sh를 다시 실행해주세요."
fi