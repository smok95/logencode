'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/codelist.json": "6c282a672db4b4b3db41b9293efb243c",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/LICENSE": "6a961f9cbbd69c0c9e5adce2a54c1d1e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"favicon.png": "4c71c5a63d566736eb4f29222b25456f",
"icons/Icon-192.png": "9ee8dfb5ff12f77a3d93483b23356c26",
"icons/Icon-512.png": "8b6b27d9a3569911af2504d70b62566b",
"index.html": "1ad9c03ce7ad7cc21c194c03d279f84c",
"/": "1ad9c03ce7ad7cc21c194c03d279f84c",
"main.dart.js": "dce5acf99061813ad44707b15d3f922a",
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
