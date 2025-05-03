/decl/sex_action/force_thighjob
	name = "Jerk them off with thighs"
	uid = "sexcon_deviant_thighjob"

/decl/sex_action/force_thighjob/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!target.get_organ(BP_PENIS))
		return FALSE
	return TRUE

/decl/sex_action/force_thighjob/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()

	if(target_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!target.get_organ(BP_PENIS))
		return FALSE

	return TRUE

/decl/sex_action/force_thighjob/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] moves [pronouns.his] thighs between [target]'s cock..."))

/decl/sex_action/force_thighjob/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] jerks [target]'s cock with [pronouns.his] thighs..."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/force_thighjob/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] stops jerking [target] off with [pronouns.his] thighs..."))

/decl/sex_action/force_thighjob/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
