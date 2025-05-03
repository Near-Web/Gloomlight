/decl/sex_action/force_blowjob
	name = "Force them to suck"
	uid = "sexcon_force_blowjob"
	require_grab = TRUE
	stamina_cost = 1.0

/decl/sex_action/force_blowjob/shows_on_menu(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return FALSE
	return TRUE

/decl/sex_action/force_blowjob/can_perform(mob/living/human/user, mob/living/human/target)
	if(user == target)
		return FALSE

	var/user_covered_parts = user.get_covered_body_parts()
	var/target_covered_parts = target.get_covered_body_parts()

	if(user_covered_parts & SLOT_LOWER_BODY || target_covered_parts & SLOT_FACE)
		return FALSE
	if(!user.get_organ(BP_PENIS))
		return FALSE
	if(!user.sexcon.can_use_penis())
		return

	return TRUE

/decl/sex_action/force_blowjob/on_start(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] forces [target]'s head down to swallow and suck on [pronouns.his] cock!"))
	playsound(target, list('mods/content/sexcon/sounds/mat/insert (1).ogg','mods/content/sexcon/sounds/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/decl/sex_action/force_blowjob/on_perform(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] forces [target] to suck [pronouns.his] cock."))
	target.make_sucking_noise()

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	if(user.sexcon.check_active_ejaculation())
		user.visible_message(SPAN_PINK("cums into [target]'s throat!"))
		user.sexcon.cum_into()

	user.sexcon.perform_sex_action(target, 0, 7, FALSE)
	if(!user.sexcon.considered_limp())
		user.sexcon.perform_deepthroat_oxyloss(target, 1.3)
	target.sexcon.handle_passive_ejaculation()

/decl/sex_action/force_blowjob/on_finish(mob/living/human/user, mob/living/human/target)
	. = ..()
	var/decl/pronouns/pronouns = .

	user.visible_message(SPAN_WARNING("[user] pulls [pronouns.his] cock out of [target]'s throat."))

/decl/sex_action/force_blowjob/is_finished(mob/living/human/user, mob/living/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
