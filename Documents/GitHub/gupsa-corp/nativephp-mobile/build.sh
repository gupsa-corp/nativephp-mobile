#!/bin/bash

# Gupsa Mobile - 프로덕션 빌드 스크립트
# Production build for NativePHP Mobile app

echo "📦 Gupsa Mobile 프로덕션 빌드를 시작합니다..."
echo ""

# 환경 확인
if [ ! -f ".env" ]; then
    echo "❌ .env 파일이 없습니다. setup.sh를 먼저 실행하세요."
    exit 1
fi

if [ ! -d "vendor" ]; then
    echo "❌ Composer 의존성이 없습니다. setup.sh를 먼저 실행하세요."
    exit 1
fi

# 프로덕션 환경 설정
echo "🔧 프로덕션 환경을 설정합니다..."

# .env를 프로덕션 모드로 변경
cp .env .env.backup
sed -i '' 's/APP_ENV=local/APP_ENV=production/' .env 2>/dev/null || \
sed -i 's/APP_ENV=local/APP_ENV=production/' .env
sed -i '' 's/APP_DEBUG=true/APP_DEBUG=false/' .env 2>/dev/null || \
sed -i 's/APP_DEBUG=true/APP_DEBUG=false/' .env

echo "✅ 환경 설정 완료"

# 캐시 및 최적화
echo "⚡ 애플리케이션을 최적화합니다..."
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan event:cache

# Composer 최적화
echo "📦 Composer 최적화 중..."
composer install --optimize-autoloader --no-dev

# 파일 권한 설정
echo "🔐 파일 권한을 설정합니다..."
chmod -R 755 storage bootstrap/cache

echo "✅ 최적화 완료"

# NativePHP 빌드 시도 (라이선스가 있다면)
echo ""
echo "📱 NativePHP 빌드를 확인합니다..."
if php artisan list | grep -q "native:"; then
    echo "🔥 NativePHP 명령어를 사용할 수 있습니다."
    echo ""
    read -p "📱 네이티브 앱을 빌드하시겠습니까? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🏗️ 네이티브 앱 빌드 중..."
        php artisan native:build
        
        read -p "📱 APK 파일을 생성하시겠습니까? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "📦 APK 생성 중..."
            php artisan native:build --apk
        fi
    fi
else
    echo "⚠️ NativePHP Mobile이 설치되지 않았습니다."
    echo "   웹 버전만 빌드됩니다."
fi

# 빌드 정보 생성
echo ""
echo "📋 빌드 정보를 생성합니다..."
BUILD_TIME=$(date)
BUILD_VERSION=$(grep "NATIVEPHP_APP_VERSION" .env | cut -d'=' -f2 | tr -d '"')
BUILD_INFO="build-info.txt"

cat > $BUILD_INFO << EOF
Gupsa Mobile 빌드 정보
========================

빌드 시간: $BUILD_TIME
앱 버전: ${BUILD_VERSION:-"1.0.0"}
환경: Production
PHP 버전: $(php -r 'echo PHP_VERSION;')
Laravel 버전: $(php artisan --version | cut -d' ' -f3)

최적화 상태:
✅ Config Cache
✅ Route Cache  
✅ View Cache
✅ Event Cache
✅ Autoloader Optimization

빌드 파일 위치:
- 웹 앱: public/
- APK: nativephp/android/app/build/outputs/apk/ (있다면)

배포 준비 완료! 🚀
EOF

echo "✅ 빌드 정보 저장됨: $BUILD_INFO"

# .env 복원 옵션
echo ""
read -p "🔄 개발 환경 설정을 복원하시겠습니까? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mv .env.backup .env
    echo "✅ 개발 환경으로 복원됨"
    
    # 캐시 클리어
    php artisan config:clear
    php artisan route:clear
    php artisan view:clear
    php artisan cache:clear
    
    # dev dependencies 재설치
    composer install
else
    rm .env.backup
fi

echo ""
echo "🎉 빌드가 완료되었습니다!"
echo "📋 빌드 정보: $BUILD_INFO"
echo ""