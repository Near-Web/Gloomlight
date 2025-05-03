/decl/sex_action/masturbate_penis_other
	name = "Jerk them off"
	uid = "sexcon_masturbate_penisother"
	check_same_tile = FALSE

/decl/sex_action/masturbate_penis_other/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!target.get_organ(BP_PENIS))
		return FALSE
	return TRUE

/decl/sex_action/masturbate_penis_other/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()

	if(target_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!target.get_organ(BP_PENIS))
		return FALSE

	return TRUE

/decl/sex_action/masturbate_penis_other/on_start(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] starts jerking [target]'s off..."))

/decl/sex_action/masturbate_penis_other/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] jerks [target]'s cock off..."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 0, TRUE)

	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/masturbate_penis_other/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops jerking [target]'s off."))

/decl/sex_action/masturbate_penis_other/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
