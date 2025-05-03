/decl/sex_action/force_crotch_nuzzle
	name = "Force them to nuzzle"
	uid = "sexcon_force_crotchnuzzle"
	require_grab = TRUE
	stamina_cost = 1.0

/decl/sex_action/force_crotch_nuzzle/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	return TRUE

/decl/sex_action/force_crotch_nuzzle/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(user_covered_parts & SLOT_LOWER_BODY || target_covered_parts & SLOT_FACE)
		return FALSE

	return TRUE

/decl/sex_action/force_crotch_nuzzle/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] forces [target]'s head against [pronouns.his] crotch!"))

/decl/sex_action/force_crotch_nuzzle/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] forces [target] to nuzzle [pronouns.his] crotch."))

	user.sexcon.perform_sex_action(user, 0.5, 0, TRUE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/force_crotch_nuzzle/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] pulls [target]'s head away from [pronouns.his] crotch."))

/decl/sex_action/force_crotch_nuzzle/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
