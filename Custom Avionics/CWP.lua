size={256,256}

local      captions = loadImage('images/CWP_captions_RED.png')

local caption_PITOT = loadImage('images/caption_PITOT.png')
local caption_ENGP  = loadImage('images/caption_ENGP.png')
local caption_MGBP  = loadImage('images/caption_MGBP.png')
local caption_MGBT  = loadImage('images/caption_MGBT.png')
local caption_GEN   = loadImage('images/caption_GEN.png')
local caption_ALTNR = loadImage('images/caption_ALTNR.png')
local caption_BAT   = loadImage('images/caption_BAT.png')
local caption_AP    = loadImage('images/caption_AP.png')
local caption_NAV   = loadImage('images/caption_NAV.png')
local caption_FUEL  = loadImage('images/caption_FUEL.png')
local caption_HYD   = loadImage('images/caption_HYD.png')
local caption_OIL   = loadImage('images/caption_OIL.png')
local caption_FFILT = loadImage('images/caption_FFILT.png')

function draw() -- Central Warning Panel
	drawAll(components) 
	if get(batteryON) > 0 then	
		if get(cwpTest) == 1 then 
			--drawTexture(captions, 0, 0, 256, 256)
			--drawTexturePart(captions,   97, 211,  64, 32, 97, 211, 64, 32)
			
			drawTexture(caption_PITOT,  96, 212,  64, 32, 97, 211, 64, 32)
			
			drawTexture(caption_ENGP,   24, 173,  64, 32, 97, 211, 64, 32)
			drawTexture(caption_MGBP,   96, 173,  64, 32, 97, 211, 64, 32)
			drawTexture(caption_MGBT,  168, 173,  64, 32, 97, 211, 64, 32)
			
			drawTexture(caption_GEN,    24, 134,  64, 32, 97, 211, 64, 32)
			drawTexture(caption_ALTNR,  96, 134,  64, 32, 97, 211, 64, 32)
			drawTexture(caption_BAT,   168, 134,  64, 32, 97, 211, 64, 32)

			drawTexture(caption_AP,     24, 95,  64, 32, 97, 211, 64, 32)
			drawTexture(caption_NAV,    96, 95,  64, 32, 97, 211, 64, 32)
			drawTexture(caption_FUEL,  168, 95,  64, 32, 97, 211, 64, 32)
			
			drawTexture(caption_HYD,    24, 56,  64, 32, 97, 211, 64, 32)
			drawTexture(caption_OIL,    96, 56,  64, 32, 97, 211, 64, 32)
			drawTexture(caption_FFILT, 168, 56,  64, 32, 97, 211, 64, 32)

			drawText(font_Sans10,  4, 35, 'TEST' ,1.0, 0.1, 1)
			
		else
		
			local EOP = get(engOilPressure)/14.5
			if EOP < 1.7 then
				drawTexture(caption_ENGP,   24, 173,  64, 32, 97, 211, 64, 32)-- < 1.7 bar
			end	
			if get(NF) < 57 then
				drawTexture(caption_GEN,    24, 134,  64, 32, 97, 211, 64, 32) 	-- Only normally on at start/shutdown 25,000
			end	
			--drawTexture(caption_PITOT,  96, 212,  64, 32, 97, 211, 64, 32) -- not yet avl

			if get(NF) < 69 then
				drawTexture(caption_ALTNR,  96, 134,  64, 32, 97, 211, 64, 32) -- 30,000
			end 
			if get(NR) < 280 then
				drawTexture(caption_MGBP,   96, 173,  64, 32, 97, 211, 64, 32) -- Pressure less than 1 bar 
			end
			--	drawTexture(caption_MGBT,  168, 173,  64, 32, 97, 211, 64, 32) -- not yet avl
			--drawTexture(caption_BAT,   168, 134,  64, 32, 97, 211, 64, 32) -- FAIL or GPU attached ??
			if get(NF) < 74 then
				drawTexture(caption_NAV,    96, 95,  64, 32, 97, 211, 64, 32) -- 32,000
			end 
			if get(fuelKg) < 40 then
				drawTexture(caption_FUEL,  168, 95,  64, 32, 97, 211, 64, 32) --  < 40 kg 
			end


		end -- of cwpTest switch testing
	end -- of if get(batteryON) > 0
end
