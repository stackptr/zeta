{
  pkgs,
  lib,
  hostname,
  ...
}: {
  imports = [
    ./aws.nix
    ./zsh.nix
  ];

  home.packages = let
    nodejs = pkgs.nodejs_20;
    yarn = pkgs.yarn.override {inherit nodejs;};
  in
    with pkgs;
      [
        # Apps
        mosh
        neofetch
        onefetch
        ranger

        # Audio/video
        ffmpeg_6
        mediainfo
        sox

        # Development
        cachix
        colima
        coreutils-full
        docker
        fd
        gitui
        git-interactive-rebase-tool
        hub
        jo
        lazydocker
        nodejs
        shellcheck
        tree
        yarn
        yq

        # Nix
        alejandra
        comma
        manix
        nix-du
        nix-tree
        nix-your-shell
        statix
      ]
      ++ lib.optionals stdenv.isDarwin [
        m-cli
        mas
      ];
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "Sublime Snazzy";
    };
  };

  # TODO: Improve manner of per-host home-manager config
  programs.beets.enable = hostname == "glyph";

  programs.btop.enable = true;

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "✿ corey";
    userEmail = "corey@x64.co";
    signing = {
      key = "F88C08579051AB48";
      signByDefault = true;
    };
    extraConfig = {
      sequence.editor = "interactive-rebase-tool";
      pull.rebase = true;
      push.autosetupremote = true;
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      rerere.enabled = true;
    };
  };

  programs.gpg = {
    enable = true;
  };

  programs.htop.enable = true;

  programs.jq.enable = true;

  programs.lsd = {
    enable = true;
    enableAliases = true;
    settings = {
      icons = {
        # TODO: "fancy" theme requires patched font with icons
        # https://github.com/lsd-rs/lsd#icons-not-showing-up
        theme = "unicode";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.nushell.enable = true;

  programs.ripgrep.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
    extraConfig = ''
      IgnoreUnknown UseKeychain
      UseKeychain yes
    '';
    includes = [
      "~/.colima/ssh_config"
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      git_status = {
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "≡";
      };
      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
    };
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    mouse = true;
    terminal = "tmux-256color";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      tmuxPlugins.yank
    ];
  };

  programs.yt-dlp.enable = true;

  services.gpg-agent = {
    # TODO: nix-community/home-manager#2964
    enable =
      if pkgs.stdenv.isDarwin
      then false
      else true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  home.stateVersion = "23.11";
}
