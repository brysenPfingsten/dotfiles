{
  pkgs,
  config,
  ...
}: let
  addons = pkgs.nur.repos.rycee.firefox-addons;
in {
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles."default" = {
      isDefault = true;

      settings = {
        "browser.startup.homepage" = "https://google.com";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "browser.newtabpage.activity-stream.feeds.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
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
                name = "OneDrive";
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
                name = "Tutor Checks";
                url = "https://studentshu-my.sharepoint.com/:x:/r/personal/fieldsda_shu_edu/_layouts/15/Doc.aspx?sourcedoc=%7BDD55CAE7-6B53-4C1A-8DEB-71897A033DEC%7D&file=TutoringChecksFall26.xlsx&fromShare=true&action=default&mobileredirect=true";
              }
              {
                name = "Chess";
                url = "https://chess.com";
              }
              {
                name = "Duolingo";
                url = "https://www.duolingo.com/learn";
              }
            ];
          }
        ];
      };
    };
  };
}
