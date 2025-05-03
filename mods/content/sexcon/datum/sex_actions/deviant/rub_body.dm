/decl/sex_action/rub_body
	name = "Rub their body"
	uid = "sexcon_deviant_rubbody"
	check_same_tile = FALSE

/decl/sex_action/rub_body/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	return TRUE

/decl/sex_action/rub_body/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()

	if(target_covered_parts & SLOT_UPPER_BODY)
		return FALSE

	return TRUE

/decl/sex_action/rub_body/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] places [pronouns.his] hands onto [target]..."))

/decl/sex_action/rub_body/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rubs [target]'s body..."))
	user.make_sucking_noise()

	user.sexcon.perform_sex_action(target, 0.5, 0, TRUE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/rub_body/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops rubbing [target]'s body ..."))

/decl/sex_action/rub_body/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
