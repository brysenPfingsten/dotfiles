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
        "layout.css.prefers-color-scheme.content-override" = 0;
      };

      extensions = {
        force = true;
        packages = with addons; [
          firefox-color
          vimium
          better-canvas
          ublock-origin
        ];
      };

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
                name = "Teams";
                url = "https://teams.microsoft.com/v2/";
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
                name = "Tutor Appointments";
                url = "https://shu.campus.eab.com/home/staff#?tab-state=appointments_tab";
              }
              {
                name = "Chess";
                url = "https://chess.com";
              }
              {
                name = "Logic Site";
                url = "https://jasonhemann.github.io/26SP-CS3204/";
              }
              {
                name = "Logic Gradescope";
                url = "https://www.gradescope.com/courses/1220170";
              }
              {
                name = "FSM Docs";
                url = "https://morazanm.github.io/fsm/fsm/index.html";
              }
            ];
          }
        ];
      };
    };
  };
}
