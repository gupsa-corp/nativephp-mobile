// Mobile App JavaScript
class MobileApp {
    constructor() {
        this.splashDuration = 3000; // 3 seconds
        this.init();
    }

    init() {
        // Initialize app when DOM is loaded
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.onReady());
        } else {
            this.onReady();
        }
    }

    onReady() {
        console.log('Gupsa Mobile App initialized');
        this.setupSplashScreen();
        this.setupTouchHandlers();
        this.setupServiceWorker();
        this.preventZoom();
    }

    setupSplashScreen() {
        const splashScreen = document.getElementById('splash-screen');
        const mainScreen = document.getElementById('main-screen');

        if (splashScreen && mainScreen) {
            // Hide splash screen after duration
            setTimeout(() => {
                splashScreen.style.opacity = '0';
                splashScreen.style.transform = 'scale(0.9)';
                
                setTimeout(() => {
                    splashScreen.style.display = 'none';
                    mainScreen.style.display = 'flex';
                    mainScreen.style.opacity = '0';
                    
                    // Fade in main screen
                    setTimeout(() => {
                        mainScreen.style.transition = 'opacity 0.5s ease';
                        mainScreen.style.opacity = '1';
                    }, 50);
                }, 300);
            }, this.splashDuration);
        }
    }

    setupTouchHandlers() {
        // Add touch feedback for buttons
        document.querySelectorAll('.btn, .feature-card').forEach(element => {
            element.addEventListener('touchstart', this.handleTouchStart, { passive: true });
            element.addEventListener('touchend', this.handleTouchEnd, { passive: true });
            element.addEventListener('touchcancel', this.handleTouchEnd, { passive: true });
        });
    }

    handleTouchStart(e) {
        e.currentTarget.style.transform = 'scale(0.98)';
        e.currentTarget.style.opacity = '0.8';
    }

    handleTouchEnd(e) {
        e.currentTarget.style.transform = '';
        e.currentTarget.style.opacity = '';
    }

    setupServiceWorker() {
        // Register service worker for PWA capabilities
        if ('serviceWorker' in navigator) {
            navigator.serviceWorker.register('/sw.js')
                .then(registration => {
                    console.log('ServiceWorker registered:', registration);
                })
                .catch(error => {
                    console.log('ServiceWorker registration failed:', error);
                });
        }
    }

    preventZoom() {
        // Prevent double-tap zoom on iOS
        let lastTouchEnd = 0;
        document.addEventListener('touchend', (e) => {
            const now = (new Date()).getTime();
            if (now - lastTouchEnd <= 300) {
                e.preventDefault();
            }
            lastTouchEnd = now;
        }, false);

        // Prevent pinch zoom
        document.addEventListener('gesturestart', (e) => {
            e.preventDefault();
        });

        document.addEventListener('gesturechange', (e) => {
            e.preventDefault();
        });

        document.addEventListener('gestureend', (e) => {
            e.preventDefault();
        });
    }

    // Public methods for button interactions
    showFeatures() {
        const featuresGrid = document.querySelector('.features-grid');
        if (featuresGrid) {
            featuresGrid.scrollIntoView({ 
                behavior: 'smooth',
                block: 'start'
            });
        }
    }

    showSettings() {
        // This would typically navigate to a settings screen
        // For now, just show an alert
        this.showAlert('설정', '설정 화면은 곧 추가될 예정입니다.');
    }

    showAlert(title, message) {
        // Create custom modal alert for better mobile UX
        const modal = document.createElement('div');
        modal.className = 'modal-overlay';
        modal.innerHTML = `
            <div class="modal-content">
                <div class="modal-header">
                    <h3>${title}</h3>
                </div>
                <div class="modal-body">
                    <p>${message}</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" onclick="this.closest('.modal-overlay').remove()">
                        확인
                    </button>
                </div>
            </div>
        `;

        // Add modal styles
        if (!document.querySelector('#modal-styles')) {
            const modalStyles = document.createElement('style');
            modalStyles.id = 'modal-styles';
            modalStyles.textContent = `
                .modal-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: rgba(0, 0, 0, 0.5);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    z-index: 10000;
                    animation: fadeIn 0.3s ease;
                }
                
                .modal-content {
                    background: white;
                    border-radius: 16px;
                    margin: 1rem;
                    max-width: 400px;
                    width: 100%;
                    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
                    animation: slideUp 0.3s ease;
                }
                
                .modal-header {
                    padding: 1.5rem 1.5rem 1rem;
                    border-bottom: 1px solid #e2e8f0;
                }
                
                .modal-header h3 {
                    margin: 0;
                    font-size: 1.2rem;
                    color: #1a202c;
                }
                
                .modal-body {
                    padding: 1rem 1.5rem;
                }
                
                .modal-body p {
                    margin: 0;
                    color: #4a5568;
                    line-height: 1.5;
                }
                
                .modal-footer {
                    padding: 1rem 1.5rem 1.5rem;
                    text-align: right;
                }
                
                @media (prefers-color-scheme: dark) {
                    .modal-content {
                        background: #2d3748;
                    }
                    
                    .modal-header {
                        border-color: #4a5568;
                    }
                    
                    .modal-header h3 {
                        color: #e2e8f0;
                    }
                    
                    .modal-body p {
                        color: #cbd5e0;
                    }
                }
            `;
            document.head.appendChild(modalStyles);
        }

        document.body.appendChild(modal);

        // Remove modal when clicking outside
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.remove();
            }
        });
    }

    // Utility methods
    vibrate(pattern = 50) {
        if ('vibrate' in navigator) {
            navigator.vibrate(pattern);
        }
    }

    // NativePHP specific methods (these would be available in actual NativePHP environment)
    checkNativeFeatures() {
        const features = {
            camera: this.hasCamera(),
            biometric: this.hasBiometric(),
            location: this.hasLocation(),
            notifications: this.hasNotifications()
        };

        console.log('Available native features:', features);
        return features;
    }

    hasCamera() {
        return 'mediaDevices' in navigator && 'getUserMedia' in navigator.mediaDevices;
    }

    hasBiometric() {
        // This would be available through NativePHP native methods
        return 'credentials' in navigator;
    }

    hasLocation() {
        return 'geolocation' in navigator;
    }

    hasNotifications() {
        return 'Notification' in window;
    }
}

// Global functions for onclick handlers
function showFeatures() {
    window.mobileApp.showFeatures();
}

function showSettings() {
    window.mobileApp.showSettings();
}

// Initialize app
window.mobileApp = new MobileApp();

// Add some debug info for development
console.log('User Agent:', navigator.userAgent);
console.log('Screen:', screen.width + 'x' + screen.height);
console.log('Viewport:', window.innerWidth + 'x' + window.innerHeight);