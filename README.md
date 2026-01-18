# open-url.nvim ⚡

A fast and minimalistic URL opener for your Neovim setup. It uses `snacks.picker` when multiple links are present.

I did find another plugin called *url-open*, but it had autocmds and a bunch of extra highlighting and features I didn’t necessarily need. That’s what inspired me to create this. I just wanted a truly minimalistic way to open a URL when I’m on a line with either multiple URLs or a single one, without a bunch of fancy stuff.

## 📺 Demonstration

| Open URL (Line) | Open URL (Buffer) |
| :--- | :--- |
| ![demo-line](./assets/demo-line.gif) | ![demo-buffer](./assets/demo-buffer.gif) |
| **Command:** `open_at_line()` | **Command:** `open_buffer()` |
| Opens the URL on your current line. Triggers the picker only if multiple links are found. | Scans the entire buffer and lists all discovered URLs in `snacks.picker`. |

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
