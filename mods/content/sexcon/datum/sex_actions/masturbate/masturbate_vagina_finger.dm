/decl/sex_action/masturbate_vagina_finger
	name = "Finger pussy"
	uid = "sexcon_masturbate_vaginafinger"

/decl/sex_action/masturbate_vagina_finger/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user != target)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE
	return TRUE

/decl/sex_action/masturbate_vagina_finger/can_perform(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()

	if(user_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE

	return TRUE

/decl/sex_action/masturbate_vagina_finger/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] starts fingering [pronouns.his] [pick("slit","cunt","pussy","snatch")]..."))

/decl/sex_action/masturbate_vagina_finger/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fingers [pronouns.his] [pick("slit","cunt","pussy","snatch")]..."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)

	user.sexcon.handle_passive_ejaculation()

/decl/sex_action/masturbate_vagina_finger/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops fingering."))

/decl/sex_action/masturbate_vagina_finger/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
