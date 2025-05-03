/decl/sex_action/masturbate_vagina
	name = "Stroke clit"
	uid = "sexcon_masturbate_vagina"

/decl/sex_action/masturbate_vagina/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user != target)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE
	return TRUE

/decl/sex_action/masturbate_vagina/can_perform(mob/living/user, mob/living/target)
	if(user != target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()

	if(user_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE

	return TRUE

/decl/sex_action/masturbate_vagina/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] starts stroking [pronouns.his] clit..."))

/decl/sex_action/masturbate_vagina/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] strokes [pronouns.his] clit..."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)

	user.sexcon.handle_passive_ejaculation()

/decl/sex_action/masturbate_vagina/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops stroking."))

/decl/sex_action/masturbate_vagina/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
