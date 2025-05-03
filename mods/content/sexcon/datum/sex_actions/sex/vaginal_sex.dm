/decl/sex_action/vaginal_sex
	name = "Fuck their cunt"
	uid = "sexcon_sex_vaginal"
	stamina_cost = 1.0

/decl/sex_action/vaginal_sex/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!target.get_organ(BP_VAGINA))
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return FALSE
	return TRUE

/decl/sex_action/vaginal_sex/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()
	var/user_covered_parts = user.get_covered_body_parts()

	if(target_covered_parts & SLOT_LOWER_BODY || user_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!target.get_organ(BP_VAGINA))
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return FALSE
	if(!user.sexcon.can_use_penis())
		return

	return TRUE

/decl/sex_action/vaginal_sex/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] slides [pronouns.his] cock into [target]'s cunt!"))
	playsound(target, list('mods/content/sexcon/sounds/mat/insert (1).ogg','mods/content/sexcon/sounds/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/decl/sex_action/vaginal_sex/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks [target]'s cunt."))
	playsound(target, 'mods/content/sexcon/sounds/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 0, TRUE)
	if(user.sexcon.check_active_ejaculation())
		user.visible_message(SPAN_PINK("[user] cums into [target]'s cunt!"))
		user.sexcon.cum_into()
		user.try_impregnate(target)
		user.virginity = FALSE
		target.virginity = FALSE

	if(user.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 1.2, 3, FALSE)
	else
		user.sexcon.perform_sex_action(target, 2.4, 7, FALSE)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/vaginal_sex/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] pulls [pronouns.his] cock out of [target]'s cunt."))

/decl/sex_action/vaginal_sex/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
