/obj/item/organ/external/groin/penis
	name = "penis"
	organ_tag = BP_PENIS
	max_damage = 50
	min_broken_damage = 35
	w_class = ITEM_SIZE_SMALL
	body_part = SLOT_PENIS
	parent_organ = BP_GROIN
	joint = "base"
	amputation_point = "base"
	artery_name = "vein"
	arterial_bleed_severity = 0.3
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_CAN_BREAK | ORGAN_FLAG_CAN_DISLOCATE

	var/sheath_type = SHEATH_TYPE_NONE
	var/erect_state = ERECT_STATE_NONE
	var/penis_type = PENIS_TYPE_PLAIN
	var/penis_size = DEFAULT_PENIS_SIZE
	var/functional = TRUE

/obj/item/organ/external/groin/penis/proc/update_erect_state()
	var/oldstate = erect_state
	var/new_state = ERECT_STATE_NONE
	if(owner)
		if(!owner?.sexcon.can_use_penis())
			new_state = ERECT_STATE_NONE
		else if(owner.sexcon.arousal > 20)
			new_state = ERECT_STATE_HARD
		else if(owner.sexcon.arousal > 10)
			new_state = ERECT_STATE_PARTIAL
		else
			new_state = ERECT_STATE_NONE

	erect_state = new_state
	if(oldstate != erect_state && owner)
		owner.update_body(TRUE)

// For Garou
/obj/item/organ/external/groin/penis/knotted
	name = "knotted penis"
	penis_type = PENIS_TYPE_KNOTTED
	sheath_type = SHEATH_TYPE_NORMAL

/obj/item/organ/external/groin/penis/knotted/big
	penis_size = 3

/obj/item/organ/external/groin/vagina
	name = "vagina"
	organ_tag = BP_VAGINA
	max_damage = 50
	min_broken_damage = 35
	w_class = ITEM_SIZE_SMALL
	body_part = SLOT_VAGINA
	parent_organ = BP_GROIN
	joint = "hip"
	artery_name = "vaginal artery"
	arterial_bleed_severity = 0.3
	limb_flags = ORGAN_FLAG_CAN_BREAK

	var/pregnant = FALSE
	var/fertility = TRUE

/obj/item/organ/external/groin/vagina/proc/be_impregnated()
	if(pregnant)
		return
	if(!owner)
		return
	if(owner.stat == DEAD)
		return
	to_chat(owner, SPAN_PINK("I feel a surge of warmth in my belly, I'm definitely pregnant!"))
	pregnant = TRUE

/obj/item/organ/external/chest/breasts
	name = "breasts"
	organ_tag = BP_BREASTS
	max_damage = 50
	min_broken_damage = 35
	w_class = ITEM_SIZE_SMALL
	body_part = SLOT_BREASTS
	parent_organ = BP_CHEST
	joint = "base"
	amputation_point = "base"
	artery_name = "internal thoracic artery"
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_CAN_BREAK

	var/breast_size = DEFAULT_BREASTS_SIZE
	var/lactating = FALSE
	/// Container for milk and MILK ONLY. Do not transfer other chems here.
	var/datum/reagents/mammary_gland
	var/milk_max = 75

/obj/item/organ/external/chest/breasts/Destroy()
	. = ..()
	QDEL_NULL(mammary_gland)

/decl/material/liquid/drink/milk/breast_milk
	name = "breast milk"
	uid = "chem_drink_breastmilk"

// Below is largely borrowed from human_blood.dm
/// Initializes the mammary gland.
/obj/item/organ/external/chest/breasts/proc/make_milk()
	if(mammary_gland)
		return

	milk_max = clamp(breast_size * 100, 75, 500)
	mammary_gland = new(milk_max, src)

	if(!owner.should_have_organ(BP_BREASTS)) //We want the var for safety but we can do without the actual milk.
		return

	reset_milk()

/// Modifies milk content
/obj/item/organ/external/chest/breasts/proc/adjust_milk(amt, milk_data)
	if(!mammary_gland)
		make_milk()

	if(!owner.should_have_organ(BP_BREASTS))
		return

	if(amt)
		if(amt > 0)
			mammary_gland.add_reagent(BREAST_MILK, amt, milk_data)
		else
			mammary_gland.remove_any(abs(amt))

//Resets breast milk data
/obj/item/organ/external/chest/breasts/proc/reset_milk()
	if(!mammary_gland)
		make_milk()

	if(!owner.should_have_organ(BP_BREASTS))
		mammary_gland.clear_reagents()
		mammary_gland.maximum_volume = 0
		return

	if(mammary_gland.total_volume < milk_max)
		mammary_gland.maximum_volume = milk_max
		adjust_milk(milk_max - mammary_gland.total_volume)
	else if(mammary_gland.total_volume > milk_max)
		mammary_gland.remove_any(mammary_gland.total_volume - milk_max)
		mammary_gland.maximum_volume = milk_max

	LAZYSET(mammary_gland.reagent_data, BREAST_MILK, list(
		DATA_MILK_DONOR       = weakref(owner),
		DATA_MILK_NAME        = "breast milk",
	))