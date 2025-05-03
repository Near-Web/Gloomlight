/decl/sex_action/masturbate_other_vagina_finger
	name = "Finger their pussy"
	uid = "sexcon_masturbate_othervaginafinger"
	check_same_tile = FALSE

/decl/sex_action/masturbate_other_vagina_finger/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!target.get_organ(BP_VAGINA))
		return FALSE
	return TRUE

/decl/sex_action/masturbate_other_vagina_finger/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()

	if(target_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!target.get_organ(BP_VAGINA))
		return FALSE

	return TRUE

/decl/sex_action/masturbate_other_vagina_finger/on_start(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] starts fingering [target]'s [pick("slit","cunt","pussy","snatch")]..."))

/decl/sex_action/masturbate_other_vagina_finger/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fingers [target]'s [pick("slit","cunt","pussy","snatch")]..."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/masturbate_other_vagina_finger/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops fingering [target]'s [pick("slit","cunt","pussy","snatch")]."))

/decl/sex_action/masturbate_other_vagina_finger/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
