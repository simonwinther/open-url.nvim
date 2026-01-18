local M = {}

local function open(url)
	if url:find("^www%.") then
		url = "https://" .. url
	end
	vim.ui.open(url)
end

function M.open_at_line()
	local line = vim.api.nvim_get_current_line()

	-- Fast Path: Literal check remains the fastest way to bail.
	if not (line:find("https?://") or line:find("www%.")) then
		return
	end

	local urls = {}
	for chunk in line:gmatch("%S+") do
		local start_idx = chunk:find("https?://") or chunk:find("www%.")
		if start_idx then
			local potential_url = chunk:sub(start_idx)
			local clean_url = potential_url:gsub("[%]%)}%.,;:''\"%s]+$", "")
			table.insert(urls, clean_url)
		end
	end

	local count = #urls
	if count == 1 then
		open(urls[1])
	elseif count > 1 then
		local snacks = _G.Snacks or require("snacks")
		snacks.picker.select(urls, { prompt = "Open URL" }, function(choice)
			if choice then
				open(choice)
			end
		end)
	end
end

return M
