return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  event = { "VeryLazy" },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  keys = {
    { "<leader>oi", "<cmd>Octo issue list<cr>", desc = "Octo: List issues" },
    { "<leader>oI", "<cmd>Octo issue create<cr>", desc = "Octo: Create issue" },
    { "<leader>op", "<cmd>Octo pr list<cr>", desc = "Octo: List PRs" },
    { "<leader>oP", "<cmd>Octo pr create<cr>", desc = "Octo: Create PR" },
    { "<leader>or", "<cmd>Octo repo list<cr>", desc = "Octo: List repos" },
    { "<leader>on", "<cmd>Octo notification list<cr>", desc = "Octo: Notifications" },
    { "<leader>od", "<cmd>Octo discussion list<cr>", desc = "Octo: Discussions" },
    { "<leader>oa", "<cmd>Octo actions<cr>", desc = "Octo: Actions" },
    {
      "<leader>os",
      function()
        require("octo.utils").create_base_search_command({
          include_current_repo = true,
        })
      end,
      desc = "Octo: Search current repo",
    },
  },

  opts = {
    -- Picker: "telescope", "fzf-lua", "snacks", or "default"
    picker = "telescope",

    picker_config = {
      use_emojis = false,
      search_static = true,
      mappings = {
        open_in_browser = { lhs = "<C-b>", desc = "Open in browser" },
        copy_url = { lhs = "<C-y>", desc = "Copy URL" },
        copy_sha = { lhs = "<C-e>", desc = "Copy commit SHA" },
        checkout_pr = { lhs = "<C-o>", desc = "Checkout PR" },
        merge_pr = { lhs = "<C-r>", desc = "Merge PR" },
      },
    },

    -- GitHub / gh CLI
    gh_cmd = "gh",
    gh_env = {},
    timeout = 10000,

    -- Remote preference
    default_remote = { "upstream", "origin" },

    -- PR merge behavior
    default_merge_method = "rebase", -- "merge", "rebase", or "squash"
    default_delete_branch = true,

    -- Use this if your SSH remote uses aliases like git@github-work:org/repo.git
    ssh_aliases = {
      -- ["github-work"] = "github.com",
    },

    -- Bare :Octo opens the built-in action picker
    enable_builtin = true,

    -- Reviews
    use_local_fs = false,
    snippet_context_lines = 4,

    reviews = {
      auto_show_threads = true,
      focus = "right",
    },

    pull_requests = {
      order_by = {
        field = "UPDATED_AT",
        direction = "DESC",
      },
      always_select_remote_on_create = false,
      use_branch_name_as_title = true,
    },

    issues = {
      order_by = {
        field = "UPDATED_AT",
        direction = "DESC",
      },
    },

    discussions = {
      order_by = {
        field = "UPDATED_AT",
        direction = "DESC",
      },
    },

    notifications = {
      current_repo_only = false,
    },

    -- GitHub Actions workflow runs
    runs = {
      icons = {
        pending = "○",
        in_progress = "●",
        failed = "✗",
        succeeded = "✓",
        skipped = "⏭",
        cancelled = "⊘",
      },
    },

    -- Projects
    default_to_projects_v2 = false,
    suppress_missing_scope = {
      projects_v2 = false,
    },

    -- UI
    ui = {
      use_signcolumn = false,
      use_statuscolumn = true,
      use_foldtext = true,
    },

    file_panel = {
      size = 12,
      icons = true,
    },

    -- Remote polling for changed issue/PR buffers
    poll = {
      enabled = false,
      interval = 10000,
      notify_on_refresh = true,
      notify_on_change = true,
    },

    -- Completion / search overrides
    search = {
      completion_overrides = {},
    },

    users = "search", -- "search", "mentionable", or "assignable"

    -- Icons
    user_icon = " ",
    ghost_icon = "󰊠 ",
    copilot_icon = " ",
    dependabot_icon = " ",
    comment_icon = "▎",
    outdated_icon = "󰅒 ",
    resolved_icon = " ",
    reaction_viewer_hint_icon = " ",
    timeline_marker = " ",
    timeline_indent = 2,
    use_timeline_icons = true,

    -- Bubble delimiters
    right_bubble_delimiter = "",
    left_bubble_delimiter = "",

    -- Disable all default buffer mappings if true.
    -- Usually leave this false.
    mappings_disable_default = false,

    mappings = {
      issue = {
        issue_options = { lhs = "<CR>", desc = "Issue options" },
        reload = { lhs = "<C-r>", desc = "Reload issue" },
        open_in_browser = { lhs = "<C-b>", desc = "Open in browser" },
        copy_url = { lhs = "<C-y>", desc = "Copy URL" },

        close_issue = { lhs = "<localleader>ic", desc = "Close issue" },
        reopen_issue = { lhs = "<localleader>io", desc = "Reopen issue" },
        list_issues = { lhs = "<localleader>il", desc = "List repo issues" },

        add_assignee = { lhs = "<localleader>aa", desc = "Add assignee" },
        remove_assignee = { lhs = "<localleader>ad", desc = "Remove assignee" },

        create_label = { lhs = "<localleader>lc", desc = "Create label" },
        add_label = { lhs = "<localleader>la", desc = "Add label" },
        remove_label = { lhs = "<localleader>ld", desc = "Remove label" },

        add_comment = { lhs = "<localleader>ca", desc = "Add comment" },
        add_reply = { lhs = "<localleader>cr", desc = "Add reply" },
        delete_comment = { lhs = "<localleader>cd", desc = "Delete comment" },

        next_comment = { lhs = "]c", desc = "Next comment" },
        prev_comment = { lhs = "[c", desc = "Previous comment" },

        react_thumbs_up = { lhs = "<localleader>r+", desc = "Thumbs up" },
        react_thumbs_down = { lhs = "<localleader>r-", desc = "Thumbs down" },
        react_heart = { lhs = "<localleader>rh", desc = "Heart reaction" },
        react_eyes = { lhs = "<localleader>re", desc = "Eyes reaction" },
        react_rocket = { lhs = "<localleader>rr", desc = "Rocket reaction" },
        react_laugh = { lhs = "<localleader>rl", desc = "Laugh reaction" },
        react_confused = { lhs = "<localleader>rc", desc = "Confused reaction" },
        react_hooray = { lhs = "<localleader>rp", desc = "Hooray reaction" },
      },

      pull_request = {
        pr_options = { lhs = "<CR>", desc = "PR options" },
        checkout_pr = { lhs = "<localleader>po", desc = "Checkout PR" },

        merge_pr = { lhs = "<localleader>pm", desc = "Merge PR" },
        squash_and_merge_pr = { lhs = "<localleader>psm", desc = "Squash merge PR" },
        rebase_and_merge_pr = { lhs = "<localleader>prm", desc = "Rebase merge PR" },

        list_commits = { lhs = "<localleader>pc", desc = "List commits" },
        list_changed_files = { lhs = "<localleader>pf", desc = "List changed files" },
        show_pr_diff = { lhs = "<localleader>pd", desc = "Show PR diff" },

        add_reviewer = { lhs = "<localleader>va", desc = "Add reviewer" },
        remove_reviewer = { lhs = "<localleader>vd", desc = "Remove reviewer" },

        approve_pr = { lhs = "<leader>qa", desc = "Approve PR" },
        review_start = { lhs = "<localleader>vs", desc = "Start review" },
        review_resume = { lhs = "<localleader>vr", desc = "Resume review" },

        resolve_thread = { lhs = "<localleader>rt", desc = "Resolve thread" },
        unresolve_thread = { lhs = "<localleader>rT", desc = "Unresolve thread" },

        reload = { lhs = "<C-r>", desc = "Reload PR" },
        open_in_browser = { lhs = "<C-b>", desc = "Open in browser" },
        copy_url = { lhs = "<C-y>", desc = "Copy URL" },
        copy_sha = { lhs = "<C-e>", desc = "Copy commit SHA" },
        goto_file = { lhs = "gf", desc = "Go to file" },

        add_comment = { lhs = "<localleader>ca", desc = "Add comment" },
        add_reply = { lhs = "<localleader>cr", desc = "Add reply" },
        delete_comment = { lhs = "<localleader>cd", desc = "Delete comment" },

        next_comment = { lhs = "]c", desc = "Next comment" },
        prev_comment = { lhs = "[c", desc = "Previous comment" },
      },

      review_diff = {
        submit_review = { lhs = "<localleader>vs", desc = "Submit review" },
        discard_review = { lhs = "<localleader>vd", desc = "Discard review" },
        add_review_comment = {
          lhs = "<localleader>ca",
          desc = "Add review comment",
          mode = { "n", "x" },
        },
        add_review_suggestion = {
          lhs = "<localleader>sa",
          desc = "Add review suggestion",
          mode = { "n", "x" },
        },
        focus_files = { lhs = "<localleader>e", desc = "Focus changed files" },
        toggle_files = { lhs = "<localleader>b", desc = "Toggle changed files" },
        toggle_viewed = { lhs = "<localleader><space>", desc = "Toggle viewed" },
        next_thread = { lhs = "]t", desc = "Next thread" },
        prev_thread = { lhs = "[t", desc = "Previous thread" },
        close_review_tab = { lhs = "<C-c>", desc = "Close review tab" },
        goto_file = { lhs = "gf", desc = "Go to file" },
      },

      file_panel = {
        submit_review = { lhs = "<localleader>vs", desc = "Submit review" },
        discard_review = { lhs = "<localleader>vd", desc = "Discard review" },
        next_entry = { lhs = "j", desc = "Next changed file" },
        prev_entry = { lhs = "k", desc = "Previous changed file" },
        select_entry = { lhs = "<CR>", desc = "Show file diff" },
        refresh_files = { lhs = "R", desc = "Refresh files" },
        focus_files = { lhs = "<localleader>e", desc = "Focus files" },
        toggle_files = { lhs = "<localleader>b", desc = "Toggle files" },
        toggle_viewed = { lhs = "<localleader><space>", desc = "Toggle viewed" },
        close_review_tab = { lhs = "<C-c>", desc = "Close review tab" },
      },

      review_thread = {
        add_comment = { lhs = "<localleader>ca", desc = "Add comment" },
        add_reply = { lhs = "<localleader>cr", desc = "Add reply" },
        add_suggestion = { lhs = "<localleader>sa", desc = "Add suggestion" },
        delete_comment = { lhs = "<localleader>cd", desc = "Delete comment" },
        next_comment = { lhs = "]c", desc = "Next comment" },
        prev_comment = { lhs = "[c", desc = "Previous comment" },
        resolve_thread = { lhs = "<localleader>rt", desc = "Resolve thread" },
        unresolve_thread = { lhs = "<localleader>rT", desc = "Unresolve thread" },
        close_review_tab = { lhs = "<C-c>", desc = "Close review tab" },
      },

      submit_win = {
        approve_review = { lhs = "<C-a>", desc = "Approve review", mode = { "n" } },
        comment_review = { lhs = "<C-m>", desc = "Comment review", mode = { "n" } },
        request_changes = { lhs = "<C-r>", desc = "Request changes", mode = { "n" } },
        close_review_tab = { lhs = "<C-c>", desc = "Close review tab", mode = { "n" } },
      },

      discussion = {
        discussion_options = { lhs = "<CR>", desc = "Discussion options" },
        open_in_browser = { lhs = "<C-b>", desc = "Open in browser" },
        copy_url = { lhs = "<C-y>", desc = "Copy URL" },
        add_comment = { lhs = "<localleader>ca", desc = "Add comment" },
        add_reply = { lhs = "<localleader>cr", desc = "Add reply" },
        delete_comment = { lhs = "<localleader>cd", desc = "Delete comment" },
        next_comment = { lhs = "]c", desc = "Next comment" },
        prev_comment = { lhs = "[c", desc = "Previous comment" },
      },

      runs = {
        expand_step = { lhs = "o", desc = "Expand workflow step" },
        next_step = { lhs = "]s", desc = "Next workflow step" },
        prev_step = { lhs = "[s", desc = "Previous workflow step" },
        next_job = { lhs = "]j", desc = "Next workflow job" },
        prev_job = { lhs = "[j", desc = "Previous workflow job" },
        open_in_browser = { lhs = "<C-b>", desc = "Open in browser" },
        refresh = { lhs = "<C-r>", desc = "Refresh workflow" },
        rerun = { lhs = "<C-o>", desc = "Rerun workflow" },
        rerun_failed = { lhs = "<C-f>", desc = "Rerun failed jobs" },
        cancel = { lhs = "<C-x>", desc = "Cancel workflow" },
        copy_url = { lhs = "<C-y>", desc = "Copy URL" },
      },

      notification = {
        read = { lhs = "<localleader>nr", desc = "Mark notification read" },
        done = { lhs = "<localleader>nd", desc = "Mark notification done" },
        unsubscribe = { lhs = "<localleader>nu", desc = "Unsubscribe" },
      },

      repo = {
        repo_options = { lhs = "<CR>", desc = "Repo options" },
        create_issue = { lhs = "<localleader>ic", desc = "Create issue" },
        create_discussion = { lhs = "<localleader>dc", desc = "Create discussion" },
        contributing_guidelines = { lhs = "<localleader>cg", desc = "View contributing guidelines" },
        open_in_browser = { lhs = "<C-b>", desc = "Open in browser" },
      },

      release = {
        open_in_browser = { lhs = "<C-b>", desc = "Open release in browser" },
      },
    },

    colors = {
      white = "#ffffff",
      grey = "#2A354C",
      black = "#000000",
      red = "#fdb8c0",
      dark_red = "#da3633",
      green = "#acf2bd",
      dark_green = "#238636",
      yellow = "#d3c846",
      dark_yellow = "#735c0f",
      blue = "#58A6FF",
      dark_blue = "#0366d6",
      purple = "#6f42c1",
    },

    debug = {
      notify_missing_timeline_items = false,
    },
  },

  config = function(_, opts)
    require("octo").setup(opts)

    -- Optional: completion for @users and #issues inside Octo buffers.
    -- Octo documents these as insert-mode mappings for the `octo` filetype.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "octo",
      callback = function()
        vim.keymap.set("i", "@", "@<C-x><C-o>", {
          buffer = true,
          silent = true,
          desc = "Octo complete users",
        })

        vim.keymap.set("i", "#", "#<C-x><C-o>", {
          buffer = true,
          silent = true,
          desc = "Octo complete issues/PRs",
        })
      end,
    })
  end,
}
