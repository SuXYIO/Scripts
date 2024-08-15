-- Get weather
function getw()
	local api_url = "http://api.openweathermap.org/data/2.5/weather?"
	local api_key = 'your API key'
	local lat = 'your lat'
	local lon = 'your lon'

	local command = string.format("curl -s '%s&lat=%s&lon=%s&APPID=%s'", api_url, lat, lon, api_key)
	local handle = io.popen(command)
	local output = handle:read("*a")
	handle:close()

	local json = require("dkjson")
	local data = json.decode(output)
	local temp = data.main.temp
	local conditions = data.weather[1].main
	local fmtres = string.format("%s󰔄 󰤃 %s", temp - 273.15, conditions)
	return fmtres
end
