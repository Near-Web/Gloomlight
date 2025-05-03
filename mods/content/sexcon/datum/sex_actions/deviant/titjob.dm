/decl/sex_action/titjob
	name = "Use their tits to get off"
	uid = "sexcon_deviant_titjob"

/decl/sex_action/titjob/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return
	if(!target.get_organ(BP_BREASTS))
		return
	return TRUE

/decl/sex_action/titjob/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(user_covered_parts & SLOT_LOWER_BODY || target_covered_parts & SLOT_UPPER_BODY)
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return FALSE
	if(!target.get_organ(BP_BREASTS))
		return FALSE

	return TRUE

/decl/sex_action/titjob/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] grabs [target]'s tits and shoves [pronouns.his] cock inbetween!"))

/decl/sex_action/titjob/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks [target]'s tits."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 20, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

/decl/sex_action/titjob/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] pulls [pronouns.his] cock out from inbetween [target]'s tits."))
