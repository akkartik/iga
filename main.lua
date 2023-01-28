local iga = require "iga"
local ow, oh

love.load = function(args)
	love.window.setMode(800,600)
	ow, oh = 100,100
	math.randomseed(os.time())
	init(args[1])
end

init = function(arg)
	local imgdata = love.image.newImageData(arg)
	iga:geninit(imgdata, ow,oh, imgdata:getWidth(), imgdata:getHeight(), 3)
end

love.draw = function()
	love.graphics.scale(8,8)

	for i=1, 20 do
		iga:genstep()
	end
	
	for x=0, ow-1 do
		for y=0,oh-1 do
			local k = iga:getColours()[x+y*ow]
			if k and k > 0 then
				local c = string.format("%09d",tostring(k))
				local r,g,b = string.sub(c,1, 3), string.sub(c,4, 6), string.sub(c,7, 9)
				love.graphics.setColor(tonumber(r)/255,tonumber(g)/255,tonumber(b)/255)
				love.graphics.rectangle("fill",x,y,1,1)
			end
		end
	end
end

function love.filedropped(dropped_file)
	local filename = dropped_file:getFilename()
	init(filename:sub(#filename-17))
end
