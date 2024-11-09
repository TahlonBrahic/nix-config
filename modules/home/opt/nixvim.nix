{inputs, pkgs, ...}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  options = {};
  config = {
    programs.nixvim = {
      enable = true;
      plugins = {
        lsp = {
	enable = pkgs.lib.mkDefault true;
          servers = {
	    bashls.enable = pkgs.lib.mkDefault true;
            dockerls.enable = pkgs.lib.mkDefault true;
	    gopls.enable = pkgs.lib.mkDefault true;
	    jsonls.enable = pkgs.lib.mkDefault true;
	    marksman.enable = pkgs.lib.mkDefault true;
            nil_ls.enable = pkgs.lib.mkDefault true;
            pyright.enable = pkgs.lib.mkDefault true;
            ts_ls.enable = pkgs.lib.mkDefault true;
            lua_ls.enable = pkgs.lib.mkDefault true;
            tailwindcss.enable = pkgs.lib.mkDefault true;
            typst_lsp.enable = pkgs.lib.mkDefault true;
            cssls.enable = pkgs.lib.mkDefault true;
            html.enable = pkgs.lib.mkDefault true;
            htmx.enable = pkgs.lib.mkDefault true;
            solargraph.enable = pkgs.lib.mkDefault true;
            yamlls.enable = pkgs.lib.mkDefault true;
            taplo.enable = pkgs.lib.mkDefault true;
          };
        };
	startup = {
	  enable = true;
	  sections = {
            header = {
              type = "text";
              oldfilesDirectory = false;
              align = "center";
	      foldSection = false;
	      title = "Header";
              margin = 5;
              content = [ "新しい冬のヴィム" ];
	      highlight = "Statement";
	      defaultColor = "";
	      oldfilesAmount = 0;
	      };

	      body = {
		type = "mapping";
		oldfilesDirectory = false;
		align = "center";
		foldSection = false;
		title = "Menu";
		margin = 5;
		content = [
		  [
		    " Find File"
		    "Telescope find_files"
		    "ff"
		  ]
		  [
		    "󰍉 Find Word"
		    "Telescope live_grep"
		    "fr"
		  ]
		  [
		    " Recent Files"
		    "Telescope oldfiles"
		    "fg"
		  ]
		  [
		    " File Browser"
		    "Telescope file_browser"
		    "fe"
		  ]
		];
		highlight = "string";
		defaultColor = "";
		oldfilesAmount = 0;
	      };
	    };

	    options = {
	      paddings = [1 3];
	    };

            parts = [
              "header"
              "body"
            ];
	  };
	lsp-format = {
          enable = true;
	};
	illuminate = {
	  enable = true;
	  largeFileCutoff = 100000;
	};
	# TODO: Add WSL option for image.backend
	image = {
	  enable = true;
	  backend = "kitty";
	};
	indent-blankline.enable = true;
        toggleterm = {
          enable = true;
          settings = {
            size = 20;
          };
        };
	treesitter = {
    enable = true;
    settings = {
      indent.enable = true;
      highlight.enable = true;
    };
    folding = false;
    nixvimInjections = true;
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };

  treesitter-textobjects = {
    enable = false;
    select = {
      enable = true;
      lookahead = true;
      keymaps = {
        "aa" = "@parameter.outer";
        "ia" = "@parameter.inner";
        "af" = "@function.outer";
        "if" = "@function.inner";
        "ac" = "@class.outer";
        "ic" = "@class.inner";
        "ii" = "@conditional.inner";
        "ai" = "@conditional.outer";
        "il" = "@loop.inner";
        "al" = "@loop.outer";
        "at" = "@comment.outer";
      };
    };
    move = {
      enable = true;
      gotoNextStart = {
        "]m" = "@function.outer";
        "]]" = "@class.outer";
      };
      gotoNextEnd = {
        "]M" = "@function.outer";
        "][" = "@class.outer";
      };
      gotoPreviousStart = {
        "[m" = "@function.outer";
        "[[" = "@class.outer";
      };
      gotoPreviousEnd = {
        "[M" = "@function.outer";
        "[]" = "@class.outer";
      };
    };
    swap = {
      enable = true;
      swapNext = {
        "<leader>a" = "@parameters.inner";
      };
      swapPrevious = {
        "<leader>A" = "@parameter.outer";
      };
    };
  };
	which-key.enable = true;
      };

      keymaps = [
    {
      mode = "n";
      key = "<leader>t";
      action = "<cmd>ToggleTerm<cr>";
      options = {
        desc = "Toggle Terminal Window";
      };
    }
    {
      mode = "n";
      key = "<leader>tv";
      action = "<cmd>ToggleTerm direction=vertical<cr>";
      options = {
        desc = "Toggle Vertical Terminal Window";
      };
    }
    {
      mode = "n";
      key = "<leader>th";
      action = "<cmd>ToggleTerm direction=horizontal<cr>";
      options = {
        desc = "Toggle Horizontal Terminal Window";
      };
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>ToggleTerm direction=float<cr>";
      options = {
        desc = "Toggle Floating Terminal Window";
      };
    }
  ];
    };
  };
}
