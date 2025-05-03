/decl/sex_action/suck_nipples
	name = "Suck their nipples"
	uid = "sexcon_oral_sucknipples"
	check_same_tile = FALSE

/decl/sex_action/suck_nipples/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!target.get_organ(BP_BREASTS))
		return FALSE
	return TRUE

/decl/sex_action/suck_nipples/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()
	var/user_covered_parts = user.get_covered_body_parts()

	if(target_covered_parts & SLOT_UPPER_BODY || user_covered_parts & SLOT_FACE)
		return FALSE
	if(!target.get_organ(BP_BREASTS))
		return FALSE

	return TRUE

/decl/sex_action/suck_nipples/on_start(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] starts sucking [target]'s nipples..."))

/decl/sex_action/suck_nipples/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] sucks [target]'s nipples..."))
	user.make_sucking_noise()

	user.sexcon.perform_sex_action(target, 1, 3, TRUE)
	target.sexcon.handle_passive_ejaculation()

	/*
	var/obj/item/organ/breasts/breasts = target.get_organ(BP_BREASTS)
	var/milk_to_add = min(max(breasts.breast_size, 1), breasts.milk_stored)
	if(breasts.lactating && milk_to_add > 0 && prob(25))
		user.reagents.add_reagent(/datum/reagent/consumable/milk, milk_to_add)
		breasts.milk_stored -= milk_to_add
		to_chat(user, span_notice("I can taste milk."))
		to_chat(target, span_notice("I can feel milk leak from my buds."))
	*/

/decl/sex_action/suck_nipples/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] stops sucking [target]'s nipples ..."))

/decl/sex_action/suck_nipples/is_finished(mob/living/human/user, mob/living/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
