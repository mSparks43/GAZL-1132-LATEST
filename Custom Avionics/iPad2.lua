size={256,192}

function draw() -- spare / dev
	drawAll(components) 

	drawText(font_Sans12, 15, 5, 'Development' , 0,1,0)

	textForPrinting = 'NF: ' .. math.floor(get(NF) ) .. ' %' 
	drawText(font_Sans12, 15, 115, textForPrinting , 0.1,1,0)
	
	textForPrinting = 'NR: ' .. math.floor(get(NR)*100/380) .. ' %' 
	drawText(font_Sans12, 15, 100, textForPrinting , 0.1,1,0)
	
	textForPrinting = 'ignition_key: ' .. get(ignition_key)
	drawText(font_Sans12, 15, 85, textForPrinting , 0.1,1,0)
	-- 0 = off, 1 = left, 2 = right, 3 = both, 4 = starting ( 3 == run position
	
	--sim/cockpit2/engine/actuators/clutch_engage[0]
	

	--
	--textForPrinting = 'radAltDH: ' .. get(radAltDH) .. ' ' ..get(m_agl)/0.3048 
	--drawText(font_Sans12, 15, 85, textForPrinting , 0.1,1,0)
	
	--textForPrinting = 'iPadVisibility: ' .. get(iPadVisibility)
	--drawText(font_Sans12, 15, 70, textForPrinting , 0.1,1,0)
	
	--textForPrinting = 'HudHidden: ' .. get(HudHidden)
	--drawText(font_Sans12, 15, 55, textForPrinting , 0.1,1,0)	
	
	--textForPrinting = 'airframeHidden: ' .. get(airframeHidden)
	--drawText(font_Sans12, 15, 40, textForPrinting , 0.1,1,0)
	
	--textForPrinting = 'jb_yawControl: ' .. get(jb_yawControl)
	--drawText(font_Sans12, 15, 25, textForPrinting , 1,0,0)	
				
end
