/mob/living/human/proc/get_dildo_in_either_hand()
	RETURN_TYPE(/obj/item/dildo)

	var/obj/item/dildo/dildo = locate() in get_held_items()

	if(istype(dildo))
		return dildo
