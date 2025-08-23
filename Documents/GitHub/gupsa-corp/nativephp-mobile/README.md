# Gupsa Mobile - NativePHP Android App

PHP로 개발된 네이티브 안드로이드 앱입니다. Laravel과 NativePHP Mobile을 사용하여 구축되었습니다.

## 기능

- 📱 네이티브 안드로이드 성능
- 🔒 생체 인증 지원
- 📍 위치 서비스
- 📸 카메라 접근
- 🔔 푸시 알림
- 💾 로컬 저장소
- 🌐 PWA 지원

## 🚀 빠른 시작 (자동화 스크립트 사용)

### 한 번의 명령으로 설정 완료:
```bash
./setup.sh    # 초기 설정 (최초 1회)
./start.sh    # 서버 시작 (포트 9997)
```

### 주요 스크립트:
- `./setup.sh` - 전체 초기 설정 자동화
- `./start.sh` - 개발 서버 시작
- `./dev.sh` - 향상된 개발 모드 (디버그 + 자동 리로드)
- `./build.sh` - 프로덕션 빌드
- `./fresh.sh` - 완전 초기화
- `./help.sh` - 상세 도움말

## 설치 방법

### 사전 요구사항

1. PHP 8.2 이상
2. Composer
3. NativePHP Mobile 라이선스 (옵션)
4. Android Studio (네이티브 빌드용)

### 수동 설치 단계

1. 프로젝트 클론
```bash
git clone <repository-url>
cd nativephp-mobile
```

2. 의존성 설치
```bash
composer install
```

3. 환경 설정
```bash
cp .env.example .env
php artisan key:generate
```

4. 웹 브라우저에서 테스트
```bash
php artisan serve --port=9997
```
브라우저에서 http://localhost:9997 접속

5. NativePHP Mobile 설치 (라이선스 필요시)
```bash
php artisan native:install
php artisan native:run
```

## 프로젝트 구조

```
nativephp-mobile/
├── app/
│   ├── Http/Controllers/
│   │   └── WelcomeController.php
│   └── Providers/
├── config/
│   ├── app.php
│   └── nativephp.php
├── public/
│   ├── css/
│   │   └── app.css
│   ├── js/
│   │   └── app.js
│   ├── images/
│   ├── manifest.json
│   └── sw.js
├── resources/
│   ├── views/
│   │   └── welcome.blade.php
│   └── lang/ko/
├── routes/
│   ├── web.php
│   └── console.php
└── .env
```

## 환경 변수 설정

`.env` 파일에서 다음 값들을 설정하세요:

```env
APP_NAME="Gupsa Mobile"
APP_LOCALE=ko

# NativePHP 설정
NATIVEPHP_APP_ID=com.gupsa.mobile
NATIVEPHP_APP_VERSION=1.0.0
NATIVEPHP_APP_VERSION_CODE=1
```

## 개발 가이드

### 새로운 화면 추가

1. `routes/web.php`에 라우트 추가
2. `app/Http/Controllers/`에 컨트롤러 생성
3. `resources/views/`에 뷰 파일 생성
4. 필요시 `public/css/app.css`에 스타일 추가

### 한국어 지원

- 언어 파일: `resources/lang/ko/app.php`
- 사용법: `{{ __('app.welcome') }}`

### 네이티브 기능 사용

NativePHP Mobile에서 제공하는 네이티브 기능들:

- 카메라: `Native\Laravel\Camera`
- 위치: `Native\Laravel\Location`
- 생체인증: `Native\Laravel\Biometric`
- 알림: `Native\Laravel\Notification`

## 빌드 및 배포

### 개발 빌드
```bash
php artisan native:build
```

### 프로덕션 빌드
```bash
php artisan native:build --production
```

### APK 생성
```bash
php artisan native:build --apk
```

## 문제 해결

### 일반적인 문제들

1. **Composer 의존성 오류**
   ```bash
   composer install --ignore-platform-reqs
   ```

2. **권한 문제**
   ```bash
   chmod -R 755 storage bootstrap/cache
   ```

3. **키 생성 오류**
   ```bash
   php artisan key:generate
   ```

### 디버깅

개발자 도구에서 콘솔 로그를 확인하세요:

```javascript
console.log('User Agent:', navigator.userAgent);
console.log('Available features:', window.mobileApp.checkNativeFeatures());
```

## 라이선스

MIT License

## 기여하기

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 지원

문의사항이 있으시면 다음으로 연락주세요:
- 이메일: support@gupsa.com
- 이슈 트래커: [GitHub Issues](https://github.com/gupsa-corp/nativephp-mobile/issues)

---

**참고**: 이 프로젝트는 NativePHP Mobile 라이선스가 필요합니다. 자세한 내용은 [NativePHP 공식 웹사이트](https://nativephp.com)를 참조하세요.