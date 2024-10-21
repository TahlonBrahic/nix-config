{
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        userChrome = ''
                  #navigator-toolbox{--uc-autohide-toolbar-delay: 100ms; /* The toolbar is hidden after 0.1s */}
          :root{
             --general-border-radius: 8px !important;
             --auto-general-color: var(--lwt-accent-color) !important;
          }
          #navigator-toolbox{
            --uc-bm-padding: 4px; /* Vertical padding to be applied to bookmarks */
            --uc-bm-height: calc(20px + 2 * var(--uc-bm-padding)); /* Might need to adjust if the toolbar has other buttons */
            --uc-navbar-height: -40px; /* navbar is main toolbar. Use negative value */
            --uc-autohide-toolbar-delay: 600ms; /* The toolbar is hidden after 0.6s */
          }
          :root[uidensity="compact"] #navigator-toolbox{
            --uc-navbar-height: -34px;
          }
          :root[uidensity="touch"] #navigator-toolbox{ --uc-bm-padding: 6px }
          :root[sessionrestored] #nav-bar,
          :root[sessionrestored] #PersonalToolbar{
            background-image: linear-gradient(var(--toolbar-bgcolor),var(--toolbar-bgcolor)), var(--lwt-additional-images,var(--toolbar-bgimage))  !important;
            background-position: top,var(--lwt-background-alignment);
            background-position-y: calc(0px - var(--tab-min-height) - 2*var(--tab-block-margin,0px));
            background-repeat: repeat,var(--lwt-background-tiling);
            transform: rotateX(90deg);
            transform-origin: top;
            transition: transform 135ms linear var(--uc-autohide-toolbar-delay) !important;
            z-index: 2;
          }
          :root[sessionrestored] #PersonalToolbar{
            z-index: 1;
            background-position-y: calc(0px - var(--tab-min-height) - 2*var(--tab-block-margin,0px) + var( --uc-navbar-height));
          }
          :root[lwtheme-image] #nav-bar,
          :root[lwtheme-image] #PersonalToolbar{
            background-image: linear-gradient(var(--toolbar-bgcolor),var(--toolbar-bgcolor)),var(--lwt-header-image), var(--lwt-additional-images,var(--toolbar-bgimage)) !important;
          }
          #nav-bar[customizing],#PersonalToolbar[customizing]{ transform: none !important }
          #navigator-toolbox > #PersonalToolbar{
            transform-origin: 0px var(--uc-navbar-height);
            position: relative;
          }
          :root[sessionrestored]:not([customizing]) #navigator-toolbox{
            margin-bottom:  calc(-1px - var(--uc-bm-height) + var(--uc-navbar-height));
          }
          /* Make sure the bookmarks toolbar is never collapsed even if it is disabled */
          :root[sizemode="fullscreen"] #PersonalToolbar,
          #PersonalToolbar[collapsed="true"]{
            min-height: initial !important;
            max-height: initial !important;
            visibility: hidden !important
          }
          #PersonalToolbar[collapsed="true"] #PlacesToolbarItems > *,
          :root[sizemode="fullscreen"] #PersonalToolbar #PlacesToolbarItems > *{
            visibility: hidden !important;
          }
          /* The invisible toolbox will overlap sidebar so we'll work around that here */
          #navigator-toolbox{ pointer-events: none; border-bottom: none !important; }
          #PersonalToolbar{ border-bottom: 1px solid var(--chrome-content-separator-color) }
          #navigator-toolbox > *{ pointer-events: auto }
          #sidebar-box{ position: relative }
          /* Selected tab needs higher z-index now to "hide" the broder below it */
          .tabbrowser-tab[selected]{ z-index: 3 !important; }
          /* SELECT TOOLBAR BEHAVIOR */
          /* Comment out or delete one of these to disable that behavior */
          #nav-bar:focus-within + #PersonalToolbar,
          #navigator-toolbox > #nav-bar:focus-within{
            transition-delay: 100ms !important;
            transform: rotateX(0);
          }
          #navigator-toolbox:hover > .browser-toolbar{
            transition-delay: 100ms !important;
            transform: rotateX(0);
          }
          #navigator-toolbox > div{ display: contents }
          :where(#titlebar,#tab-notification-deck,.global-notificationbox){
            -moz-box-ordinal-group: 0;
          }
          :root[BookmarksToolbarOverlapsBrowser] #navigator-toolbox-background{
            margin-bottom: 0 !important;
            z-index: auto !important;
          }
          /* Show when cursor is over popups/context-menus - cannot control which ones */
          /*
          #mainPopupSet:hover ~ box > toolbox > .browser-toolbar{
            transition-delay: 100ms !important;
            transform: rotateX(0);
          }
          */
          /* Uncomment the next part to enable compatibility for multi-row_bookmarks.css
           * This would break buttons placed in the toolbar,
           * but that is likely not happening if you are using multi-row setup
           */

          /*
          #navigator-toolbox{ margin-bottom: var(--uc-navbar-height) !important; }
          #PersonalToolbar:not([customizing]){
            min-height: 0 !important;
            margin-bottom: 0;
            height: 0;
            overflow-y: visible !important;
            z-index: 2;
            padding-inline: 0 !important;
          }
          #personal-bookmarks{
            background: inherit;
            height: min-content;
          }
          #PlacesToolbarDropIndicatorHolder{
            pointer-events: none !important;
          }
          */
          #alltabs-button{
              display: none;
          }
          #main-window{
              /* background-color: color-mix(in srgb, var(--lwt-accent-color) 60%, transparent)  !important; */
              /* background-color: color-mix(in srgb, var(--auto-accent-color) 90%, transparent)  !important; */
              background-color: transparent !important;
              appearance: -moz-win-borderless-glass !important;
              appearance: -moz-win-glass !important;
          }
          #tabbrowser-tabpanels {
            background-color: transparent;
          }
          #navigator-toolbox {
            background-color: transparent !important;
          }
          #navigator-toolbox-background {
            background-color: transparent !important;
            appearance: -moz-win-borderless-glass !important;
          }
          #appcontent, #browser, #tabbrowser-tabbox, #tabbrowser-tabpanels, .browserSidebarContainer {
            background-color: transparent !important;
          }
          .titlebar-button{ --uc-caption-background: var(--uc-caption-color) }
          .titlebar-button { opacity: 0.6; --uc-caption-color: rgb(252,185,15) }
          .titlebar-min    { opacity: 0.5; --uc-caption-color: rgb(36, 209, 49) }
          .titlebar-close  { opacity: 0.7; --uc-caption-color: rgb(250, 55, 55) }
          .titlebar-button:hover { opacity: 1 }
          .titlebar-button {
            background: transparent !important;
            padding-inline: 10px !important;
            transition: opacity 0.2s ease;
          }
          .titlebar-close {	padding-right: 18px !important; }

          .titlebar-button > .toolbarbutton-icon {
          	list-style-image: none;
          	border-radius: 10px;
            background: var(--uc-caption-background,currentColor) !important;
          }
          /*  --------------------------------------- Rounded corner in pages --------------------------------------- */
          .browserStack>browser{
              margin: 0px 4px 4px 4px !important;
              border-radius: 8px !important;
              /* outline: 2px solid color-mix(in srgb, var(--auto-general-color) 50%, transparent) !important; */
              /* outline: 1px solid red !important; */
          }
           findbar{
              border-radius: 8px !important;
              z-index: 2;
              margin: 0 4px 4px !important;
          }
          #tabbrowser-tabpanels {
              background-color: transparent !important;
          }
          #sidebar-box {
              margin-left:  4px !important;
              margin-bottom: 4px !important;
              border-radius: var(--general-border-radius) !important;
              border-color: transparent;
              background-color: var(--auto-general-color) !important;
          }
          #browser {
              --sidebar-border-color: transparent !important;
          }

          .browserContainer, .browserStack, .browserSidebarContainer, #browser, #appcontent{
              background-color: var(--auto-accent-color) !important;
              /* for debug only */
              /* margin: 50px !important;   */
              /* border-radius: 8px !important; */
          }
          #navigator-toolbox, #navigator-toolbox-background{
              border-color: var(--auto-accent-color) !important;
              background-color: var(--auto-accent-color) !important;
          }
          #TabsToolbar {
              margin: 4px 4px 0px 4px !important;
              border-radius: var(--general-border-radius) !important;
              background-color: var(--auto-general-color) !important;
              /* background-color: transparent !important;*/  /* this will make tabs toolbar transparent coment above line too*/
          }
          /* Nav-bar */
          .browser-toolbar:not(.titlebar-color) {
              margin: 4px 4px 0px 4px !important;
              border-radius: var(--general-border-radius) !important;
              background-color: var(--auto-general-color) !important;
              box-shadow: 4px;
          }
          #urlbar:not([focused]) #urlbar-input, /* ID for Firefox 70 */
          #urlbar:not([focused]) .urlbar-input{ text-align: center !important; }
          #urlbar:is([focused]) .urlbar-input{ text-align: center !important; }
          .tab-background:is([selected], [multiselected]) {
              /* color: var(--lwt-tab-text, var(--toolbar-color))!important; */
              background-color: var(--auto-accent-color)!important;
          }
          @media (prefers-color-scheme: dark){ :root{
              --auto-accent-color: color-mix(in srgb, var(--auto-general-color) 86%, white);
          }}
           @media (prefers-color-scheme: light){ :root{
              --auto-accent-color: color-mix(in srgb, var(--auto-general-color) 86%, black);
          }}
          :root{
              /* tab selected */
              --tab-selected-bgcolor: var(--auto-accent-color) !important;
              --lwt-selected-tab-background-color: var(--auto-accent-color) !important;
              /* urlbar field */
              --toolbar-field-background-color: var(--auto-accent-color) !important;
              --toolbar-field-focus-background-color: var(--auto-accent-color) !important;
              /* Urlbar text */
              --toolbar-field-color: var(--lwt-text-color) !important;
              --toolbar-field-focus-color: var(--lwt-text-color) !important;
          }
          /* tab selected border */
          #tabbrowser-tabs{ --lwt-tab-line-color: var(--auto-accent-color) !important; }
        '';
        #extensions = {
        #
        #};
        containers = {
          #force = true;
        };
        search = {
          force = true;
          order = [
            "DuckDuckGo"
            "Google"
          ];
        };
      };

      work = {
        id = 1;
        #extensions = {
        #
        #};
        containers = {
          #force = true;
        };
        search = {
          force = true;
          order = [
            "Google"
            "DuckDuckGo"
          ];
        };
      };
    };

    policies = {
      NoDefaultBookmarks = true;
      OverrideFirstRunPage = true;
      OverridePostUpdatePage = true;
    };
  };
}
