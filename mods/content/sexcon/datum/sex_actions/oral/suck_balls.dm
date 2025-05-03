/decl/sex_action/suck_balls
	name = "Suck their balls"
	uid = "sexcon_oral_suckballs"

/decl/sex_action/suck_balls/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	//if(!target.get_organ(ORGAN_SLOT_TESTICLES))
	//	return FALSE
	return TRUE

/decl/sex_action/suck_balls/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()
	var/user_covered_parts = user.get_covered_body_parts()

	if(target_covered_parts & SLOT_LOWER_BODY || user_covered_parts & SLOT_FACE)
		return FALSE
	//if(!target.get_organ(ORGAN_SLOT_TESTICLES))
	//	return FALSE

	return TRUE

/decl/sex_action/suck_balls/on_start(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] starts sucking [target]'s balls..."))

/decl/sex_action/suck_balls/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] sucks [target]'s balls..."))
	user.make_sucking_noise()

	user.sexcon.perform_sex_action(target, 1, 3, TRUE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/suck_balls/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops sucking [target]'s balls ..."))

/decl/sex_action/suck_balls/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
