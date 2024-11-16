#define TYPING_INDICATOR_LIFETIME 3 * 5

/mob
	var/hud_typing = FALSE //set when typing in an input window instead of chatline
	var/typing
	var/last_typed
	var/last_typed_time

	var/static/mutable_appearance/typing_indicator

/mob/proc/set_typing_indicator(state, hudt)
	if(!typing_indicator)
		typing_indicator = mutable_appearance('icons/mob/talk.dmi', "default0", HUD_LAYER, HUD_PLANE-1)
		typing_indicator.alpha = 175

	if(state)
		if(!typing)
			if(hudt)
				hud_typing = TRUE
			add_overlay(typing_indicator)
			typing = TRUE
			update_vision_cone()
		if(hudt)
			hud_typing = TRUE
	else
		if(typing)
			cut_overlay(typing_indicator)
			typing = FALSE
			hud_typing = FALSE
			update_vision_cone()
	return state

/mob/living/key_down(_key, client/user)
	if(stat == CONSCIOUS)
//		var/list/binds = user.prefs?.key_bindings[_key]
//		if(binds)
/*			if("Say" in binds)
				set_typing_indicator(TRUE, TRUE)
			if("Me" in binds)
				set_typing_indicator(TRUE, TRUE)*/
		if(_key == "M")
			set_typing_indicator(TRUE, TRUE)
		if(_key == ",")
			set_typing_indicator(TRUE, TRUE)
	return ..()

/mob/proc/handle_typing_indicator()
	if(!client || stat)
		set_typing_indicator(FALSE)
		return




	var/temp = winget(client, "input", "text")

	var/command = winget(client,"input","command")
	if(command == "" || command + temp == "say \"")
		set_typing_indicator(0)
		return

	last_typed_time = world.time

	if (world.time > last_typed_time + TYPING_INDICATOR_LIFETIME)
		set_typing_indicator(0)
		return
	else if(length(temp) > 0)
		set_typing_indicator(TRUE,"hTy")


