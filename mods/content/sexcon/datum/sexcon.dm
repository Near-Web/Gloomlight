/datum/sex_controller
	/// The user and the owner of the controller
	VAR_PRIVATE/mob/living/human/user
	/// Target of our actions, can be ourself
	VAR_PRIVATE/mob/living/human/target
	/// Whether the user desires to stop his current action
	var/desire_stop = FALSE
	/// What is the current performed action
	var/decl/sex_action/current_action
	/// Enum of desired speed
	var/speed = SEX_SPEED_MID
	/// Enum of desired force
	var/force = SEX_FORCE_MID
	/// Our arousal
	var/arousal = 0
	/// Our charge gauge
	var/charge = SEX_MAX_CHARGE
	/// Whether we want to screw until finished, or non stop
	var/do_until_finished = TRUE
	/// Arousal won't change if active.
	var/arousal_frozen = FALSE
	var/last_arousal_increase_time = 0
	var/last_ejaculation_time = 0
	var/last_moan = 0
	var/last_pain = 0
	var/sex_loop_timer

/datum/sex_controller/New(mob/living/human/owner)
	user = owner

/datum/sex_controller/Destroy()
	user = null
	target = null
	. = ..()

/datum/sex_controller/proc/set_target(mob/living/human/new_target)
	target = new_target

/datum/sex_controller/proc/is_spent()
	if(charge < CHARGE_FOR_CLIMAX)
		return TRUE
	return FALSE

/datum/sex_controller/proc/finished_check()
	if(!do_until_finished)
		return FALSE
	if(!just_ejaculated())
		return FALSE
	return TRUE

/datum/sex_controller/proc/adjust_speed(amt)
	speed = clamp(speed + amt, SEX_SPEED_MIN, SEX_SPEED_MAX)

/datum/sex_controller/proc/adjust_force(amt)
	force = clamp(force + amt, SEX_FORCE_MIN, SEX_FORCE_MAX)

/datum/sex_controller/proc/update_pink_screen()
	var/severity = clamp(ceil(arousal / 10), 0, 10)

	SIGN(severity) ? user.overlay_fullscreen("horny", /obj/screen/fullscreen/love, severity) : user.clear_fullscreen("horny")

/datum/sex_controller/proc/start(mob/living/human/new_target)
	if(!ishuman(new_target))
		return
	set_target(new_target)
	show_ui()

/datum/sex_controller/proc/cum_onto()
	log_attack("[key_name(user)] came onto [key_name(target)]")
	playsound(target, 'mods/content/sexcon/sounds/mat/endout.ogg', 50, TRUE, ignore_walls = FALSE)
	//add_cum_floor(get_turf(target))
	after_ejaculation()

/datum/sex_controller/proc/cum_into(oral = FALSE)
	log_attack("[key_name(user)] came inside [key_name(target)]")
	if(oral)
		playsound(target, pick(list('mods/content/sexcon/sounds/mat/mouthend (1).ogg','mods/content/sexcon/sounds/mat/mouthend (2).ogg')), 100, FALSE, ignore_walls = FALSE)
	else
		playsound(target, 'mods/content/sexcon/sounds/mat/endin.ogg', 50, TRUE, ignore_walls = FALSE)
	after_ejaculation()

/datum/sex_controller/proc/ejaculate()
	log_attack("[key_name(user)] ejaculated")
	//user.visible_message(SPAN_PINK("[user] makes a mess!"))
	playsound(user, 'mods/content/sexcon/sounds/mat/endout.ogg', 50, TRUE, ignore_walls = FALSE)
	//add_cum_floor(get_turf(user))
	after_ejaculation()

/datum/sex_controller/proc/after_ejaculation()
	set_arousal(40)
	adjust_charge(-CHARGE_FOR_CLIMAX)
	//if(user.has_flaw(/datum/charflaw/addiction/lovefiend))
	//	user.sate_addiction()
	/// TODO: add this stressor
	//user.add_stressor(/datum/stressor/cumok, 10 MINUTES)
	playsound(user, pick(global.sex_moan_heavy), 100, TRUE)
	user.playsound_local(user, 'mods/content/sexcon/sounds/mat/end.ogg', 100)
	last_ejaculation_time = world.time

/datum/sex_controller/proc/just_ejaculated()
	return (last_ejaculation_time + 2 SECONDS >= world.time)

/datum/sex_controller/proc/set_charge(amount)
	var/empty = (charge < CHARGE_FOR_CLIMAX)
	charge = clamp(amount, 0, SEX_MAX_CHARGE)
	var/after_empty = (charge < CHARGE_FOR_CLIMAX)
	if(empty && !after_empty)
		to_chat(user, SPAN_NOTICE("I feel like I'm not so spent anymore"))
	if(!empty && after_empty)
		to_chat(user, SPAN_NOTICE("I'm spent!"))

/datum/sex_controller/proc/adjust_charge(amount)
	set_charge(charge + amount)

/datum/sex_controller/proc/handle_charge(dt)
	//if(user.has_flaw(/datum/charflaw/addiction/lovefiend))
	//	dt *= 2
	adjust_charge(dt * CHARGE_RECHARGE_RATE)
	if(is_spent())
		if(arousal > 60)
			to_chat(user, SPAN_WARNING("I'm too spent!"))
			adjust_arousal(-20)
		adjust_arousal(-dt * SPENT_AROUSAL_RATE)

/datum/sex_controller/proc/set_arousal(amount)
	if(amount > arousal)
		last_arousal_increase_time = world.time
	arousal = clamp(amount, 0, MAX_AROUSAL)
	update_pink_screen()
	update_blueballs()
	//update_erect_state()

/*
/datum/sex_controller/proc/update_erect_state()
	var/obj/item/organ/penis/penis = user.get_organ(BP_PENIS)
	if(penis)
		penis.update_erect_state()
*/

/datum/sex_controller/proc/adjust_arousal(amount)
	set_arousal(arousal + amount)

/datum/sex_controller/proc/perform_deepthroat_oxyloss(mob/living/human/action_target, oxyloss_amt)
	var/oxyloss_multiplier = 0
	switch(force)
		if(SEX_FORCE_LOW)
			oxyloss_multiplier = 0
		if(SEX_FORCE_MID)
			oxyloss_multiplier = 0
		if(SEX_FORCE_HIGH)
			oxyloss_multiplier = 1.0
		if(SEX_FORCE_EXTREME)
			oxyloss_multiplier = 2.0

	oxyloss_amt *= oxyloss_multiplier
	if(oxyloss_amt <= 0)
		return

	action_target.take_damage(oxyloss_amt, OXY)

/datum/sex_controller/proc/perform_sex_action(mob/living/human/action_target, arousal_amt, pain_amt, giving)
	action_target.sexcon.receive_sex_action(arousal_amt, pain_amt, giving, force, speed)

/datum/sex_controller/proc/receive_sex_action(arousal_amt, pain_amt, giving, applied_force, applied_speed)
	arousal_amt *= get_force_pleasure_multiplier(applied_force, giving)
	pain_amt *= get_force_pain_multiplier(applied_force)
	pain_amt *= get_speed_pain_multiplier(applied_speed)

	if(user.stat == DEAD)
		arousal_amt = 0
		pain_amt = 0

	if(!arousal_frozen)
		adjust_arousal(arousal_amt)

	damage_from_pain(pain_amt)
	try_do_moan(arousal_amt, pain_amt, applied_force, giving)
	try_do_pain_effect(pain_amt, giving)

/datum/sex_controller/proc/damage_from_pain(pain_amt)
	if(pain_amt < PAIN_MINIMUM_FOR_DAMAGE)
		return
	var/damage = (pain_amt / PAIN_DAMAGE_DIVISOR)
	user.apply_damage(damage, PAIN, BP_CHEST)

/datum/sex_controller/proc/try_do_moan(arousal_amt, pain_amt, applied_force, giving)
	if(arousal_amt < 1.5)
		return
	if(user.stat != CONSCIOUS)
		return
	if(last_moan + MOAN_COOLDOWN >= world.time)
		return
	if(prob(50))
		return
	var/chosen_emote
	switch(arousal_amt)
		if(0 to 5)
			chosen_emote = pick(global.sex_moan_light)
		if(5 to INFINITY)
			chosen_emote = pick(global.sex_moan_heavy)
	/*
	if(pain_amt >= PAIN_MILD_EFFECT)
		if(giving)
			if(prob(30))
				chosen_emote = "groan"
		else
			if(prob(40))
				chosen_emote = "painmoan"
	if(pain_amt >= PAIN_MED_EFFECT)
		if(giving)
			if(prob(50))
				chosen_emote = "groan"
		else
			if(prob(60))
				chosen_emote = "painmoan"
	*/
	last_moan = world.time
	playsound(user, chosen_emote, 100, TRUE)

/datum/sex_controller/proc/try_do_pain_effect(pain_amt, giving)
	if(pain_amt < PAIN_MILD_EFFECT)
		return
	if(last_pain + PAIN_COOLDOWN >= world.time)
		return
	if(prob(50))
		return
	last_pain = world.time
	if(pain_amt >= PAIN_HIGH_EFFECT)
		var/pain_msg = pick(list("IT HURTS!!!", "IT NEEDS TO STOP!!!", "I CAN'T TAKE IT ANYMORE!!!"))
		user.custom_pain(pain_msg, pain_amt, TRUE, nohalloss = TRUE)
		if(prob(70) && user.stat == CONSCIOUS)
			user.visible_message(SPAN_WARNING("[user] shudders in pain!"))
	else if(pain_amt >= PAIN_MED_EFFECT)
		var/pain_msg = pick(list("It hurts!", "It pains me!"))
		user.custom_pain(pain_msg, pain_amt, TRUE, nohalloss = TRUE)
		if(prob(40) && user.stat == CONSCIOUS)
			user.visible_message(SPAN_WARNING("[user] shudders in pain!"))
	else
		var/pain_msg = pick(list("It hurts a little...", "It stings...", "I'm aching..."))
		user.custom_pain(pain_msg, pain_amt, TRUE, nohalloss = TRUE)

/datum/sex_controller/proc/update_blueballs()
	if(arousal >= BLUEBALLS_GAIN_THRESHOLD)
		return
		//user.add_stressor(/datum/stressor/blueb, 5 MINUTES)
	else if (arousal <= BLUEBALLS_LOOSE_THRESHOLD)
		return
		//user.remove_stressor(/datum/stressor/blueb)

/datum/sex_controller/proc/check_active_ejaculation()
	if(arousal < ACTIVE_EJAC_THRESHOLD)
		return FALSE
	if(is_spent())
		return FALSE
	if(!can_ejaculate())
		return FALSE
	return TRUE

/datum/sex_controller/proc/can_ejaculate()
	//if(!user.get_organ(ORGAN_SLOT_TESTICLES) && !user.get_organ(BP_VAGINA))
	//	return FALSE
	//if(HAS_TRAIT(user, TRAIT_LIMPDICK))
	//	return FALSE
	return TRUE

/datum/sex_controller/proc/handle_passive_ejaculation()
	if(arousal < PASSIVE_EJAC_THRESHOLD)
		return
	if(is_spent())
		return
	if(!can_ejaculate())
		return FALSE
	ejaculate()

/datum/sex_controller/proc/can_use_penis()
	//if(HAS_TRAIT(user, TRAIT_LIMPDICK))
	//	return FALSE
	//var/obj/item/organ/penis/penor = user.get_organ(BP_PENIS)
	//if(!penor)
	//	return FALSE
	//if(!penor.functional)
	//	return FALSE
	return TRUE

/datum/sex_controller/proc/considered_limp()
	if(arousal >= AROUSAL_HARD_ON_THRESHOLD)
		return FALSE
	return TRUE

/datum/sex_controller/proc/process_sexcon(dt)
	handle_arousal_unhorny(dt)
	handle_charge(dt)
	handle_passive_ejaculation()

/datum/sex_controller/proc/handle_arousal_unhorny(dt)
	if(arousal_frozen)
		return
	if(!can_ejaculate())
		adjust_arousal(-dt * IMPOTENT_AROUSAL_LOSS_RATE)
	if(last_arousal_increase_time + AROUSAL_TIME_TO_UNHORNY >= world.time)
		return
	var/rate
	switch(arousal)
		if(-INFINITY to 25)
			rate = AROUSAL_LOW_UNHORNY_RATE
		if(25 to 40)
			rate = AROUSAL_MID_UNHORNY_RATE
		if(40 to INFINITY)
			rate = AROUSAL_HIGH_UNHORNY_RATE
	adjust_arousal(-dt * rate)

/datum/sex_controller/proc/show_ui()
	var/list/dat = list()
	var/force_name = get_force_string()
	var/speed_name = get_speed_string()
	dat += "<center><a href='byond://?src=\ref[src];task=speed_down'>\<</a> [speed_name] <a href='byond://?src=\ref[src];task=speed_up'>\></a> ~|~ <a href='byond://?src=\ref[src];task=force_down'>\<</a> [force_name] <a href='byond://?src=\ref[src];task=force_up'>\></a></center>"
	dat += "<center>| <a href='byond://?src=\ref[src];task=toggle_finished'>[do_until_finished ? "UNTIL IM FINISHED" : "UNTIL I STOP"]</a> |</center>"
	dat += "<center><a href='byond://?src=\ref[src];task=set_arousal'>SET AROUSAL</a> | <a href='byond://?src=\ref[src];task=freeze_arousal'>[arousal_frozen ? "UNFREEZE AROUSAL" : "FREEZE AROUSAL"]</a></center>"
	if(target == user)
		dat += "<center>Doing unto yourself</center>"
	else
		dat += "<center>Doing unto [target]'s</center>"
	if(current_action)
		dat += "<center><a href='byond://?src=\ref[src];task=stop'>Stop</a></center>"
	else
		dat += "<br>"
	dat += "<table width='100%'><td width='50%'></td><td width='50%'></td><tr>"
	var/i = 0
	var/list/sex_action_types = decls_repository.get_decls_of_subtype(/decl/sex_action)
	for(var/sex_action in sex_action_types)
		var/decl/sex_action/saction = sex_action_types[sex_action]
		if(!saction.shows_on_menu(user, target))
			continue
		dat += "<td>"
		var/link = ""
		if(!can_perform_action(saction))
			link = "linkOff"
		if(istype(current_action, saction))
			link = "linkOn"
		dat += "<center><a class='[link]' href='byond://?src=\ref[src];task=action;action_type=[saction::uid]'>[saction.name]</a></center>"
		dat += "</td>"
		i++
		if(i >= 2)
			i = 0
			dat += "</tr><tr>"

	dat += "</tr></table>"
	var/datum/browser/popup = new(user, "sexcon", "Sate Desire", 430, 540)
	popup.set_content(JOINTEXT(dat))
	popup.open()
	return

/datum/sex_controller/Topic(href, href_list)
	if(usr != user)
		return
	switch(href_list["task"])
		if("action")
			var/action_path = href_list["action_type"]
			var/decl/sex_action/saction = decls_repository.get_decl_by_id(action_path)
			if(!saction)
				return
			try_start_action(saction)
		if("stop")
			stop_current_action()
		if("speed_up")
			adjust_speed(1)
		if("speed_down")
			adjust_speed(-1)
		if("force_up")
			adjust_force(1)
		if("force_down")
			adjust_force(-1)
		if("toggle_finished")
			do_until_finished = !do_until_finished
		if("set_arousal")
			var/amount = input(user, "Value above 120 will immediately cause orgasm!", "Set Arousal", arousal) as num
			set_arousal(amount)
		if("freeze_arousal")
			arousal_frozen = !arousal_frozen
	show_ui()

// ? Why does this exist? Consider it depreciated.
/datum/sex_controller/proc/try_stop_current_action()
	if(!current_action)
		return
	desire_stop = TRUE
	user.doing = FALSE

/datum/sex_controller/proc/stop_current_action()
	if(!current_action)
		return
	if(sex_loop_timer)
		deltimer(sex_loop_timer)
		sex_loop_timer = null

	var/decl/sex_action/saction = SEX_ACTION(current_action)
	saction.on_finish(user, target)
	desire_stop = FALSE
	user.doing = FALSE
	current_action = null

/datum/sex_controller/proc/try_start_action(decl/sex_action/saction)
	if(istype(saction, current_action))
		stop_current_action()
		return
	if(!isnull(current_action))
		stop_current_action()
		return
	if(!saction)
		return
	if(!can_perform_action(saction))
		return

	// Set vars
	desire_stop = FALSE
	current_action = saction
	log_attack("[key_name(user)] started sex action on [key_name(target)]: [current_action.name]")
	sex_action_loop()

/datum/sex_controller/proc/sex_action_loop()
	// Do action loop
	var/decl/sex_action/saction = SEX_ACTION(current_action)

	saction.on_start(user, target)
	var/saction_wait = saction.do_time / get_speed_multiplier()
	sex_loop_timer = addtimer(CALLBACK(src, PROC_REF(sex_loop_internal), saction, saction_wait), saction_wait, (TIMER_LOOP | TIMER_UNIQUE | TIMER_STOPPABLE))

/datum/sex_controller/proc/sex_loop_internal(decl/sex_action/saction, saction_wait)
	PRIVATE_PROC(TRUE)

	if(isnull(current_action)) // Stopping the current action always sets it to null, so we don't need any further checks on this.
		return
	if(!isnull(target.client) && (target.get_preference_value(/datum/client_preference/sexable) == PREF_NO)) //Vrell - Needs changed to let me test sex mechanics solo
		stop_current_action()
	if(!do_after(user, (saction_wait), target = target))
		stop_current_action()
	if(!can_perform_action(current_action))
		stop_current_action()
	if(saction.is_finished(user, target))
		stop_current_action()
	if(desire_stop)
		stop_current_action()
	saction.on_perform(user, target)
	// It could want to finish afterwards the performed action
	if(saction.is_finished(user, target))
		stop_current_action()
	if(!saction.continous)
		stop_current_action()

/datum/sex_controller/proc/can_perform_action(decl/sex_action/saction)
	if(!saction)
		return FALSE
	if(!inherent_perform_check(saction))
		return FALSE
	if(!saction.can_perform(user, target))
		return FALSE
	return TRUE

/datum/sex_controller/proc/inherent_perform_check(decl/sex_action/saction)
	if(!target)
		return FALSE
	if(user.stat != CONSCIOUS)
		return FALSE
	if(!user.Adjacent(target))
		return FALSE
	if(saction.check_incapacitated && user.incapacitated())
		return FALSE
	if(saction.check_same_tile)
		var/same_tile = (get_turf(user) == get_turf(target))
		var/grab_bypass = (saction.aggro_grab_instead_same_tile && target.has_danger_grab(user))
		if(!same_tile && !grab_bypass)
			return FALSE
	if(saction.require_grab)
		// Danger grabs are only aggro and higher, so we don't need any special checks.
		var/grabstate = target.has_danger_grab(user)
		if(!grabstate)
			return FALSE
	return TRUE

/datum/sex_controller/proc/get_speed_multiplier()
	switch(speed)
		if(SEX_SPEED_LOW)
			return 1.0
		if(SEX_SPEED_MID)
			return 1.5
		if(SEX_SPEED_HIGH)
			return 2.0
		if(SEX_SPEED_EXTREME)
			return 2.5

/datum/sex_controller/proc/get_stamina_cost_multiplier()
	switch(force)
		if(SEX_FORCE_LOW)
			return 1.0
		if(SEX_FORCE_MID)
			return 1.5
		if(SEX_FORCE_HIGH)
			return 2.0
		if(SEX_SPEED_EXTREME)
			return 2.5

/datum/sex_controller/proc/get_force_pleasure_multiplier(passed_force, giving)
	switch(passed_force)
		if(SEX_FORCE_LOW)
			if(giving)
				return 0.8
			else
				return 0.8
		if(SEX_FORCE_MID)
			if(giving)
				return 1.2
			else
				return 1.2
		if(SEX_FORCE_HIGH)
			if(giving)
				return 1.6
			else
				return 1.2
		if(SEX_FORCE_EXTREME)
			if(giving)
				return 2.0
			else
				return 0.8

/datum/sex_controller/proc/get_force_pain_multiplier(passed_force)
	switch(passed_force)
		if(SEX_FORCE_LOW)
			return 0.5
		if(SEX_FORCE_MID)
			return 1.0
		if(SEX_FORCE_HIGH)
			return 2.0
		if(SEX_FORCE_EXTREME)
			return 3.0

/datum/sex_controller/proc/get_speed_pain_multiplier(passed_speed)
	switch(passed_speed)
		if(SEX_SPEED_LOW)
			return 0.8
		if(SEX_SPEED_MID)
			return 1.0
		if(SEX_SPEED_HIGH)
			return 1.2
		if(SEX_SPEED_EXTREME)
			return 1.4

/datum/sex_controller/proc/get_force_string()
	switch(force)
		if(SEX_FORCE_LOW)
			return "<font color='#eac8de'>GENTLE</font>"
		if(SEX_FORCE_MID)
			return "<font color='#e9a8d1'>FIRM</font>"
		if(SEX_FORCE_HIGH)
			return "<font color='#f05ee1'>ROUGH</font>"
		if(SEX_FORCE_EXTREME)
			return "<font color='#d146f5'>BRUTAL</font>"

/datum/sex_controller/proc/get_speed_string()
	switch(speed)
		if(SEX_SPEED_LOW)
			return "<font color='#eac8de'>SLOW</font>"
		if(SEX_SPEED_MID)
			return "<font color='#e9a8d1'>STEADY</font>"
		if(SEX_SPEED_HIGH)
			return "<font color='#f05ee1'>QUICK</font>"
		if(SEX_SPEED_EXTREME)
			return "<font color='#d146f5'>UNRELENTING</font>"

/datum/sex_controller/proc/get_generic_force_adjective()
	switch(force)
		if(SEX_FORCE_LOW)
			return pick(list("gently", "carefully", "tenderly", "gingerly", "delicately", "lazingly"))
		if(SEX_FORCE_MID)
			return pick(list("firmly", "vigorously", "eagerly", "steadily", "intently"))
		if(SEX_FORCE_HIGH)
			return pick(list("roughly", "carelessly", "forcefully", "fervently", "fiercely"))
		if(SEX_FORCE_EXTREME)
			return pick(list("brutally", "violently", "relentlessly", "savagely", "mercilessly"))

/datum/sex_controller/proc/spanify_force(string)
	var/force_span
	switch(force)
		if(SEX_FORCE_LOW)
			force_span = "love_low"
		if(SEX_FORCE_MID)
			force_span = "love_mid"
		if(SEX_FORCE_HIGH)
			force_span = "love_high"
		if(SEX_FORCE_EXTREME)
			force_span = "love_extreme"
	return SPAN_CLASS(force_span, string)
