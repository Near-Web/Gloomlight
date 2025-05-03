/decl/sex_action/scissoring
	name = "Scissor them"
	uid = "sexcon_deviant_scissoring"

/decl/sex_action/scissoring/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return
	if(!target.get_organ(BP_VAGINA))
		return
	return TRUE

/decl/sex_action/scissoring/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(user_covered_parts & SLOT_LOWER_BODY || target_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE
	if(!target.get_organ(BP_VAGINA))
		return FALSE

	return TRUE

/decl/sex_action/scissoring/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] spreads [pronouns.his] legs and aligns [pronouns.his] cunt against [target]'s own!"))

/decl/sex_action/scissoring/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] scissors with [target]'s cunt."))
	playsound(target, 'mods/content/sexcon/sounds/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 1, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 1, 4, TRUE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/scissoring/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops scissoring with [target]."))
