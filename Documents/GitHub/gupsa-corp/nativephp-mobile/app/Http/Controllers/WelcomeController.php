<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\View\View;

class WelcomeController extends Controller
{
    /**
     * Display the welcome screen (initial screen)
     */
    public function index(Request $request): View
    {
        $appInfo = [
            'name' => config('app.name'),
            'version' => config('nativephp.app_version', '1.0.0'),
            'locale' => app()->getLocale(),
            'features' => $this->getAvailableFeatures(),
        ];

        return view('welcome', compact('appInfo'));
    }

    /**
     * Display features information
     */
    public function features(): View
    {
        $features = [
            [
                'icon' => '📱',
                'title' => '네이티브 성능',
                'description' => 'PHP로 작성된 코드가 네이티브 성능으로 실행됩니다.',
                'available' => true,
            ],
            [
                'icon' => '🔒',
                'title' => '보안',
                'description' => '생체인증과 보안 저장소를 지원합니다.',
                'available' => $this->isBiometricAvailable(),
            ],
            [
                'icon' => '📍',
                'title' => '위치 서비스',
                'description' => 'GPS와 위치 기반 서비스를 이용할 수 있습니다.',
                'available' => $this->isLocationAvailable(),
            ],
            [
                'icon' => '📸',
                'title' => '카메라',
                'description' => '카메라와 갤러리에 접근할 수 있습니다.',
                'available' => $this->isCameraAvailable(),
            ],
            [
                'icon' => '🔔',
                'title' => '푸시 알림',
                'description' => '사용자에게 알림을 전송할 수 있습니다.',
                'available' => $this->isNotificationAvailable(),
            ],
            [
                'icon' => '💾',
                'title' => '로컬 저장소',
                'description' => '앱 데이터를 안전하게 저장합니다.',
                'available' => true,
            ],
        ];

        return view('features', compact('features'));
    }

    /**
     * Display settings screen
     */
    public function settings(): View
    {
        $settings = [
            'language' => app()->getLocale(),
            'theme' => 'light', // Default theme
            'notifications' => true,
            'location' => false,
            'version' => config('nativephp.app_version', '1.0.0'),
            'build' => config('nativephp.app_version_code', 1),
        ];

        return view('settings', compact('settings'));
    }

    /**
     * API: Get app information
     */
    public function appInfo(): JsonResponse
    {
        return response()->json([
            'name' => config('app.name'),
            'version' => config('nativephp.app_version', '1.0.0'),
            'build' => config('nativephp.app_version_code', 1),
            'locale' => app()->getLocale(),
            'timezone' => config('app.timezone'),
            'features' => $this->getAvailableFeatures(),
            'permissions' => $this->getPermissions(),
        ]);
    }

    /**
     * API: Get device information
     */
    public function deviceInfo(Request $request): JsonResponse
    {
        $userAgent = $request->header('User-Agent', '');
        
        return response()->json([
            'user_agent' => $userAgent,
            'is_android' => $this->isAndroid($userAgent),
            'is_ios' => $this->isIOS($userAgent),
            'is_mobile' => $this->isMobile($userAgent),
            'platform' => $this->getPlatform($userAgent),
            'screen_size' => [
                'width' => $request->get('screen_width'),
                'height' => $request->get('screen_height'),
            ],
            'viewport_size' => [
                'width' => $request->get('viewport_width'),
                'height' => $request->get('viewport_height'),
            ],
        ]);
    }

    /**
     * Get available app features
     */
    private function getAvailableFeatures(): array
    {
        return [
            'camera' => $this->isCameraAvailable(),
            'biometric' => $this->isBiometricAvailable(),
            'location' => $this->isLocationAvailable(),
            'notifications' => $this->isNotificationAvailable(),
            'storage' => true,
            'networking' => true,
        ];
    }

    /**
     * Check if camera is available
     */
    private function isCameraAvailable(): bool
    {
        // In a real NativePHP environment, this would check native capabilities
        // For now, assume it's available on mobile platforms
        return true;
    }

    /**
     * Check if biometric authentication is available
     */
    private function isBiometricAvailable(): bool
    {
        // In a real NativePHP environment, this would check device capabilities
        return true;
    }

    /**
     * Check if location services are available
     */
    private function isLocationAvailable(): bool
    {
        // Check if location permission is granted
        return true;
    }

    /**
     * Check if notifications are available
     */
    private function isNotificationAvailable(): bool
    {
        return true;
    }

    /**
     * Get app permissions
     */
    private function getPermissions(): array
    {
        return config('nativephp.android.permissions', []);
    }

    /**
     * Check if the user agent indicates Android
     */
    private function isAndroid(string $userAgent): bool
    {
        return stripos($userAgent, 'Android') !== false;
    }

    /**
     * Check if the user agent indicates iOS
     */
    private function isIOS(string $userAgent): bool
    {
        return stripos($userAgent, 'iPhone') !== false || 
               stripos($userAgent, 'iPad') !== false ||
               stripos($userAgent, 'iPod') !== false;
    }

    /**
     * Check if the user agent indicates a mobile device
     */
    private function isMobile(string $userAgent): bool
    {
        return $this->isAndroid($userAgent) || 
               $this->isIOS($userAgent) ||
               stripos($userAgent, 'Mobile') !== false;
    }

    /**
     * Get platform from user agent
     */
    private function getPlatform(string $userAgent): string
    {
        if ($this->isAndroid($userAgent)) {
            return 'android';
        }
        
        if ($this->isIOS($userAgent)) {
            return 'ios';
        }
        
        if ($this->isMobile($userAgent)) {
            return 'mobile';
        }
        
        return 'desktop';
    }
}