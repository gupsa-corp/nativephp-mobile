#!/bin/bash

# Gupsa Mobile - 개발 모드 스크립트
# Enhanced development mode with debugging and auto-reload

echo "🔧 Gupsa Mobile 개발 모드를 시작합니다..."
echo ""

# 의존성 확인
if [ ! -d "vendor" ]; then
    echo "📦 의존성 설치 중..."
    ./setup.sh
fi

# 환경 변수를 개발 모드로 설정
echo "🛠️ 개발 환경을 설정합니다..."

# .env에서 디버그 모드 확인/설정
if ! grep -q "APP_DEBUG=true" .env; then
    sed -i '' 's/APP_DEBUG=false/APP_DEBUG=true/' .env 2>/dev/null || \
    sed -i 's/APP_DEBUG=false/APP_DEBUG=true/' .env 2>/dev/null || \
    echo "APP_DEBUG=true" >> .env
fi

# 로그 레벨 설정
if ! grep -q "LOG_LEVEL=debug" .env; then
    sed -i '' 's/LOG_LEVEL=.*/LOG_LEVEL=debug/' .env 2>/dev/null || \
    sed -i 's/LOG_LEVEL=.*/LOG_LEVEL=debug/' .env 2>/dev/null || \
    echo "LOG_LEVEL=debug" >> .env
fi

echo "✅ 개발 환경 설정 완료"

# 캐시 및 설정 클리어
echo "🧹 개발용 캐시를 정리합니다..."
php artisan config:clear
php artisan route:clear 
php artisan view:clear
php artisan cache:clear

# 권한 설정
echo "🔐 권한을 설정합니다..."
chmod -R 755 storage bootstrap/cache

# 개발용 정보 표시
echo ""
echo "📊 개발 환경 정보:"
echo "   - PHP 버전: $(php -r 'echo PHP_VERSION;')"
echo "   - Laravel 버전: $(php artisan --version | cut -d' ' -f3)"
echo "   - 디버그 모드: 활성화"
echo "   - 로그 레벨: debug"
echo "   - 데이터베이스: SQLite"
echo ""

# 개발 서버 시작 (더 많은 디버그 정보와 함께)
echo "🚀 개발 서버를 시작합니다..."
echo ""
echo "📍 접속 주소: http://localhost:9997"
echo "📍 로그 파일: storage/logs/laravel.log"
echo ""
echo "💡 개발 팁:"
echo "   - 코드 변경 시 자동으로 반영됩니다"
echo "   - 오류 발생 시 상세한 디버그 정보를 확인할 수 있습니다"
echo "   - Ctrl+C로 서버를 중지할 수 있습니다"
echo ""

# Artisan 명령어 별칭 생성
echo "🔧 개발용 명령어:"
echo "   php artisan tinker      - 인터랙티브 쉘"
echo "   php artisan route:list  - 라우트 목록"
echo "   php artisan config:show - 설정 확인"
echo ""

php artisan serve --port=9997 --host=0.0.0.0