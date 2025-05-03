/decl/sex_action/toy_vagina
	name = "Pleasure cunt with toy"
	uid = "sexcon_toy_vagina"

/decl/sex_action/toy_vagina/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user != target)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE
	if(!user.get_dildo_in_either_hand())
		return FALSE
	return TRUE

/decl/sex_action/toy_vagina/can_perform(mob/living/human/user, mob/living/human/target)
	if(user != target)
		return FALSE
	var/user_covered_parts = user.get_covered_body_parts()
	if(user_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE
	if(!user.get_dildo_in_either_hand())
		return FALSE
	return TRUE

/decl/sex_action/toy_vagina/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(SPAN_WARNING("[user] shoves \the [dildo] in [pronouns.his] cunt..."))

/decl/sex_action/toy_vagina/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] pleasures [pronouns.his] cunt..."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)

	user.sexcon.handle_passive_ejaculation()

/decl/sex_action/toy_vagina/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(SPAN_WARNING("[user] pulls out \the [dildo] from [pronouns.his] cunt."))

/decl/sex_action/toy_vagina/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
