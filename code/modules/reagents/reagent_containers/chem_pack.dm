/obj/item/reagent_containers/chem_pack
	name = "intravenous medicine bag"
	desc = ""
	icon = 'icons/obj/bloodpack.dmi'
	icon_state = "chempack"
	volume = 100
	reagent_flags = OPENCONTAINER
	spillable = TRUE
	obj_flags = UNIQUE_RENAME
	resistance_flags = ACID_PROOF
	var/sealed = FALSE
	fill_icon_thresholds = list(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

/obj/item/reagent_containers/chem_pack/AltClick(mob/living/user)
	if(user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY) && !sealed)
		if(iscarbon(user) && (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50)))
			to_chat(user, span_warning("Uh... whoops! You accidentally spill the content of the bag onto myself."))
			SplashReagents(user)
			return

		reagents.flags = NONE
		reagent_flags = DRAWABLE | INJECTABLE //To allow for sabotage or ghetto use.
		reagents.flags = reagent_flags
		spillable = FALSE
		sealed = TRUE
		to_chat(user, span_notice("I seal the bag."))

/obj/item/reagent_containers/chem_pack/examine()
	. = ..()
	if(sealed)
		. += span_notice("The bag is sealed shut.")
	else
		. += span_notice("Alt-click to seal it.")


/obj/item/reagent_containers/chem_pack/attack_self(mob/user)
	if(sealed)
		return
	..()
