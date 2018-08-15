// firefox config
//%APPDATA%\Mozilla\Firefox\Profiles\XXXXXXXX.your_profile_name\user.js

// search engines
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.search.update", false);

// new tab
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.url", "about:blank");
user_pref("browser.newtabpage.activity-stream.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.directory.ping", "");
user_pref("browser.newtabpage.directory.source", "data:text/plain,{}");
user_pref("browser.urlbar.placeholderName", "DuckDuckGo");

// color
user_pref("reader.color_scheme", "dark");
user_pref("browser.display.foreground_color", "#C0C0C0");
user_pref("browser.display.background_color", "#000000");

// ui
user_pref("lightweightThemes.selectedThemeID", "firefox-compact-dark@mozilla.org");
user_pref("devtools.theme", "dark");
user_pref("browser.uiCustomization.state", '{"placements":{"widget-overflow-fixed-list":["languagetool-webextension_languagetool_org-browser-action","ublock0-button","downloads-button","sync-button","ublock0_raymondhill_net-browser-action","87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action"],"PersonalToolbar":["personal-bookmarks"],"nav-bar":["back-button","forward-button","toggle-button--supportlastpasscom-lastpass-button","stop-reload-button","urlbar-container"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","alltabs-button"]},"seen":["pocket-button","developer-button","webide-button","87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action","ublock0-button","languagetool-webextension_languagetool_org-browser-action","action-button--keybinderfailcl-keybinderoolbarutton","screenshots_mozilla_org-browser-action","jid1-niffy2ca8fy1tg_jetpack-browser-action","ublock0_raymondhill_net-browser-action","toggle-button--supportlastpasscom-lastpass-button"],"dirtyAreaCache":["PersonalToolbar","nav-bar","TabsToolbar","toolbar-menubar","PanelUI-contents","addon-bar","widget-overflow-fixed-list"],"currentVersion":14,"newElementCount":41}');
user_pref("browser.uidensity", 1);
user_pref("browser.download.forbid_open_with", true);
user_pref("browser.download.autohideButton", false);

// disable "recommended by pocket"
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("general.warnOnAboutConfig", false);
