/decl/sex_action/toy_oral
	name = "Swallow toy"
	uid = "sexcon_toy_oral"

/decl/sex_action/toy_oral/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user != target)
		return FALSE
	if(!user.get_dildo_in_either_hand())
		return FALSE
	return TRUE

/decl/sex_action/toy_oral/can_perform(mob/living/human/user, mob/living/human/target)
	if(user != target)
		return FALSE
	var/user_covered_parts = user.get_covered_body_parts()
	if(user_covered_parts & SLOT_FACE)
		return FALSE
	if(!user.get_dildo_in_either_hand())
		return FALSE
	return TRUE

/decl/sex_action/toy_oral/on_start(mob/living/human/user, mob/living/human/target)
	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(SPAN_WARNING("[user] starts swallowing on \the [dildo]..."))

/decl/sex_action/toy_oral/on_perform(mob/living/human/user, mob/living/human/target)
	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] blows \the [dildo]..."))
	user.make_sucking_noise()

/decl/sex_action/toy_oral/on_finish(mob/living/human/user, mob/living/human/target)
	var/obj/item/dildo/dildo = user.get_dildo_in_either_hand()
	user.visible_message(SPAN_WARNING("[user] stops blowing \the [dildo]."))

/decl/sex_action/toy_oral/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
