/decl/sex_action/vaginal_ride_sex
	name = "Ride them"
	uid = "sexcon_sex_vaginalride"
	stamina_cost = 1.0
	aggro_grab_instead_same_tile = FALSE

/decl/sex_action/vaginal_ride_sex/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE
	if(!target.get_organ(BP_PENIS))
		return FALSE
	return TRUE

/decl/sex_action/vaginal_ride_sex/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/target_covered_parts = target.get_covered_body_parts()
	var/user_covered_parts = user.get_covered_body_parts()

	if(target_covered_parts & SLOT_LOWER_BODY || user_covered_parts & SLOT_LOWER_BODY)
		return FALSE
	if(!user.get_organ(BP_VAGINA))
		return FALSE
	if(!target.get_organ(BP_PENIS))
		return FALSE

	return TRUE

/decl/sex_action/vaginal_ride_sex/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .
	var/decl/pronouns/target_pronouns = target.get_pronouns()

	user.visible_message(SPAN_WARNING("[user] gets on top of [target] and begins riding [target_pronouns.him] with [pronouns.his] cunt!"))
	playsound(target, list('mods/content/sexcon/sounds/mat/insert (1).ogg','mods/content/sexcon/sounds/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/decl/sex_action/vaginal_ride_sex/on_perform(mob/living/human/user, mob/living/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rides [target]."))
	playsound(target, 'mods/content/sexcon/sounds/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)

	if(target.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 1.2, 3, TRUE)
	else
		user.sexcon.perform_sex_action(target, 2.4, 7, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 2, 4, FALSE)
	if(target.sexcon.check_active_ejaculation())
		target.visible_message(SPAN_PINK("[target] cums into [user]'s cunt!"))
		target.sexcon.cum_into()
		target.try_impregnate(user)
		target.virginity = FALSE
		user.virginity = FALSE

/decl/sex_action/vaginal_ride_sex/on_finish(mob/living/human/user, mob/living/human/target)
	user.visible_message(SPAN_WARNING("[user] gets off [target]."))

/decl/sex_action/vaginal_ride_sex/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
