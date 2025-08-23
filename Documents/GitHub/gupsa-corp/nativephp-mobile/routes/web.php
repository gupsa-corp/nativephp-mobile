<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\WelcomeController;

Route::get('/', [WelcomeController::class, 'index'])->name('welcome');

Route::get('/features', [WelcomeController::class, 'features'])->name('features');
Route::get('/settings', [WelcomeController::class, 'settings'])->name('settings');

// API routes for mobile functionality
Route::prefix('api')->group(function () {
    Route::get('/app-info', [WelcomeController::class, 'appInfo'])->name('api.app-info');
    Route::get('/device-info', [WelcomeController::class, 'deviceInfo'])->name('api.device-info');
});

// Health check for NativePHP
Route::get('/health', function () {
    return response()->json([
        'status' => 'ok',
        'timestamp' => now(),
        'version' => config('app.version', '1.0.0'),
    ]);
})->name('health');