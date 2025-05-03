/decl/sex_action/throat_sex
	name = "Fuck their throat"
	uid = "sexcon_sex_throat"
	stamina_cost = 1.0

/decl/sex_action/throat_sex/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return FALSE
	return TRUE

/decl/sex_action/throat_sex/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()
	var/user_covered_parts = user.get_covered_body_parts()

	if(target_covered_parts & SLOT_FACE || user_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return FALSE
	if(!user.sexcon.can_use_penis())
		return

	return TRUE

/decl/sex_action/throat_sex/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] slides [pronouns.his] cock into [target]'s throat!"))
	playsound(target, list('mods/content/sexcon/sounds/mat/insert (1).ogg','mods/content/sexcon/sounds/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/decl/sex_action/throat_sex/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks [target]'s throat."))
	playsound(target, 'mods/content/sexcon/sounds/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 0, TRUE)
	if(user.sexcon.check_active_ejaculation())
		user.visible_message(SPAN_PINK("[user] cums into [target]'s throat!"))
		user.sexcon.cum_into()
		user.virginity = FALSE

	if(user.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 0, 2, FALSE)
	else
		user.sexcon.perform_sex_action(target, 0, 7, FALSE)
		user.sexcon.perform_deepthroat_oxyloss(target, 2.6)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/throat_sex/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] pulls [pronouns.his] cock out of [target]'s throat."))

/decl/sex_action/throat_sex/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
