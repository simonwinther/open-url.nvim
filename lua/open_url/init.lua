local M = {}

local function open(url)
	if url:find("^www%.") then
		url = "https://" .. url
	end
	vim.ui.open(url)
end

function M.open_at_line()
	local line = vim.api.nvim_get_current_line()

	-- Fast Path
	if not (line:find("http") or line:find("www%.")) then
		return
	end

	local urls = {}
	-- %S+ matches sequences of non-whitespace characters
	for chunk in line:gmatch("%S+") do
		if chunk:find("^https?://") or chunk:find("^www%.") then
			-- Strip trailing punctuation
			local url = chunk:gsub("[%]%)}%.,;:''\"%s]+$", "")
			table.insert(urls, url)
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
