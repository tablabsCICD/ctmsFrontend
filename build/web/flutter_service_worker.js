'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "d94d2ab71b21821d664b4509ed8448f3",
"assets/AssetManifest.bin.json": "7e98c332faf04c1a5da3a550eae76474",
"assets/assets/add.svg": "f2637df026a3318fce2a3e1c009c0fa4",
"assets/assets/alert.png": "5aa78b73ecb35e0a3dcbd090163308dd",
"assets/assets/back_arrow.svg": "d8016a0bc43f51258d27484e4394ebd7",
"assets/assets/back_button.svg": "01761fd762c7aecb7b4029625591673d",
"assets/assets/call.svg": "470b550e3752131ebedcfea1a7395ca1",
"assets/assets/canceled.svg": "5ec892ab345d917b39bdacecacfd1b17",
"assets/assets/employess.png": "837a943609728f1c23e4284bc54de6ea",
"assets/assets/home_ol.png": "1fd72a0b4ab396a013402e6f5a5bccd6",
"assets/assets/images/add.svg": "7e338521f99d235e1f6b481a21d85817",
"assets/assets/images/additional_label.svg": "b226eb6310fbd05db70dfca4ac6ce98b",
"assets/assets/images/add_circle.svg": "f2637df026a3318fce2a3e1c009c0fa4",
"assets/assets/images/add_image.svg": "c04f78c7e4c9ac5f20416cbd1522ac7a",
"assets/assets/images/arrow_back.svg": "3d125932ed33b509c7ae552f2e2f866a",
"assets/assets/images/arrow_right.svg": "9f0ae117bb3a2153aeffacfdf4b3261e",
"assets/assets/images/back_arrow.svg": "12ddcfaa16c59d14294c75cf1b728cd0",
"assets/assets/images/bg.svg": "180c363dd1807551cd30d007c43bd091",
"assets/assets/images/bid.svg": "41334f76e4f0a590eaa890d78780f6a8",
"assets/assets/images/bilty.svg": "dc71cfa336beefbbc8241a533def63a6",
"assets/assets/images/bottomContainer.svg": "256faadb9b4fc6354c55753efb22d1cc",
"assets/assets/images/call.svg": "470b550e3752131ebedcfea1a7395ca1",
"assets/assets/images/call_white.svg": "2c15e99a341e0d06afd1aa2679861c32",
"assets/assets/images/close_circle.svg": "a764101af9e82fc355572f4df969fa49",
"assets/assets/images/crm.svg": "912e0cb7ea145190afd165465cfe0fdb",
"assets/assets/images/delete.svg": "ba71943e1420ea365ea741f68a6e5b0e",
"assets/assets/images/directory.svg": "3cead76d67934a032c36f986b29e8496",
"assets/assets/images/dwon_arrow.svg": "d697313100ae8e4281920687ce3f084a",
"assets/assets/images/edit.svg": "2cdc854222a7eeac7143a42505dfd626",
"assets/assets/images/edit_profile.svg": "606652a636172b98dbcb0157ca64858b",
"assets/assets/images/emp_tot.svg": "7b5de314b75d0658eedaac5c2fe48b3e",
"assets/assets/images/fb_logo.svg": "63ffdc3bdb765fb0872c096c69b1ac08",
"assets/assets/images/filter.svg": "fbb9c1034594b883bc8a4f10fc13c0dd",
"assets/assets/images/filter_icon.svg": "748a1c3196ab4c708d6263736599143c",
"assets/assets/images/from_arrow.svg": "39ee7ec5daafb900fc41928cdd0d6d58",
"assets/assets/images/general_post.svg": "835dfd5a3879a5f9a498774f66ba150a",
"assets/assets/images/gmail.svg": "0b4150044ab5dc35fd825e8710a7eeb8",
"assets/assets/images/gmail_logo.svg": "6c1a3892c19492c7d6f6a017f847c4bf",
"assets/assets/images/green_tick.svg": "6871e781e400483e9f64808aa9f501b3",
"assets/assets/images/home.svg": "6271819b30f0987d3ce68e19e0bb66d8",
"assets/assets/images/hrm.svg": "87afad79924c6cc3dcf3e3ee0751357d",
"assets/assets/images/img1.svg": "c929c5da5d109fb6c3c0b4acc7727991",
"assets/assets/images/img2.svg": "769ba9a9c700ef6a5303f821eb6c7197",
"assets/assets/images/img3.svg": "7573339244a8912f8bea8ef6907c492a",
"assets/assets/images/into_progress_two.svg": "c3306cda173405efaadce96ca5a87296",
"assets/assets/images/introone.svg": "125c8281ff2ce7f68af36f7f4eb4b72f",
"assets/assets/images/introw_two.svg": "ce300677de96a54b02b15ceabc938c93",
"assets/assets/images/intro_progress_one.svg": "982725988495bab50a2d55e4c6ff4961",
"assets/assets/images/intro_progress_three.svg": "5bf32d94b5466f5bdbbd8d7237e64597",
"assets/assets/images/intro_screen_three.svg": "1e1428f8987dcda8b3bac20dddff3e6f",
"assets/assets/images/invoice.svg": "e75748eb90ef226fda981452a7c46e6e",
"assets/assets/images/kyc_one.svg": "d38c76a9f593a018ef13ff21fb0df98d",
"assets/assets/images/like.svg": "8dcacd346e3e9c1ac790b2443cf7586b",
"assets/assets/images/load_post.svg": "c38dd7813b17adb55548200900343ee7",
"assets/assets/images/location.svg": "ac72fe0ce92ed3ec9ce99986546bc161",
"assets/assets/images/lock.svg": "b1c15bb587f9d50c238cdce87667d9b8",
"assets/assets/images/logo.svg": "9fb844e14b8b7aa8b260595cfd525478",
"assets/assets/images/logo_black.svg": "090aac043b5071e7bd28e8b39061b30f",
"assets/assets/images/mail%2520(2).svg": "0508f844c694b31407194ce0284e04f4",
"assets/assets/images/mail.svg": "96db3ef9d91568f1c021ce37c0f91818",
"assets/assets/images/mail_black.svg": "c21e99c9e3ba86923e33acba80065c7d",
"assets/assets/images/message.svg": "111506d9c6cb344d659369ccd60d5661",
"assets/assets/images/message_job.svg": "640e3caf90634993e2f42ae78e76136b",
"assets/assets/images/monitoring.svg": "77f25e3ad3cf842fd92ee7874f07581c",
"assets/assets/images/more.svg": "bce294c7e78319e1f9584818e81fbc73",
"assets/assets/images/my_profile.png": "6809bac4c444d4ab37eb1054cf396dab",
"assets/assets/images/notification.svg": "acba8b02c19212ece467647bce2ca3e8",
"assets/assets/images/password.svg": "c61c05a595b8a631bf1a31a95332fe3c",
"assets/assets/images/pearls.svg": "b14ee63d8ab74479b0ad0b2bc54e7238",
"assets/assets/images/pearls_black.svg": "cc0fcb25144867de2714dc2b4e42ae3e",
"assets/assets/images/pearls_blue.svg": "4b234d70129dd72522d0453b3d3357c0",
"assets/assets/images/pearls_red.svg": "80c482de636c73729e35412d8757ea40",
"assets/assets/images/post_menu.svg": "0f345f8e34d29421e9c1adba1e183b14",
"assets/assets/images/profilepicture.svg": "3d4307c8ea6955fdab6ab77e65e3b78c",
"assets/assets/images/profile_pic.svg": "4522536e46448fe2535cf958ead32884",
"assets/assets/images/red_arrow.svg": "63ebfdb25662c6605ca44e696d438951",
"assets/assets/images/red_next_button.svg": "7f59b5bec50820e04c6a6d32d5371a1c",
"assets/assets/images/return_route.svg": "04b674ffba2ac1dd4c6fb9c2daf6aa5c",
"assets/assets/images/route_return_home.svg": "36693884f62d58d2514ec973483da960",
"assets/assets/images/save_job.svg": "3a5ed45911ce825ab24263b2ca9c4097",
"assets/assets/images/search_normal.svg": "f292af1233d0d654014ad529ee0379ba",
"assets/assets/images/share_icon.svg": "9b36c09f63d17ebb649860b5924f1b40",
"assets/assets/images/share_white.svg": "6dc5567d4d06cf10eb07f1beb2c402cb",
"assets/assets/images/vehicle_load.svg": "5f6d1163a6ea113239822a1186fae009",
"assets/assets/images/verified.svg": "f534d9b005c88b5f20f37d82115d9314",
"assets/assets/images/world.svg": "d9cf4ee8e794f4ff82c48aaf0fac7c29",
"assets/assets/lead_status.svg": "916dafb6ee11f6b063ec55117c24ebe9",
"assets/assets/logo.png": "328ead1761d457666e13fc95eb1b4ec8",
"assets/assets/logo.svg": "cd2adf1d4cd21177855c56908659e05c",
"assets/assets/mail.png": "406f2ffcfb5478556df1eae81601e0c5",
"assets/assets/mail.svg": "c21e99c9e3ba86923e33acba80065c7d",
"assets/assets/mail_logo_color.svg": "0508f844c694b31407194ce0284e04f4",
"assets/assets/menu/customer_menu.svg": "98d5a9852dd9c5e84fc9a6557384d06e",
"assets/assets/menu/dashboard_menu.svg": "22a076f5c843358bc67821f45d3e13a6",
"assets/assets/menu/emp_menu.svg": "d4a47f889569523de229dc9e8a0c5ad3",
"assets/assets/menu/lead.svg": "771a4f16a89ef3446998dfbc605ec542",
"assets/assets/menu/lead_menu.svg": "8f912d5ba7f8c38a3522c50a7a8068cd",
"assets/assets/menu/logout_menu.svg": "121226d29d5dd3facb55ac1a0b5912f1",
"assets/assets/menu/meeting_menu.svg": "75a1d81af30b7ea97804cf9720b9322e",
"assets/assets/menu/profile_menu.svg": "3bd4930312ea0c709c6891a245bc9a81",
"assets/assets/menu/report_menu.svg": "fdb004f6a30ff28d35881064191b6c6b",
"assets/assets/menu_calendar.png": "23acc0c8ff1da1a07370fe4b87f6d475",
"assets/assets/menu_home.png": "ab32dc0c5e2c6111a8a52bf7adf9655d",
"assets/assets/menu_onboarding.png": "8d2b6073510603e21ed844aabdfd2c78",
"assets/assets/menu_recruitment.png": "61d1794424b32d4d267e08a61b20a85a",
"assets/assets/menu_report.png": "4879ce54c5babb60472e28f4ba36496c",
"assets/assets/menu_settings.png": "35c279ef9c74ceccda6a819f54a32969",
"assets/assets/more.png": "48872501243cd173e89b04d1693ae5f2",
"assets/assets/more_icon.svg": "c45f04ecd17f01d9f66b44d8af7602b1",
"assets/assets/notification.svg": "acba8b02c19212ece467647bce2ca3e8",
"assets/assets/notification_image.png": "0d291870bd273d45bfc2811cddf7c107",
"assets/assets/org/all_load.svg": "3c87e3e0121ed1a4349efab2d4421ff8",
"assets/assets/org/all_users.svg": "c6a1959b06b66c82d6b4b0e5706b8a3f",
"assets/assets/org/bid.svg": "9973fa5d5d4f66f58d770bf66b079068",
"assets/assets/org/buy_sell.svg": "09b5c120031095a8a8db835550c83183",
"assets/assets/org/cargo_truck.png": "7d18fa4c6fcf8ddfc28633a8f79aeb2a",
"assets/assets/org/cargo_truck.svg": "ab4c5c836e15803e267f435a0320e799",
"assets/assets/org/container.png": "d2762b203b59e74983f23abf7c2e9b79",
"assets/assets/org/delete.svg": "84db73c9c0697a5103cc93923adcf21a",
"assets/assets/org/discussion.svg": "8413230a013febd58a3a84f602724df1",
"assets/assets/org/full_load.svg": "176a3e1ae46f7ff223bb9cff11420f4c",
"assets/assets/org/logo_iveco.png": "775b2b36edc48f39d772661c21bb2993",
"assets/assets/org/part_load.svg": "00cf4eb6f9af64bf975c888ea913169c",
"assets/assets/org/sheild.svg": "639ad47e9b428a87ede9a9e5ce76ba10",
"assets/assets/org/total_users.svg": "d5bb6d6dd134eb74e9b70404d26a02c6",
"assets/assets/phone.png": "0ae2f66e3ecf9b2e87b2a9aeb1a86422",
"assets/assets/react.svg": "c4f6ee4a2867a62e10f71ffd3a55b25d",
"assets/assets/re_schedule.svg": "e4bbbab8b57d022ab6e615518c871977",
"assets/assets/schedule.svg": "4215abbadcb7610b026fdc98f55a7b45",
"assets/assets/search.png": "cacefd7d9d9dae0977ff022243433e8d",
"assets/assets/send.png": "1df0d1a089c1bee052ae276e864ccc06",
"assets/assets/sheild.svg": "639ad47e9b428a87ede9a9e5ce76ba10",
"assets/assets/sidebar_image.png": "254a7b607b593f00b011883a1e8ea4ff",
"assets/assets/time.svg": "47fe76f14a238d8de5ea543ca5f8f0d4",
"assets/assets/upload_profile.svg": "ca955eee86654942ef014bd6ef794f50",
"assets/assets/user1.jpg": "eb029339e3ec9e799f1f2afa2fd5c592",
"assets/assets/user2.jpg": "3c16c4098ebf1d7777746084610047a8",
"assets/assets/user3.jpg": "e50e46d165528a7f0bb518c899babedd",
"assets/assets/user4.jpg": "298202557bc740b9f360fcd5aa8a11d5",
"assets/FontManifest.json": "c75f7af11fb9919e042ad2ee704db319",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/NOTICES": "5510dfc0caf833f0189ca72ab281f527",
"assets/packages/csc_picker/lib/assets/country.json": "11b8187fd184a2d648d6b5be8c5e9908",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-arrow.png": "8efbd753127a917b4dc02bf856d32a47",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-attachment.png": "9c8f255d58a0a4b634009e19d4f182fa",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-delivered.png": "b6b5d85c3270a5cad19b74651d78c507",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-document.png": "e61ec1c2da405db33bff22f774fb8307",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-error.png": "5a59dc97f28a33691ff92d0a128c2b7f",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-seen.png": "10c256cc3c194125f8fffa25de5d6b8a",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-send.png": "2a7d5341fd021e6b75842f6dadb623dd",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-arrow.png": "3ea423a6ae14f8f6cf1e4c39618d3e4b",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-attachment.png": "fcf6bfd600820e85f90a846af94783f4",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-delivered.png": "28f141c87a74838fc20082e9dea44436",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-document.png": "4578cb3d3f316ef952cd2cf52f003df2",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-error.png": "872d7d57b8fff12c1a416867d6c1bc02",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-seen.png": "684348b596f7960e59e95cff5475b2f8",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-send.png": "8e7e62d5bc4a0e37e3f953fb8af23d97",
"assets/packages/flutter_chat_ui/assets/icon-arrow.png": "678ebcc99d8f105210139b30755944d6",
"assets/packages/flutter_chat_ui/assets/icon-attachment.png": "17fc0472816ace725b2411c7e1450cdd",
"assets/packages/flutter_chat_ui/assets/icon-delivered.png": "b064b7cf3e436d196193258848eae910",
"assets/packages/flutter_chat_ui/assets/icon-document.png": "b4477562d9152716c062b6018805d10b",
"assets/packages/flutter_chat_ui/assets/icon-error.png": "4fceef32b6b0fd8782c5298ee463ea56",
"assets/packages/flutter_chat_ui/assets/icon-seen.png": "b9d597e29ff2802fd7e74c5086dfb106",
"assets/packages/flutter_chat_ui/assets/icon-send.png": "34e43bc8840ecb609e14d622569cda6a",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "706b13a761d261d759c0a8d557ccfdcb",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "46be639d952abe98effde36da35e7701",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "48b92e8451309fdcb73d294f0f6e9830",
"assets/packages/getwidget/icons/dribble.png": "1e36936e4411f32b0e28fd8335495647",
"assets/packages/getwidget/icons/facebook.png": "293dc099a89c74ae34a028b1ecd2c1f0",
"assets/packages/getwidget/icons/google.png": "596c5544c21e9d6cb02b0768f60f589a",
"assets/packages/getwidget/icons/line.png": "da8d1b531d8189396d68dfcd8cb37a79",
"assets/packages/getwidget/icons/linkedin.png": "822742104a63a720313f6a14d3134f61",
"assets/packages/getwidget/icons/pinterest.png": "d52ccb1e2a8277e4c37b27b234c9f931",
"assets/packages/getwidget/icons/slack.png": "19155b848beeb39c1ffcf743608e2fde",
"assets/packages/getwidget/icons/twitter.png": "caee56343a870ebd76a090642d838139",
"assets/packages/getwidget/icons/wechat.png": "ba10e8b2421bde565e50dfabc202feb7",
"assets/packages/getwidget/icons/whatsapp.png": "30632e569686a4b84cc68169fb9ce2e1",
"assets/packages/getwidget/icons/youtube.png": "1bfda73ab724ad40eb8601f1e7dbc1b9",
"assets/packages/progress_dialog_null_safe/assets/double_ring_loading_io.gif": "a03b96c4f7bef9fd9ed90eb516267a11",
"assets/packages/wakelock_web/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "047246d7855e899fd20fcf917bf45893",
"icons/apple-touch-icon.png": "48f8c14ce9ab8820e603b9502358e066",
"icons/Icon-192.png": "dea59582fb6607cd6ffe3149398b3ca7",
"icons/Icon-512.png": "27b57e67933cf0aaf581afabd2e9d1ee",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "a167c888999255b5ebbbea95cbc8c70b",
"/": "a167c888999255b5ebbbea95cbc8c70b",
"logo.png": "dea59582fb6607cd6ffe3149398b3ca7",
"main.dart.js": "de581638a9d04e7eef16a45348ef712b",
"manifest.json": "93f865b05ae964ce0fbf2cfe7a033c07",
"version.json": "67050bca543c1699ef6caef8f710fa0c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
