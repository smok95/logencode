'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "0d266ffbe90dae02458487c9d33b7373",
"assets/codelist.json": "6c282a672db4b4b3db41b9293efb243c",
"assets/FontManifest.json": "f7161631e25fbd47f3180eae84053a51",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/LICENSE": "53eab6a95665c73a2149410f56629ecb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/flutter_markdown/assets/logo.png": "67642a0b80f3d50277c44cde8f450e50",
"favicon.png": "4c71c5a63d566736eb4f29222b25456f",
"icons/Icon-192.png": "9ee8dfb5ff12f77a3d93483b23356c26",
"icons/Icon-512.png": "8b6b27d9a3569911af2504d70b62566b",
"index.html": "d3800cea0e04407259ec8c823c86d85c",
"/": "d3800cea0e04407259ec8c823c86d85c",
"main.dart.js": "cff49996ecd1e16914870128fad8df1c",
"manifest.json": "67c8754ba4e62f235afe2eef69a1de51"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
