/decl/sex_action/masturbate_other_anus
	name = "Finger their butt"
	uid = "sexcon_masturbate_otheranus"
	check_same_tile = FALSE

/decl/sex_action/masturbate_other_anus/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	return TRUE

/decl/sex_action/masturbate_other_anus/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()
	if(target_covered_parts & SLOT_LOWER_BODY)
		return FALSE

	return TRUE

/decl/sex_action/masturbate_other_anus/on_start(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] starts fingering [target]'s butt..."))

/decl/sex_action/masturbate_other_anus/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fingers [target]'s butt..."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 6, TRUE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/masturbate_other_anus/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops fingering [target]'s butt."))

/decl/sex_action/masturbate_other_anus/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
