{
  config,
  pkgs,
  lib,
  ...
}: let
  addons = pkgs.nur.repos.rycee.firefox-addons;
in {
  programs.firefox = {
    enable = true;

    profiles."default" = {
      isDefault = true;

      settings = {
        "browser.startup.homepage" = "https://google.com";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      extensions = with addons; [
        vimium
        better-canvas
        ublock-origin
        pywalfox
      ];

      bookmarks = {
        force = true;
        settings = [
          {
            name = "Toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "GitHub";
                url = "https://github.com";
              }
              {
                name = "Canvas";
                url = "https://setonhall.instructure.com";
              }
              {
                name = "Onedrive";
                url = "https://studentshu-my.sharepoint.com";
              }
              {
                name = "Outlook";
                url = "https://outlook.office.com/mail";
              }
              {
                name = "PirateNet";
                url = "https://shu.okta.com/app/UserHome";
              }
              {
                name = "Timesheet";
                url = "https://bannerapps.shu.edu/EmployeeSelfService/ssb/timeEntry#/teApp/timesheet/dashboard/payperiod";
              }
              {
                name = "Chess";
                url = "https://chess.com";
              }
            ];
          }
        ];
      };
    };
  };

  home.packages = with pkgs; [
    # NOTE: Make sure to run `pywalfox install` on fresh builds
    pywalfox-native
  ];
}
