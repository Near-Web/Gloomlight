/decl/sex_action/force_foot_lick
	name = "Force them to lick your feet"
	uid = "sexcon_force_footlick"
	check_same_tile = FALSE
	require_grab = TRUE
	stamina_cost = 1.0

/decl/sex_action/force_foot_lick/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	return TRUE

/decl/sex_action/force_foot_lick/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(user_covered_parts & SLOT_FEET || target_covered_parts & SLOT_FACE)
		return FALSE

	return TRUE

/decl/sex_action/force_foot_lick/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] shoves [pronouns.his] feet against [target]'s head!"))

/decl/sex_action/force_foot_lick/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] forces [target] to lick [pronouns.his] feet."))
	target.make_sucking_noise()

/decl/sex_action/force_foot_lick/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] pulls [pronouns.his] feet away from [target]'s head."))
