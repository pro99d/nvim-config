return {
  {
    "ahmedkhalf/project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
        patterns = { ".git", "package.json", "Makefile", ".sln", "README.md", ".venv" },
        show_hidden = true,
        silent_chdir = true,
      })
      require("telescope").load_extension("projects")
    end,
    event = "VeryLazy",
  }
}
