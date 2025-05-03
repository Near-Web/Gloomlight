/decl/sex_action/masturbate_other_breasts
	name = "Rub their breasts"
	uid = "sexcon_masturbate_otherbreasts"
	check_same_tile = FALSE

/decl/sex_action/masturbate_other_breasts/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!target.get_organ(BP_BREASTS))
		return FALSE
	return TRUE

/decl/sex_action/masturbate_other_breasts/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()

	if(target_covered_parts & SLOT_UPPER_BODY)
		return FALSE
	if(!target.get_organ(BP_BREASTS))
		return FALSE

	return TRUE

/decl/sex_action/masturbate_other_breasts/on_start(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] starts rubbing [target]'s breasts..."))

/decl/sex_action/masturbate_other_breasts/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fondles [target]'s breasts..."))

	user.sexcon.perform_sex_action(target, 1, 4, TRUE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/masturbate_other_breasts/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops stroking [target]'s breasts."))

/decl/sex_action/masturbate_other_breasts/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
