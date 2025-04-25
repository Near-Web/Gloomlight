/decl/blood_type/vampire_vitae
	name = "vitae"
	antigen_category = "vampire"
	antigens = list("Vi")
	splatter_name = "vitae"
	splatter_desc = "A puddle of blood-like substance."
	splatter_colour = COLOR_BLOOD_HUMAN

// TODO: Use FAKEDEATH to replicate vampire's being undead.
/decl/species/human/vampire
	name = SPECIES_VAMPIRE
	name_plural = "Vampires"
	primitive_form = SPECIES_MONKEY
	description = "The cursed descendants of Caine."
	hidden_from_codex = TRUE
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_NO_ROBOTIC_INTERNAL_ORGANS

	available_bodytypes = list(
		/decl/bodytype/human/vampire,
		/decl/bodytype/human/masculine/vampire,
	)

	body_temperature = null // Vampires are undead.

	blood_types = list(/decl/blood_type/vampire_vitae)

	burn_mod = 1.5
	exertion_effect_chance = 10
	exertion_hydration_scale = 1
	exertion_charge_scale = 1
	exertion_reagent_scale = 1
	exertion_reagent_path = /decl/material/liquid/lactate
	exertion_emotes_biological = list(
		/decl/emote/exertion/biological,
		/decl/emote/exertion/biological/breath,
		/decl/emote/exertion/biological/pant
	)

	unarmed_attacks = list(
		/decl/natural_attack/stomp,
		/decl/natural_attack/kick,
		/decl/natural_attack/punch,
		/decl/natural_attack/bite/sharp
	)

/decl/species/human/vampire/get_root_species_name(var/mob/living/human/H)
	return SPECIES_HUMAN

/decl/species/human/vampire/get_ssd(var/mob/living/human/H)
	if(H.stat == CONSCIOUS)
		return "staring blankly, not reacting to your presence"
	return ..()

/decl/species/human/vampire/equip_default_fallback_uniform(var/mob/living/human/H)
	if(istype(H))
		H.equip_to_slot_or_del(new /obj/item/clothing/jumpsuit/grey, slot_w_uniform_str)
