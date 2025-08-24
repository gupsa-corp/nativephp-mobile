#!/bin/bash

# Gupsa Mobile - 시스템 상태 확인 스크립트
# Check system status and diagnose issues

echo "🔍 Gupsa Mobile 시스템 상태를 확인합니다..."
echo ""

# 필수 파일 확인
echo "📁 필수 파일 확인:"

REQUIRED_FILES=(
    "public/index.php"
    "bootstrap/app.php"
    "artisan"
    ".env"
    "composer.json"
    "app/Http/Controllers/WelcomeController.php"
    "resources/views/welcome.blade.php"
    "routes/web.php"
)

ALL_GOOD=true

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file (누락)"
        ALL_GOOD=false
    fi
done

echo ""

# 디렉토리 확인
echo "📂 필수 디렉토리 확인:"

REQUIRED_DIRS=(
    "vendor"
    "storage/logs"
    "storage/framework/cache"
    "storage/framework/sessions"
    "storage/framework/views"
    "bootstrap/cache"
    "database"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "  ✅ $dir"
    else
        echo "  ❌ $dir (누락)"
        ALL_GOOD=false
    fi
done

echo ""

# 권한 확인
echo "🔐 권한 확인:"
if [ -w "storage" ] && [ -w "bootstrap/cache" ]; then
    echo "  ✅ 쓰기 권한 정상"
else
    echo "  ⚠️ 권한 문제 감지"
    echo "     다음 명령어로 수정: chmod -R 755 storage bootstrap/cache"
    ALL_GOOD=false
fi

# APP_KEY 확인  
echo "🔑 APP_KEY 확인:"
if [ -f ".env" ] && grep -q "APP_KEY=base64:" .env; then
    echo "  ✅ APP_KEY 설정됨"
else
    echo "  ❌ APP_KEY 누락"
    echo "     다음 명령어로 생성: php artisan key:generate"
    ALL_GOOD=false
fi

# 포트 사용 확인
echo "🌐 포트 9997 확인:"
if lsof -i:9997 > /dev/null 2>&1; then
    echo "  ✅ 포트 9997 사용 중 (서버 실행 중)"
    echo "     서버 URL: http://localhost:9997"
else
    echo "  ⚠️ 포트 9997 사용 안함 (서버 중지됨)"
    echo "     서버 시작: ./start.sh"
fi

# 전체 상태 요약
echo ""
echo "📊 전체 상태:"
if [ "$ALL_GOOD" = true ]; then
    echo "  🎉 모든 것이 정상입니다!"
    echo "     브라우저에서 http://localhost:9997 접속 가능"
else
    echo "  ⚠️ 일부 문제가 발견되었습니다."
    echo "     위의 지침에 따라 수정하거나 ./fresh.sh 실행"
fi

echo ""

# 서버 상태 테스트 (서버가 실행 중이라면)
if lsof -i:9997 > /dev/null 2>&1; then
    echo "🌐 서버 응답 테스트 중..."
    if curl -s -o /dev/null -w "%{http_code}" http://localhost:9997 | grep -q "200"; then
        echo "  ✅ 서버가 정상 응답합니다"
        echo "     메인 화면: http://localhost:9997"
    else
        echo "  ⚠️ 서버 응답 문제 감지"
        echo "     로그 확인: storage/logs/laravel.log"
    fi
fi

echo ""