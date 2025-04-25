// WoD splats
#define SPECIES_VAMPIRE "Vampire"
#define SPECIES_GAROU   "Garou"

#define BODY_EQUIP_FLAG_VAMPIRE BITFLAG(13)
#define BODY_EQUIP_FLAG_GAROU   BITFLAG(14)

#define STASIS_TORPOR "torpor"

/decl/modpack/gloomlight
	name = "Gloomlight - Dark Ages V20 Content"

/mob/living/human/vampire/Initialize(mapload, species_name, datum/mob_snapshot/supplied_appearance)
	species_name = SPECIES_VAMPIRE
	. = ..()