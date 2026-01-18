# open-url.nvim ⚡

A fast and minimalistic URL opener for your Neovim setup. It uses snacks.picker for multiple links. 

## Demonstration

![demo video](./assets/output.mp4)

## 📦 Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "simonwinther/open-url.nvim",
  keys = {
    { "<leader>O", function() require("open_url").open_at_line() end, desc = "Open URL" },
  },
}
