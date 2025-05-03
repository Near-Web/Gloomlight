/decl/sex_action/force_armpit_nuzzle
	name = "Force them against armpit"
	uid = "sexcon_force_armpitnuzzle"
	require_grab = TRUE
	stamina_cost = 1.0

/decl/sex_action/force_armpit_nuzzle/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	return TRUE

/decl/sex_action/force_armpit_nuzzle/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(user_covered_parts & SLOT_UPPER_BODY || target_covered_parts & SLOT_FACE)
		return FALSE

	return TRUE

/decl/sex_action/force_armpit_nuzzle/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] forces [target]'s head against [pronouns.his] armpit!"))

/decl/sex_action/force_armpit_nuzzle/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] forces [target] to nuzzle [pronouns.his] armpit."))

	user.sexcon.perform_sex_action(user, 0.5, 0, TRUE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/force_armpit_nuzzle/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] pulls [target]'s head away from [pronouns.his] armpit."))

/decl/sex_action/force_armpit_nuzzle/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
