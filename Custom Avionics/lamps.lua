size={192,64}

local lamp_Amber = loadImage('images/lamp_Amber.png')
local lamp_Blue  = loadImage('images/lamp_Blue.png')
local lamp_DH    = loadImage('images/lamp_DH.png')
local lamp_Green = loadImage('images/lamp_Green.png')
local lamp_Red   = loadImage('images/lamp_Red.png')
local lamp_SAS   = loadImage('images/lamp_SAS.png')

function draw() -- lamps
	drawAll(components) 
	if get(batteryON) > 0 then	
		if get(lampTest) == 1 then 
			drawTexture(lamp_Amber,  0, 32,  32, 32) -- HOOK
			drawTexture(lamp_Blue,  32, 32,  32, 32) -- LOAD
			drawTexture(lamp_Red,   64, 32,  32, 32) -- ALARM (on at switch on until Throttle fwd
			drawTexture(lamp_Green, 96, 32,  32, 32) -- START
			drawTexture(lamp_Amber,128, 32,  32, 32) -- INJ (it is a turbine IDLE light on French versions)
			drawTexture(lamp_Red,  160, 32,  32, 32) -- STOP - a warning that the start has failed but also comes on/off during stopping
			
			drawTexture(lamp_SAS,    0,  0,  32, 32)
			drawTexture(lamp_Amber, 32,  0,  32, 32)
			drawTexture(lamp_Green, 64,  0,  32, 32)
			drawTexture(lamp_DH,    96,  0,  32, 32)
			drawTexture(lamp_Red,  160,  0,  32, 32)			
		else
			if get(TqPercent) > 98 then -- > 98%
				drawTexture(lamp_Red,  160, 0,  32, 32)
			end	
			if get(jb_yawControl) == 1 then -- 0=off, 1= ON (INT)
				drawTexture(lamp_SAS,    0,  0,  32, 32)
			end	
			if get(m_agl)/0.3048 < get(radAltDH) then -- 
				drawTexture(lamp_DH,    96,  0,  32, 32)
			end	
			
			if get(NF) < 75 and get(throttle_governor) == 1 then
				drawTexture(lamp_Red,   64, 32,  32, 32) -- ALARM (on at switch on until Throttle fwd
			end
					
			if get(ignition_key) > 0  and get(NF) < 57 and get(throttle_governor) == 1 then
				drawTexture(lamp_Green, 96, 32,  32, 32) -- START to 25000 rpm
			end	
			if get(ignition_key) == 4 and get(NF) < 23 then
				drawTexture(lamp_Amber,128, 32,  32, 32) -- INJ to 10,000 rpm
			end	
			if get(ignition_key) == 0 and get(NF) < 80 and get(NF) > 23 then
				drawTexture(lamp_Red,  160, 32,  32, 32) -- STOP - a warning that the start has failed but also comes on/off during stopping
			end	
			

		end -- of lampTest switch testing
	end -- of if get(batteryON) > 0
end
