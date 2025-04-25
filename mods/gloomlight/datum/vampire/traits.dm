/decl/trait/build_references()
	. = ..()
	LAZYDISTINCTADD(blocked_species, SPECIES_VAMPIRE)

/decl/trait/vampire
	abstract_type = /decl/trait/vampire

/decl/trait/vampire/build_references()
	. = ..()
	blocked_species = null
	permitted_species = list(SPECIES_VAMPIRE)