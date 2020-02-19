size={256,110}

function update()

	iPadVis = findCommand("jb/sasl/iPads/toggle")    
	function iPadVis_handler(phase)	-- happens too fast !!!!!!!
		if 1 == phase and (get(runTime) - lastCommandClick ) > 0.5 then
			if get(iPadVisibility) == 0 then 
				set(iPadVisibility, 1)
				set(iPad1_mode, 0)
				lastCommandClick = get(runTime)	 
			else
				set(iPadVisibility, 0)  -- to blank frame and buttons
				set(iPad1_mode, -1) -- to blank all screens
				lastCommandClick = get(runTime)	
			end
		end
	end
	registerCommandHandler(iPadVis, 0, iPadVis_handler)	--  SHIFT i 
	
	HudHide = findCommand("jb/sasl/hud/toggle")    
	function HudHide_handler(phase)	-- happens too fast !!!!!!!
		if 1 == phase and (get(runTime) - lastCommandClick ) > 0.5 then
			if get(HudHidden) == 0 then 
				set(HudHidden, 1) -- the kill dataref
				lastCommandClick = get(runTime)	 
			else
				set(HudHidden, 0)  -- to make iit visible
				lastCommandClick = get(runTime)	
			end
		end
	end
	registerCommandHandler(HudHide, 0, HudHide_handler)  	--  CTRL D
	
	airframeHide = findCommand("jb/sasl/airframe/toggle")     	
	function airframeHide_handler(phase)	-- happens too fast !!!!!!!
		if 1 == phase and (get(runTime) - lastCommandClick ) > 0.5 then
			if get(airframeHidden) == 0 then 
				set(airframeHidden, 1) -- the kill dataref
				lastCommandClick = get(runTime)	 
			else
				set(airframeHidden, 0)  -- to make iit visible
				lastCommandClick = get(runTime)	
			end
		end
	end
	registerCommandHandler(airframeHide, 0, airframeHide_handler) --  CTRL V

	yawToggle = findCommand("jb/sasl/yawDamper/toggle")  
	function yawToggle_handler(phase)	-- happens too fast !!!!!!!
		if 1 == phase and (get(runTime) - lastCommandClick ) > 0.5 then
			if get(jb_yawControl) == 1 then
				set(jb_yawControl, 0) 
			else
				set(jb_yawControl, 1) 
			end
			lastCommandClick = get(runTime)
		end
	end
	registerCommandHandler(yawToggle, 0, yawToggle_handler)	--  CTRL Y 
	
	throttle_governorToggle = findCommand("jb/sasl/throttle_governor/toggle")  
	function throttle_governorToggle_handler(phase)	-- happens too fast !!!!!!!
		if 1 == phase and (get(runTime) - lastCommandClick ) > 0.5 then
			if get(throttle_governor) == 1 then
				set(throttle_governor, 0)
				set(governor_on, 0)
				set(throttle, 0)
				 
			else
				set(throttle_governor, 1) 
				set(governor_on, 1)
				set(throttle, 0.35)
			end
			lastCommandClick = get(runTime)
		end
	end
	registerCommandHandler(throttle_governorToggle, 0, throttle_governorToggle_handler)	--  ??? 
	
	
	
	
		
	
	
end  -- of function update()
