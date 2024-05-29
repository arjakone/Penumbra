/datum/antagonist/werewolf
	name = "Werewolf"
	roundend_category = "Werewolves"
	antagpanel_category = "Werewolf"
	job_rank = ROLE_WEREWOLF
	antag_hud_type = ANTAG_HUD_WEREWOLF
	antag_hud_name = "Werewolf"
	confess_lines = list(
		"THE BEAST INSIDE ME!", 
		"BEWARE THE BEAST!", 
		"MY LUPINE MARK!",
	)
	var/special_role = ROLE_WEREWOLF
	var/transformed
	var/transforming
	var/untransforming
	var/wolfname = "Werevolf"

/datum/antagonist/werewolf/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, M)

/datum/antagonist/werewolf/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	remove_antag_hud(antag_hud_type, M)

/datum/antagonist/werewolf/lesser
	name = "Lesser Werewolf"
	increase_votepwr = FALSE

/datum/antagonist/werewolf/lesser/roundend_report()
	return

/datum/antagonist/werewolf/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/werewolf/lesser))
		return "<span class='boldnotice'>A young lupine kin.</span>"
	if(istype(examined_datum, /datum/antagonist/werewolf))
		return "<span class='boldnotice'>An elder lupine kin.</span>"
	if(examiner.Adjacent(examined))
		if(istype(examined_datum, /datum/antagonist/vampirelord/lesser))
			if(transformed)
				return "<span class='boldwarning'>A lesser Vampire.</span>"
		if(istype(examined_datum, /datum/antagonist/vampirelord))
			if(transformed)
				return "<span class='boldwarning'>An Ancient Vampire. I must be careful!</span>"

/datum/antagonist/werewolf/on_gain()
	owner.special_role = name
	if(increase_votepwr)
		forge_werewolf_objectives()

	wolfname = "[pick(GLOB.wolf_prefixes)] [pick(GLOB.wolf_suffixes)]"
	return ..()

/datum/antagonist/werewolf/on_removal()
	if(!silent && owner.current)
		to_chat(owner.current,"<span class='danger'>I am no longer a [special_role]!</span>")
	owner.special_role = null
	return ..()

/datum/antagonist/werewolf/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/werewolf/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/werewolf/proc/forge_werewolf_objectives()
	if(!(locate(/datum/objective/escape) in objectives))
		var/datum/objective/werewolf/escape_objective = new
		escape_objective.owner = owner
		add_objective(escape_objective)
		return

/datum/antagonist/werewolf/greet()
	to_chat(owner.current, "<span class='userdanger'>Ever since that bite, I have been a [owner.special_role].</span>")
	owner.announce_objectives()
	..()

/mob/living/carbon/human/proc/werewolf_infect()
	if(!mind) return
	if(mind.has_antag_datum(/datum/antagonist/vampirelord)) return
	if(mind.has_antag_datum(/datum/antagonist/zombie)) return
	if(mind.has_antag_datum(/datum/antagonist/werewolf)) return

	//message_admins("[src] has been infected")

	var/datum/antagonist/werewolf/new_antag = new /datum/antagonist/werewolf/lesser()
	mind.add_antag_datum(new_antag)

/mob/living/carbon/human/proc/werewolf_feed(target)
	var/mob/living/carbon/human/W = target
	if(!W) return
	if(W.mind.has_antag_datum(/datum/antagonist/zombie))
		to_chat(src, "<span class='warning'>I should not feed on rotten flesh.</span>")
		return
	if(W.mind.has_antag_datum(/datum/antagonist/vampirelord))
		to_chat(src, "<span class='warning'>I should not feed on corrupted flesh.</span>")
		return
	if(W.mind.has_antag_datum(/datum/antagonist/werewolf))
		to_chat(src, "<span class='warning'>I should not feed on my kin's flesh.</span>")
		return

	to_chat(src, "<span class='warning'>I feed on succulent flesh. I feel reinvigorated.</span>")
	src.reagents.add_reagent(/datum/reagent/medicine/healthpot, 3)

/obj/item/clothing/suit/roguetown/armor/skin_armor/werewolf_skin
	slot_flags = null
	name = "werewolf's skin"
	desc = ""
	icon_state = null
	body_parts_covered = FULL_BODY
	armor = list("blunt" = 50, "slash" = 40, "stab" = 30, "bullet" = 35, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_STAB, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	sewrepair = FALSE
	max_integrity = 200

/obj/item/clothing/suit/roguetown/armor/skin_armor/dropped(mob/living/user, show_message = TRUE)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/datum/intent/simple/werewolf
	name = "claw"
	icon_state = "inchop"
	blade_class = BCLASS_CHOP
	attack_verb = list("claws", "mauls", "eviscerates")
	animname = "chop"
	hitsound = "genslash"
	penfactor = 50
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"
	miss_sound = "bluntwooshlarge"
	item_d_type = "slash"

/obj/item/rogueweapon/werewolf_claw
	name = "Werevolf's Claw"
	desc = ""
	item_state = null
	lefthand_file = null
	righthand_file = null
	icon = 'icons/roguetown/weapons/32.dmi'
	max_blade_int = 900
	max_integrity = 900
	force = 25
	block_chance = 0
	wdefense = 4
	armor_penetration = 15
	associated_skill = /datum/skill/combat/unarmed
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_BULKY
	can_parry = TRUE
	sharpness = IS_SHARP
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_MED
	possible_item_intents = list(/datum/intent/simple/werewolf)
	parrysound = list('sound/combat/parry/parrygen.ogg')
	embedding = list("embedded_pain_multiplier" = 0, "embed_chance" = 0, "embedded_fall_chance" = 0)

/obj/item/rogueweapon/werewolf_claw/right
	icon_state = "claw_r"

/obj/item/rogueweapon/werewolf_claw/left
	icon_state = "claw_l"

/obj/item/rogueweapon/werewolf_claw/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOEMBED, TRAIT_GENERIC)
