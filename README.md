# open-url.nvim ⚡

A fast and minimalistic URL opener for your Neovim setup. It uses `snacks.picker` when multiple links are present.

I did find another plugin called *url-open*, but it had autocmds and a bunch of extra highlighting and features I didn’t necessarily need. That’s what inspired me to create this. I just wanted a truly minimalistic way to open a URL when I’m on a line with either multiple URLs or a single one, without a bunch of fancy stuff.

## Demonstration

![demo video](./assets/demo.gif)

## 📦 Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return {
  "simonwinther/open-url.nvim",
  dependencies = { "folke/snacks.nvim" },
  keys = {
    { 
      "<leader>oul", 
      function() require("open_url").open_at_line() end, 
      desc = "Open URL (Line)" 
    },
    { 
      "<leader>oub", 
      function() require("open_url").open_buffer() end, 
      desc = "Open URL (Buffer)" 
    },
  },
}
```
