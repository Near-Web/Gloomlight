/decl/sex_action/force_suck_nipples
	name = "Force them to suck nipples"
	uid = "sexcon_force_sucknipples"
	require_grab = TRUE
	stamina_cost = 1.0

/decl/sex_action/force_suck_nipples/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!user.get_organ(BP_BREASTS))
		return FALSE
	return TRUE

/decl/sex_action/force_suck_nipples/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(user_covered_parts & SLOT_UPPER_BODY || target_covered_parts & SLOT_FACE)
		return FALSE
	if(!user.get_organ(BP_BREASTS))
		return FALSE
	return TRUE

/decl/sex_action/force_suck_nipples/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] forces [target]'s head down to swallow and suck on [pronouns.his] nipples!"))
	playsound(target, list('mods/content/sexcon/sounds/mat/insert (1).ogg','mods/content/sexcon/sounds/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/decl/sex_action/force_suck_nipples/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] forces [target] to suck [pronouns.his] nipples."))
	target.make_sucking_noise()

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)

	user.sexcon.perform_sex_action(target, 0, 7, FALSE)
	if(!user.sexcon.considered_limp())
		user.sexcon.perform_deepthroat_oxyloss(target, 0.6)
	target.sexcon.handle_passive_ejaculation()

	/*
	var/obj/item/organ/breasts/breasts = user.get_organ(BP_BREASTS)
	var/milk_to_add = min(max(breasts.breast_size, 1), breasts.milk_stored)
	if(breasts.lactating && milk_to_add > 0 && prob(25))
		target.reagents.add_reagent(/datum/reagent/consumable/milk, milk_to_add)
		breasts.milk_stored -= milk_to_add
		to_chat(target, span_notice("I can taste milk."))
		to_chat(user, span_notice("I can feel milk leak from my buds."))
	*/

/decl/sex_action/force_suck_nipples/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] pulls [pronouns.his] nipples out of [target]'s mouth."))

/decl/sex_action/force_suck_nipples/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
