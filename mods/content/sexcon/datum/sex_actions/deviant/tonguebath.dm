/decl/sex_action/tonguebath
	name = "Bathe with tongue"
	uid = "sexcon_deviant_tonguebath"

/decl/sex_action/tonguebath/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	return TRUE

/decl/sex_action/tonguebath/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(target_covered_parts & SLOT_LOWER_BODY || user_covered_parts & SLOT_FACE)
		return FALSE

	return TRUE

/decl/sex_action/tonguebath/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] sticks [pronouns.his] tongue out, getting close to [target]..."))

/decl/sex_action/tonguebath/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] bathes [target]'s body with [pronouns.his] tongue..."))
	user.make_sucking_noise()

	user.sexcon.perform_sex_action(target, 0.5, 0, TRUE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/tonguebath/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops bathing [target]'s body ..."))

/decl/sex_action/tonguebath/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
