local M = {}

local function system_open(url)
	if url:find("^www%.") then
		url = "https://" .. url
	end
	vim.ui.open(url)
end

function M.open_at_line()
	local line = vim.api.nvim_get_current_line()
	if not (line:find("https?://") or line:find("www%.")) then
		return
	end

	local urls = {}
	for chunk in line:gmatch("%S+") do
		if chunk:find("^https?://") or chunk:find("^www%.") then
			table.insert(urls, chunk:gsub("[%]%)}%.,;:''\"%s]+$", ""))
		end
	end

	if #urls == 1 then
		system_open(urls[1])
	elseif #urls > 1 then
		local snacks = _G.Snacks or require("snacks")
		snacks.picker.select(urls, { prompt = "Open URL" }, function(choice)
			if choice then
				system_open(choice)
			end
		end)
	end
end

return M
