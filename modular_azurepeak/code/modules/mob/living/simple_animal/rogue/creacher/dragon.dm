/mob/living/simple_animal/hostile/retaliate/rogue/dragon
	icon = 'modular/icons/mob/96x96/ratwood_dragon.dmi'
	name = "dragon"
	icon_state = "dragon"
	icon_living = "dragon"
	icon_dead = "dragon_dead"
	footstep_type = FOOTSTEP_MOB_HEAVY
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	speak_emote = list("growls")
	see_in_dark = 6
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 2,
						/obj/item/natural/hide = 2,
						/obj/item/natural/fur = 1, /obj/item/natural/bone = 4)
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 2000
	maxHealth = 2000
	melee_damage_lower = 19
	melee_damage_upper = 29
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 20
	STASTR = 20
	STASPD = 13
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 9999 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = list('sound/vo/mobs/vw/attack (1).ogg','sound/vo/mobs/vw/attack (2).ogg','sound/vo/mobs/vw/attack (3).ogg','sound/vo/mobs/vw/attack (4).ogg')
	dodgetime = 30
	aggressive = 1
//	stat_attack = UNCONSCIOUS

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/Initialize()
	. = ..()
	gender = MALE
	if(prob(33))
		gender = FEMALE
	update_icon()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/death(gibbed)
	..()
	update_icon()

/* Eyes that glow in the dark. They float over kybraxor pits at the moment.
/mob/living/simple_animal/hostile/retaliate/rogue/wolf/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		var/mutable_appearance/eye_lights = mutable_appearance(icon, "vve")
		eye_lights.plane = 19
		eye_lights.layer = 19
		add_overlay(eye_lights)*/

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/vw/aggro (1).ogg','sound/vo/mobs/vw/aggro (2).ogg')
		if("pain")
			return pick('sound/vo/mobs/vw/pain (1).ogg','sound/vo/mobs/vw/pain (2).ogg','sound/vo/mobs/vw/pain (3).ogg')
		if("death")
			return pick('sound/vo/mobs/vw/death (1).ogg','sound/vo/mobs/vw/death (2).ogg','sound/vo/mobs/vw/death (3).ogg','sound/vo/mobs/vw/death (4).ogg','sound/vo/mobs/vw/death (5).ogg')
		if("idle")
			return pick('sound/vo/mobs/vw/idle (1).ogg','sound/vo/mobs/vw/idle (2).ogg','sound/vo/mobs/vw/idle (3).ogg','sound/vo/mobs/vw/idle (4).ogg')
		if("cidle")
			return pick('sound/vo/mobs/vw/bark (1).ogg','sound/vo/mobs/vw/bark (2).ogg','sound/vo/mobs/vw/bark (3).ogg','sound/vo/mobs/vw/bark (4).ogg','sound/vo/mobs/vw/bark (5).ogg','sound/vo/mobs/vw/bark (6).ogg','sound/vo/mobs/vw/bark (7).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

