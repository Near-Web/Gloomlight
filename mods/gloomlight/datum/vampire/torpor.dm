/mob/living/human/handle_living_non_stasis_processes()
	. = ..()
	// If the Vampire enters hard-crit and isn't already in Torpor, torpor them.
	if(is_asystole() && !is_in_torpor())
		to_chat(src, SPAN_NOTICE("You slip into the death-like state of Torpor..."))

		set_stasis(1000, STASIS_TORPOR)
		set_stat(UNCONSCIOUS)
		status_flags |= FAKEDEATH
		set_status(STAT_PARA, 1000)

		addtimer(CALLBACK(src, PROC_REF(awaken_from_torpor)), 60 SECONDS, TIMER_UNIQUE)

/mob/living/human/proc/awaken_from_torpor()
	// If the Vampire is qdeleted, doesn't have a head, or doesn't have a brain, then don't revive.
	if(QDELETED(src))
		return
	if(!GET_EXTERNAL_ORGAN(src, BP_HEAD) || !GET_INTERNAL_ORGAN(src, BP_BRAIN))
		return

	revive()

	to_chat(src, SPAN_NOTICE("You awaken from Torpor!"))
	set_stasis(0, STASIS_TORPOR)
	status_flags &= ~FAKEDEATH
	set_status(STAT_PARA, 0)

/// Returns TRUE if the Vampire is currently in Torpor.
/mob/living/human/proc/is_in_torpor()
	return LAZYACCESS(stasis_sources, STASIS_TORPOR) ? TRUE : FALSE