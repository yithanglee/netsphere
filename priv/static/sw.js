// sw.js (Service Worker file)

// const CACHE_EXPIRATION = 24 * 60 * 60 * 1000;
const CACHE_NAME = 'my-cache';
const CACHE_EXPIRATION = 2 * 60 * 60 * 1000; // 2 min

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      return cache.addAll([
        '/html',
        '/html/blog_nav.html',
        '/html/landing.html',
        '/html/footer_modals.html',
        // Add other files you want to cache
      ]);
    })
  );
});

self.addEventListener('activate', event => {
  event.waitUntil(
    // Delete old caches that may exist
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cache => {
          if (cache !== CACHE_NAME) {
            return caches.delete(cache);
          }
        })
      );
    })
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.open(CACHE_NAME).then(cache => {
      return cache.match(event.request).then(response => {
        const fetchPromise = fetch(event.request).then(networkResponse => {
          cache.put(event.request, networkResponse.clone());
          return networkResponse;
        });

        return response || fetchPromise;
      });
    })
  );
});

// Check and refresh the cache every 24 hours
setInterval(() => {
  caches.open(CACHE_NAME).then(cache => {
    cache.keys().then(keys => {
      keys.forEach(key => {
        // Check if the cache entry is older than 1 day
        if (Date.now() - new Date(key.url) > CACHE_EXPIRATION) {
          cache.delete(key);
        }
      });
    });
  });
}, 24 * 60 * 60 * 1000); // Run every 24 hours
