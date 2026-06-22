{pkgs, ...}: let
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
              # {
              #   name = "Canvas";
              #   url = "https://setonhall.instructure.com";
              # }
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
              # {
              #   name = "Timesheet";
              #   url = "https://bannerapps.shu.edu/EmployeeSelfService/ssb/timeEntry#/teApp/timesheet/dashboard/payperiod";
              # }
              # {
              #   name = "Tutor Appointments";
              #   url = "https://shu.campus.eab.com/home/staff#?tab-state=appointments_tab";
              # }
              {
                name = "Chess";
                url = "https://chess.com";
              }
              {
                name = "OPLSS Schedule";
                url = "https://www.cs.uoregon.edu/research/summerschool/summer26/schedule.php";
              }
              {
                name = "OPLSS Slack";
                url = "https://app.slack.com/client/T0B93KKLY2J/C0B95MSKEBC";
              }
            ];
          }
        ];
      };
    };
  };
}
