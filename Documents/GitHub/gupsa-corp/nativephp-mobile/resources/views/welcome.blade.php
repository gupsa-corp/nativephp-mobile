<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    
    <title>{{ __('app.app_name') }}</title>
    
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
    <link rel="manifest" href="{{ asset('manifest.json') }}">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=noto-sans-kr:400,500,600,700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="app-container">
        <!-- Splash Screen -->
        <div id="splash-screen" class="splash-screen">
            <div class="splash-content">
                <div class="logo-container">
                    <div class="logo">
                        <svg viewBox="0 0 100 100" class="logo-svg">
                            <circle cx="50" cy="50" r="45" fill="none" stroke="#4F46E5" stroke-width="4"/>
                            <path d="M25 50 L45 70 L75 30" fill="none" stroke="#4F46E5" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <h1 class="app-title">{{ __('app.app_name') }}</h1>
                    <p class="app-subtitle">{{ __('app.description') }}</p>
                </div>
                
                <div class="loading-container">
                    <div class="loading-spinner"></div>
                    <p class="loading-text">{{ __('app.loading') }}</p>
                </div>
            </div>
            
            <div class="splash-footer">
                <p class="powered-by">{{ __('app.powered_by') }}</p>
                <p class="version">{{ __('app.version') }} {{ config('app.version', '1.0.0') }}</p>
            </div>
        </div>

        <!-- Main App Screen -->
        <div id="main-screen" class="main-screen" style="display: none;">
            <header class="app-header">
                <h1>{{ __('app.welcome') }}</h1>
                <p>{{ __('app.description') }}</p>
            </header>

            <main class="app-main">
                <div class="welcome-card">
                    <div class="card-icon">
                        <svg viewBox="0 0 24 24" fill="currentColor">
                            <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                        </svg>
                    </div>
                    <h2>{{ __('app.get_started') }}</h2>
                    <p>NativePHP를 사용하여 PHP로 개발된 네이티브 안드로이드 앱입니다.</p>
                    
                    <div class="action-buttons">
                        <button class="btn btn-primary" onclick="showFeatures()">
                            기능 둘러보기
                        </button>
                        <button class="btn btn-secondary" onclick="showSettings()">
                            설정
                        </button>
                    </div>
                </div>

                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">📱</div>
                        <h3>네이티브 성능</h3>
                        <p>PHP로 작성된 코드가 네이티브 성능으로 실행됩니다.</p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">🔒</div>
                        <h3>보안</h3>
                        <p>생체인증과 보안 저장소를 지원합니다.</p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">📍</div>
                        <h3>위치 서비스</h3>
                        <p>GPS와 위치 기반 서비스를 이용할 수 있습니다.</p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">📸</div>
                        <h3>카메라</h3>
                        <p>카메라와 갤러리에 접근할 수 있습니다.</p>
                    </div>
                </div>
            </main>

            <footer class="app-footer">
                <p>{{ __('app.copyright') }}</p>
            </footer>
        </div>
    </div>

    <script src="{{ asset('js/app.js') }}"></script>
</body>
</html>