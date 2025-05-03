/decl/sex_action/masturbate_penis_over
	name = "Jerk over them"
	uid = "sexcon_masturbate_penisover"
	check_same_tile = FALSE

/decl/sex_action/masturbate_penis_over/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return FALSE
	return TRUE

/decl/sex_action/masturbate_penis_over/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()

	if(user_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return FALSE
	if(!user.sexcon.can_use_penis())
		return

	return TRUE

/decl/sex_action/masturbate_penis_over/on_start(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] starts jerking over [target]..."))

/decl/sex_action/masturbate_penis_over/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	var/chosen_verb = pick(list("jerks [pronouns.his] cock", "strokes [pronouns.his] cock", "masturbates", "jerks off"))
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] [chosen_verb] over [target]"))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)

	if(user.sexcon.check_active_ejaculation())
		user.visible_message(SPAN_PINK("[user] cums over [target]'s body!"))
		user.sexcon.cum_onto()

/decl/sex_action/masturbate_penis_over/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops jerking off."))

/decl/sex_action/masturbate_penis_over/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
