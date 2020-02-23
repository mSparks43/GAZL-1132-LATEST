size={256,192}

local last_action = '??'

function draw() -- Controls
	drawAll(components) 
	local textForPrinting		= '-'
	local currentPedals 		= 0.1*math.floor(get(pedals) *1000)
	local currentPitch			= 0.1*math.floor(10*get(collectivePitch))
	local currentThrottle		=  math.floor(get(throttle)       *100)  -- convert tp percentage
	local currentPitchCyclic	=  math.floor(get(pitchCyclic) *100)  -- convert tp percentage
	local currentRollCyclic		=  math.floor(get(rollCyclic)    *100)  -- convert tp percentage
	local currentTRPtitch		=  0.1*math.floor(get(TRPtitch)    *10)  -- 1dp
	
	local    xStart = 128
	local    yStart = 90
	local  xWidth = 0
	local yHeight = 0
	
	-- sim/cockpit2/radios/indicators/nav1_flag_glideslope -- 1 = no signal
	--textForPrinting = 'flag_GS  = ' .. get(flag_GS) 
	--drawText(font_Sans10, 80, 135,  textForPrinting , 1,1,1)
	--if get(flag_GS) == 1 then drawText(font_Sans10, 150, 135,  'NO GLIDESLOPE' , 1,0,0) end
	--sim/cockpit2/radios/indicators/nav1_display_horizontal 1 = YES signal (bool)
    --                                                       same for nav1_display_vertical
	--textForPrinting = 'nd_v (GS)  = ' .. get(nd_v) .. ' = ' .. 0.1*(math.floor(10* get(v_nav1_v)))
	--drawText(font_Sans10, 50, 120,  textForPrinting , 1,1,1)
	--textForPrinting = 'nd_h (LOC) = ' .. get(nd_h) .. ' = ' .. 0.1*(math.floor(10* get(v_nav1_h))) -- 
	--drawText(font_Sans10, 50, 105,  textForPrinting , 1,1,1)

	textForPrinting = 'NF: ' .. math.floor(get(NF) ) -- .. ' %' 
	drawText(font_Sans12, 15, 115, textForPrinting , 0.1,1,0)
	
	textForPrinting = 'T_G: ' .. current_Thr_Gov .. ',     IGN: ' ..  current_Starter 
	drawText(font_Sans12, 15, 100, textForPrinting , 0.1,1,0)
	
	drawText(font_Sans12, 15, 85, engine_mode_caption , 0.1,1,0)
	drawText(font_Sans12, 15, 70, last_action , 1,1,0) 

	

	
	drawText(font_Sans10, 5, 180,  'Blades' , 1,1,1)
	textForPrinting = currentPitch ..'deg'
	drawText(font_Sans10, 5, 170, textForPrinting, 1,1,1)		
	drawRectangle(5, 5, 10, ((currentPitch+2)*10), 0.4, 0.1, 0.1, 1)
			
	textForPrinting = 'Roll: '  .. currentRollCyclic ..'%'
	drawText(font_Sans10, 100, 170, textForPrinting, 1,1,1)	
	if currentRollCyclic > 0 then --POS-- STBD GREEN
		xStart = 128
		xWidth = currentRollCyclic	
		if xWidth > 100 then xWidth = 100 end
		drawRectangle(xStart, 180, xWidth, 8, 0.1, 0.4, 0.1, 1)	
	else --NEG-- PORT RED
		xWidth = -currentRollCyclic
		if xWidth > 100 then xWidth = 100 end
		xStart = 128 - xWidth
		drawRectangle(xStart, 180, xWidth, 8, 0.4, 0.1, 0.1, 1)		
	end	
	
	textForPrinting = 'Pitch: '  .. currentPitchCyclic ..'%'
	drawText(font_Sans10, 190, (90+0.85*currentPitchCyclic), textForPrinting, 1,1,1)
		if currentPitchCyclic > 0 then --POS-- UP BLUE
		yStart = 90
		yHeight = currentPitchCyclic	
		drawRectangle(240, yStart, 8, yHeight, 0.2, 0.2, 0.4, 1)	
	else --NEG-- DOWN BROWN
		yHeight = -currentPitchCyclic
		yStart = 90 - yHeight
		drawRectangle(240, yStart, 8, yHeight,  0.3, 0.2, 0.1, 1)		
	end	
	
	textForPrinting = 'Pedals: '  .. currentPedals ..'%   ' .. currentTRPtitch .. 'deg TR pitch'
	drawText(font_Sans10, 100, 15, textForPrinting, 1,1,1)	
	if currentPedals > 0 then --POS-- STBD GREEN
		xStart = 128
		xWidth = currentPedals	
		if xWidth > 100 then xWidth = 100 end
		drawRectangle(xStart, 5, xWidth, 8, 0.1, 0.4, 0.1, 1)	
	else --NEG-- PORT RED
		xWidth = -currentPedals
		if xWidth > 100 then xWidth = 100 end
		xStart = 128 - xWidth
		drawRectangle(xStart, 5, xWidth, 8, 0.4, 0.1, 0.1, 1)		
	end
	
	if get(jb_yawControl) == 1 then
		drawText(font_Sans12, 20, 16,  'INSTRUCTOR', 1,0,0)	 
		drawText(font_Sans12, 20,  5,  'ASSISTED',   1,0,0)	 
	else
		drawText(font_Sans10, 20, 16,  'student',    0, 0.5, 0)	 
		drawText(font_Sans10, 20,  5,  'controlled', 0, 0.5, 0)	 
	end
	
end

function update()
	-- things that can cause a change of state are 
	-- ignition_key  
	-- throttle_governor (yellow handle)
	local T_G = get(throttle_governor)
	local IGN = get(ignition_key)
	if     IGN == 0 then current_Starter = 'off' 
	elseif IGN == 4 then current_Starter = 'ign' 
	else                current_Starter = 'run' end
	if     T_G == 0 then current_Thr_Gov = 'back' 
	else                current_Thr_Gov = 'fwd' end	
	
	if previous_Thr_Gov == current_Thr_Gov  and  previous_Starter == current_Starter  then -- no change
		if current_Starter ~= 'off' and current_Thr_Gov == 'fwd' then --standard run up
			if get(NF) > 69 then -- enable governor at over 30,000 rpm
				--set(throttle_governor, 1) -- it must be at 1 to get here
				set(governor_on, 1) 
				engine_mode_caption = 'FLIGHT'
			else
				set(throttle, 0.35)
				set(governor_on, 0)	
				engine_mode_caption = 'RUN UP'			
			end
		end --of standard run up
		if current_Starter ~= 'off' and current_Thr_Gov == 'back' then --for Autos / GI
			set(throttle, 0.0)
			set(governor_on, 0)	
			engine_mode_caption = 'Autos / GI'		
		end --of for Autos / GI
		if current_Starter == 'off' then --Switch OFF
			set(throttle, 0.0)
			set(governor_on, 0)	
			set(throttle_governor, 0)
			engine_mode_caption = 'OFF'		
		end --of Switch OFF
	else -- something has changed, switch-wise
	last_action = "??"
		if previous_Starter ~= 'ign'  and current_Starter == 'ign'  then 
			last_action = ' IGN pressed' 
			set(throttle_governor, 1)
		end
		if previous_Starter == 'ign'  and current_Starter == 'run'  then last_action = 'IGN released' end
		if previous_Starter ~= 'off'  and current_Starter == 'off'  then last_action = 'STOP pressed' end
		if previous_Thr_Gov == 'back' and current_Thr_Gov == 'fwd'  then last_action = 'T_G FWD'      end
		if previous_Thr_Gov == 'fwd'  and current_Thr_Gov == 'back' then last_action = 'T_G BACK'     end
		previous_Thr_Gov = current_Thr_Gov
		previous_Starter = current_Starter
	end
end  -- of function update()
