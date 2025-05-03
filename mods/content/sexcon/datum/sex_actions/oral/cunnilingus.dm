/decl/sex_action/cunnilingus
	name = "Suck their cunt off"
	uid = "sexcon_oral_cunnilngus"

/decl/sex_action/cunnilingus/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!target.get_organ(BP_VAGINA))
		return FALSE
	return TRUE

/decl/sex_action/cunnilingus/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()
	var/user_covered_parts = user.get_covered_body_parts()

	if(target_covered_parts & SLOT_LOWER_BODY || user_covered_parts & SLOT_FACE)
		return FALSE
	if(!target.get_organ(BP_VAGINA))
		return FALSE

	return TRUE

/decl/sex_action/cunnilingus/on_start(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] starts sucking [target]'s clit..."))

/decl/sex_action/cunnilingus/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] sucks [target]'s clit..."))
	user.make_sucking_noise()

	user.sexcon.perform_sex_action(target, 2, 3, TRUE)
	if(target.sexcon.check_active_ejaculation())
		target.visible_message(SPAN_PINK("[target] ejaculates into [user]'s mouth!"))
		target.sexcon.cum_into()

/decl/sex_action/cunnilingus/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops sucking [target]'s clit ..."))

/decl/sex_action/cunnilingus/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
