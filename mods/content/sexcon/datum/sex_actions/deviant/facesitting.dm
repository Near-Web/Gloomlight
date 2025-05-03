/decl/sex_action/facesitting
	name = "Sit on their face"
	uid = "sexcon_deviant_facesitting"

/decl/sex_action/facesitting/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	return TRUE

/decl/sex_action/facesitting/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(target_covered_parts & SLOT_FACE || user_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	// Need to be standing
	if(user.current_posture.prone)
		return FALSE
	// Target can't be standing
	if(!target.current_posture.prone)
		return FALSE

	return TRUE

/decl/sex_action/facesitting/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] sits [pronouns.his] butt on [target]'s face!"))

/decl/sex_action/facesitting/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	var/verbstring = pick(list("rubs", "smushes", "forces"))
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] [verbstring] [pronouns.his] butt against [target] face."))
	target.make_sucking_noise()

	user.sexcon.perform_sex_action(user, 1, 3, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_deepthroat_oxyloss(target, 1.3)
	user.sexcon.perform_sex_action(target, 0, 2, FALSE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/facesitting/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] gets off [target]'s face."))

/decl/sex_action/facesitting/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
