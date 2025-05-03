/decl/sex_action/toy_other_oral
	name = "Use toy on their mouth"
	uid = "sexcon_toy_otheroral"

/decl/sex_action/toy_other_oral/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!user.get_dildo_in_either_hand())
		return FALSE
	return TRUE

/decl/sex_action/toy_other_oral/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	var/target_covered_parts = target.get_covered_body_parts()
	if(target_covered_parts & SLOT_FACE)
		return FALSE
	if(!user.get_dildo_in_either_hand())
		return FALSE
	return TRUE

/decl/sex_action/toy_other_oral/on_start(mob/living/human/user, mob/living/human/target)
	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(SPAN_WARNING("[user] forces [target]'s to gobble on \the [dildo]..."))

/decl/sex_action/toy_other_oral/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] forces [target] to suck on the dildo..."))
	target.make_sucking_noise()

/decl/sex_action/toy_other_oral/on_finish(mob/living/human/user, mob/living/human/target)
	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(SPAN_WARNING("[user] pulls \the [dildo] from [target]'s mouth."))

/decl/sex_action/toy_other_oral/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
