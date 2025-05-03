/decl/sex_action/toy_other_vagina
	name = "Use toy on their cunt"
	uid = "sexcon_toy_othervagina"

/decl/sex_action/toy_other_vagina/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!target.get_organ(BP_VAGINA))
		return FALSE
	if(!user.get_dildo_in_either_hand())
		return FALSE
	return TRUE

/decl/sex_action/toy_other_vagina/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	var/target_covered_parts = target.get_covered_body_parts()
	if(target_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!target.get_organ(BP_VAGINA))
		return FALSE
	if(!user.get_dildo_in_either_hand())
		return FALSE
	return TRUE

/decl/sex_action/toy_other_vagina/on_start(mob/living/human/user, mob/living/human/target)
	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(SPAN_WARNING("[user] shoves \the [dildo] in [target]'s cunt..."))

/decl/sex_action/toy_other_vagina/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] pleasures [target]'s cunt..."))
	playsound(user, 'mods/content/sexcon/sounds/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/toy_other_vagina/on_finish(mob/living/human/user, mob/living/human/target)
	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(SPAN_WARNING("[user] pulls out \the [dildo] from [target]'s cunt."))

/decl/sex_action/toy_other_vagina/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
