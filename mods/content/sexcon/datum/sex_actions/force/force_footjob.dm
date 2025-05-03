/decl/sex_action/force_footjob
	name = "Use their feet to get off"
	uid = "sexcon_force_footjob"
	check_same_tile = FALSE
	require_grab = TRUE
	stamina_cost = 1.0

/decl/sex_action/force_footjob/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return
	return TRUE

/decl/sex_action/force_footjob/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()
	var/user_covered_parts = user.get_covered_body_parts()

	if(target_covered_parts & SLOT_FEET || user_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return

	return TRUE

/decl/sex_action/force_footjob/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] grabs [target]'s feet and clamps them around [pronouns.his] cock!"))

/decl/sex_action/force_footjob/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] uses [target] feet to jerk off."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 20, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

/decl/sex_action/force_footjob/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] pulls [pronouns.his] cock out from inbetween [target]'s feet."))
