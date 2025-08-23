<?php

return [
    'app_id' => env('NATIVEPHP_APP_ID', 'com.gupsa.mobile'),
    'app_version' => env('NATIVEPHP_APP_VERSION', '1.0.0'),
    'app_version_code' => env('NATIVEPHP_APP_VERSION_CODE', 1),
    
    'deeplinks' => [
        'scheme' => 'gupsa',
        'host' => 'mobile',
    ],

    'android' => [
        'package_name' => env('NATIVEPHP_APP_ID', 'com.gupsa.mobile'),
        'min_sdk_version' => 24,
        'target_sdk_version' => 34,
        'compile_sdk_version' => 34,
        'build_tools_version' => '34.0.0',
        'permissions' => [
            'android.permission.INTERNET',
            'android.permission.ACCESS_NETWORK_STATE',
            'android.permission.WAKE_LOCK',
            'android.permission.CAMERA',
            'android.permission.USE_BIOMETRIC',
            'android.permission.USE_FINGERPRINT',
            'android.permission.ACCESS_FINE_LOCATION',
            'android.permission.ACCESS_COARSE_LOCATION',
        ],
    ],

    'splash' => [
        'enabled' => true,
        'background_color' => '#ffffff',
        'image' => 'images/splash.png',
        'duration' => 3000,
    ],

    'icons' => [
        'android' => [
            'mdpi' => 'images/icon-48.png',
            'hdpi' => 'images/icon-72.png',
            'xhdpi' => 'images/icon-96.png',
            'xxhdpi' => 'images/icon-144.png',
            'xxxhdpi' => 'images/icon-192.png',
        ],
    ],
];