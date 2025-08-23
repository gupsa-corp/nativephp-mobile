#!/bin/bash

# Gupsa Mobile - 도움말 스크립트
# Help and information for developers

echo "📚 Gupsa Mobile 개발 가이드"
echo "=========================="
echo ""

echo "🚀 주요 명령어:"
echo ""
echo "  ./setup.sh    - 초기 설정 (최초 1회 실행)"
echo "  ./start.sh    - 개발 서버 시작 (포트 9997)"
echo "  ./dev.sh      - 향상된 개발 모드"
echo "  ./build.sh    - 프로덕션 빌드"
echo "  ./fresh.sh    - 완전 초기화"
echo "  ./help.sh     - 이 도움말"
echo ""

echo "📁 프로젝트 구조:"
echo ""
echo "  app/                    - 애플리케이션 코드"
echo "  ├── Http/Controllers/   - 컨트롤러"
echo "  └── Providers/         - 서비스 프로바이더"
echo "  config/                - 설정 파일"
echo "  public/                - 웹 자산 (CSS, JS, 이미지)"
echo "  resources/             - 뷰, 언어 파일"
echo "  ├── views/             - Blade 템플릿"
echo "  └── lang/ko/           - 한국어 번역"
echo "  routes/                - 라우트 정의"
echo "  storage/               - 로그, 캐시, 세션"
echo ""

echo "🌐 주요 URL:"
echo ""
echo "  http://localhost:9997   - 메인 앱"
echo "  http://localhost:9997/features - 기능 소개"
echo "  http://localhost:9997/settings - 설정"
echo ""

echo "🔧 개발 명령어:"
echo ""
echo "  php artisan serve --port=9997   - 서버 시작"
echo "  php artisan tinker              - 인터랙티브 쉘"
echo "  php artisan route:list          - 라우트 목록"
echo "  php artisan config:show         - 설정 확인"
echo "  php artisan cache:clear         - 캐시 클리어"
echo ""

echo "📱 NativePHP 명령어 (라이선스 필요):"
echo ""
echo "  php artisan native:install      - NativePHP 설치"
echo "  php artisan native:run          - 네이티브 앱 실행"
echo "  php artisan native:build        - 네이티브 앱 빌드"
echo "  php artisan native:build --apk  - APK 파일 생성"
echo ""

echo "🐛 문제 해결:"
echo ""
echo "  권한 오류:"
echo "    chmod -R 755 storage bootstrap/cache"
echo ""
echo "  캐시 문제:"
echo "    php artisan cache:clear"
echo "    php artisan config:clear"
echo ""
echo "  의존성 문제:"
echo "    composer install"
echo "    ./fresh.sh (완전 초기화)"
echo ""

echo "📋 파일 설명:"
echo ""
echo "  .env                           - 환경 설정"
echo "  composer.json                  - PHP 의존성"
echo "  resources/views/welcome.blade.php - 메인 화면"
echo "  public/css/app.css            - 스타일시트"
echo "  public/js/app.js              - JavaScript"
echo "  config/nativephp.php          - NativePHP 설정"
echo ""

echo "💡 개발 팁:"
echo ""
echo "  1. 코드 변경 시 브라우저에서 새로고침"
echo "  2. 로그는 storage/logs/laravel.log에서 확인"
echo "  3. 한국어 번역은 resources/lang/ko/app.php 수정"
echo "  4. 스타일은 public/css/app.css 수정"
echo "  5. JavaScript는 public/js/app.js 수정"
echo ""

echo "🆘 지원:"
echo ""
echo "  GitHub: https://github.com/gupsa-corp/nativephp-mobile"
echo "  이메일: support@gupsa.com"
echo "  Laravel 문서: https://laravel.com/docs"
echo "  NativePHP 문서: https://nativephp.com/docs"
echo ""

# 시스템 정보 표시
echo "🖥️ 시스템 정보:"
echo ""
echo "  PHP 버전: $(php -r 'echo PHP_VERSION;')"
if [ -f "vendor/laravel/framework/src/Illuminate/Foundation/Application.php" ]; then
    echo "  Laravel 버전: $(php artisan --version 2>/dev/null | cut -d' ' -f3 || echo '설치 필요')"
fi
echo "  운영체제: $(uname -s)"
echo "  현재 디렉토리: $(pwd)"
echo ""

# 상태 확인
echo "📊 프로젝트 상태:"
echo ""
if [ -f ".env" ]; then
    echo "  ✅ .env 파일 존재"
else
    echo "  ❌ .env 파일 없음 - setup.sh 실행 필요"
fi

if [ -d "vendor" ]; then
    echo "  ✅ Composer 의존성 설치됨"
else
    echo "  ❌ Composer 의존성 없음 - composer install 필요"
fi

if [ -f "database/database.sqlite" ]; then
    echo "  ✅ SQLite 데이터베이스 존재"
else
    echo "  ❌ 데이터베이스 없음 - setup.sh 실행 필요"
fi

if grep -q "APP_KEY=base64:" .env 2>/dev/null; then
    echo "  ✅ 애플리케이션 키 설정됨"
else
    echo "  ❌ 애플리케이션 키 없음 - php artisan key:generate 필요"
fi
echo ""