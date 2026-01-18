local M = {}

-- Cache locals for speed
local find = string.find
local gmatch = string.gmatch
local sub = string.sub
local gsub = string.gsub

local function open_sys(url)
  if url:find("^www%.") then
    url = "https://" .. url
  end
  vim.ui.open(url)
end

-- Extractor
local function extract_urls(text_list, dedupe)
  local urls = {}
  local seen = dedupe and {} or nil
  local count = 0

  for i = 1, #text_list do
    local line = text_list[i]

    -- Skip line immediately if no markers
    if not (find(line, "http") or find(line, "www%.")) then
      goto continue
    end

    for chunk in gmatch(line, "%S+") do
      local start_idx = find(chunk, "https?://") or find(chunk, "www%.")
      
      -- Skip chunk if no URL start found
      if not start_idx then
        goto next_chunk
      end

      local url = gsub(sub(chunk, start_idx), "[%]%)}%.,;:''\"%s]+$", "")
      
      -- Handle deduplication
      if seen and seen[url] then
        goto next_chunk
      end

      count = count + 1
      urls[count] = url
      if seen then seen[url] = true end

      ::next_chunk::
    end
    ::continue::
  end
  return urls
end

function M.open_at_line()
  local line = vim.api.nvim_get_current_line()
  local urls = extract_urls({ line }, false)

  -- No URLs
  if #urls == 0 then
    vim.notify("No URLs found on line", vim.log.levels.INFO, { title = "open-url" })
    return
  end

  -- Exactly 1 URL
  if #urls == 1 then
    open_sys(urls[1])
    return
  end

  -- Multiple URLs
  local snacks = _G.Snacks or require("snacks")
  snacks.picker.select(urls, { prompt = "Open URL" }, function(choice)
    if choice then open_sys(choice) end
  end)
end

function M.open_buffer()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local urls = extract_urls(lines, true)

  -- No URLs in buffer
  if #urls == 0 then
    vim.notify("No URLs found in buffer", vim.log.levels.INFO, { title = "open-url" })
    return
  end

  local snacks = _G.Snacks or require("snacks")
  snacks.picker.select(urls, { prompt = "Buffer URLs" }, function(choice)
    if choice then open_sys(choice) end
  end)
end

return M
