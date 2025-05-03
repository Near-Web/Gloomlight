/decl/sex_action/armpit_nuzzle
	name = "Nuzzle their armpit"
	uid = "sexcon_oral_armpitnuzzle"

/decl/sex_action/armpit_nuzzle/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	return TRUE

/decl/sex_action/armpit_nuzzle/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()
	var/user_covered_parts = user.get_covered_body_parts()

	if(target_covered_parts & SLOT_UPPER_BODY || user_covered_parts & SLOT_FACE)
		return FALSE

	return TRUE

/decl/sex_action/armpit_nuzzle/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] moves [pronouns.his] head against [target]'s armpit..."))

/decl/sex_action/armpit_nuzzle/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] nuzzles [target]'s armpit..."))

/decl/sex_action/armpit_nuzzle/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops nuzzling [target]'s armpit..."))
