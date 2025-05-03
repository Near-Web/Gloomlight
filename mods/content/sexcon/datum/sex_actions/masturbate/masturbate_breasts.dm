/decl/sex_action/masturbate_breasts
	name = "Rub breasts"
	uid = "sexcon_masturbate_breasts"

/decl/sex_action/masturbate_breasts/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user != target)
		return FALSE
	if(!user.get_organ(BP_BREASTS))
		return FALSE
	return TRUE

/decl/sex_action/masturbate_breasts/can_perform(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()

	if(user_covered_parts & SLOT_UPPER_BODY)
		return FALSE
	if(!user.get_organ(BP_BREASTS))
		return FALSE

	return TRUE

/decl/sex_action/masturbate_breasts/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] starts rubbing [pronouns.his] breasts..."))

/decl/sex_action/masturbate_breasts/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fondles [pronouns.his] breasts..."))

	user.sexcon.perform_sex_action(user, 1, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

/decl/sex_action/masturbate_breasts/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] stops fondling [pronouns.his] breasts."))

/decl/sex_action/masturbate_breasts/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
