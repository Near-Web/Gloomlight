/decl/sex_action/kissing
	name = "Make out with them"
	uid = "sexcon_oral_kissing"
	check_same_tile = FALSE

/decl/sex_action/kissing/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	return TRUE

/decl/sex_action/kissing/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()
	var/user_covered_parts = user.get_covered_body_parts()

	if(target_covered_parts & SLOT_FACE || user_covered_parts & SLOT_FACE)
		return FALSE

	return TRUE

/decl/sex_action/kissing/on_start(mob/living/human/user, mob/living/human/target)
	..()
	user.visible_message(SPAN_WARNING("[user] starts making out with [target]..."))

/decl/sex_action/kissing/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] makes out with [target]..."))
	user.make_sucking_noise()

	user.sexcon.perform_sex_action(user, 1, 2, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 1, 2, TRUE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/kissing/on_finish(mob/living/human/user, mob/living/human/target)
	..()
	user.visible_message(SPAN_WARNING("[user] stops making out with [target] ..."))
