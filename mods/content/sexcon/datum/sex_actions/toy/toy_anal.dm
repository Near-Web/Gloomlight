/decl/sex_action/toy_anal
	name = "Pleasure butt with toy"
	uid = "sexcon_toy_anal"

/decl/sex_action/toy_anal/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user != target)
		return FALSE
	if(!user.get_dildo_in_either_hand())
		return FALSE
	return TRUE

/decl/sex_action/toy_anal/can_perform(mob/living/human/user, mob/living/human/target)
	if(user != target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	if(user_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!user.get_dildo_in_either_hand())
		return FALSE

	return TRUE

/decl/sex_action/toy_anal/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(SPAN_WARNING("[user] starts shoving \the [dildo] in [pronouns.his] butt..."))

/decl/sex_action/toy_anal/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] pleasures [pronouns.his] butt with \the [dildo]."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 6, TRUE)
	user.sexcon.handle_passive_ejaculation()

/decl/sex_action/toy_anal/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(SPAN_WARNING("[user] pulls \the [dildo] from [pronouns.his] butt."))

/decl/sex_action/toy_anal/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
