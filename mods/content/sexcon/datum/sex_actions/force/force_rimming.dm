/decl/sex_action/force_rimming
	name = "Force them to rim you"
	uid = "sexcon_force_rimming"
	require_grab = TRUE
	stamina_cost = 1.0

/decl/sex_action/force_rimming/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	return TRUE

/decl/sex_action/force_rimming/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(user_covered_parts & SLOT_LOWER_BODY || target_covered_parts & SLOT_FACE)
		return FALSE

	return TRUE

/decl/sex_action/force_rimming/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] shoves [target]'s head against [pronouns.his] butt!"))

/decl/sex_action/force_rimming/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] forces [target] to rim [pronouns.his] butt."))
	target.make_sucking_noise()

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 0, 2, FALSE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/force_rimming/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] pulls [target]'s head away from [pronouns.his] butt."))

/decl/sex_action/force_rimming/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
