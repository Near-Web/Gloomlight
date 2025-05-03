/decl/sex_action/force_cunnilingus
	name = "Force them to suck"
	uid = "sexcon_force_cunnilingus"
	require_grab = TRUE
	stamina_cost = 1.0

/decl/sex_action/force_cunnilingus/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE
	return TRUE

/decl/sex_action/force_cunnilingus/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(user_covered_parts & SLOT_LOWER_BODY || target_covered_parts & SLOT_FACE)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE

	return TRUE

/decl/sex_action/force_cunnilingus/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] forces [target]'s head against [pronouns.his] cunt!"))

/decl/sex_action/force_cunnilingus/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] forces [target] to suck [pronouns.his] cunt."))
	target.make_sucking_noise()

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 0, 2, FALSE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/force_cunnilingus/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] pulls [target]'s head away."))

/decl/sex_action/force_cunnilingus/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
