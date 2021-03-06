	const_def 2 ; object constants
;	const VIOLETCITY_EARL
	const VIOLETCITY_LASS
	const VIOLETCITY_SUPER_NERD
	const VIOLETCITY_GRAMPS
	const VIOLETCITY_YOUNGSTER
	const VIOLETCITY_FRUIT_TREE
	const VIOLETCITY_POKE_BALL1
	const VIOLETCITY_POKE_BALL2

VioletCity_MapScripts:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_VIOLET
	return


VioletCityLassScript:
	jumptextfaceplayer VioletCityLassText

VioletCitySuperNerdScript:
	jumptextfaceplayer VioletCitySuperNerdText

VioletCityGrampsScript:
	jumptextfaceplayer VioletCityGrampsText

VioletCityYoungsterScript:
	jumptextfaceplayer VioletCityYoungsterText

KurtsHouseSign:
	jumptext KurtsHouseSignText

VioletCitySign:
	jumptext VioletCitySignText

VioletGymSign:
	jumptext VioletGymSignText

SproutTowerSign:
	jumptext SproutTowerSignText

EarlsPokemonAcademySign:
	jumptext EarlsPokemonAcademySignText

BillsHouseSign2:
	jumptext BillsHouseSign2Text

VioletCityPokecenterSign:
	jumpstd pokecentersign

VioletCityMartSign:
	jumpstd martsign

VioletCityPPUp:
	itemball PP_UP

VioletCityRareCandy:
	itemball RARE_CANDY
	

VioletCityFruitTree:
	fruittree FRUITTREE_VIOLET_CITY

VioletCityHiddenHyperPotion:
	hiddenitem HYPER_POTION, EVENT_VIOLET_CITY_HIDDEN_HYPER_POTION
	
KurtsDoorLockedScript:
	opentext
	writetext KurtsDoorLockedText
	waitbutton
	closetext
	applymovement PLAYER, KurtsDoorLocked_Movement
	end
	
KurtsDoorLocked_Movement:
	step DOWN
	step_end

	
KurtsDoorLockedText:
	text "It's locked…"
	done

VioletCityLassText:
	text "Ghosts are rumored"
	line "to appear in"
	cont "5 FLOOR TOWER."

	para "They said normal-"
	line "type #MON moves"

	para "had no effect on"
	line "ghosts."
	done

VioletCitySuperNerdText:
	text "Hey, you're a"
	line "#MON trainer?"

	para "If you beat the"
	line "GYM LEADER here,"

	para "you'll be ready"
	line "for prime time!"
	done

VioletCityGrampsText:
	text "FALKNER, from the"
	line "OLD CITY #MON"

	para "GYM, is a fine"
	line "trainer!"

	para "His FLYING-TYPE"
	line "bird #MON are"
	para "trained to perform"
	line "in parades and"
	cont "other events."
	done

VioletCityYoungsterText:
	text "Behind me is the"
	line "5 FLOOR TOWER!"
	para "But getting to it"
	line "can be difficult"
	para "because of this"
	line "tree that's in the"
	cont "way."
	done

VioletCitySignText:
	text "OLD CITY"

	para "Timeless as the"
	line "stars above."
	done

VioletGymSignText:
	text "OLD CITY"
	line "#MON GYM"
	cont "LEADER: FALKNER"

	para "The Elegant Master"
	line "of Flying #MON"
	done

SproutTowerSignText:
	text "5 FLOOR TOWER"

	para "Experience the"
	line "Way of #MON"
	done

EarlsPokemonAcademySignText:
	text "EARL'S ART HOUSE"
	done
	
KurtsHouseSignText:
	text "KURT'S HOUSE"
	done
	
BillsHouseSign2Text:
	text "BILL'S HOUSE"
	done
	


VioletCity_MapEvents:
	db 0, 0 ; filler

	db 15 ; warp events
	warp_event  3, 26, VIOLET_MART, 1
	warp_event 26, 14, VIOLET_GYM, 1
	warp_event 27, 14, VIOLET_GYM, 2
	warp_event 10, 26, VIOLET_NICKNAME_SPEECH_HOUSE, 1
	warp_event 27, 28, VIOLET_POKECENTER_1F, 1
	warp_event 22, 26, EARLS_POKEMON_ACADEMY, 1
	warp_event 11, 17, SPROUT_TOWER_1F, 1
	warp_event 19, 31, ROUTE_31_VIOLET_GATE, 2
	warp_event 18, 31, ROUTE_31_VIOLET_GATE, 1
	warp_event  3, 31, KURTS_HOUSE, 1
	warp_event 29, 22, TEST_GARDEN, 5
	warp_event 12, 17, SPROUT_TOWER_1F, 2
	warp_event  4, 14, BILLS_HOUSE, 1
	warp_event  5, 14, BILLS_HOUSE, 2
	warp_event 30, 22, BILLS_FAMILYS_HOUSE, 1

	db 1 ; coord events
	coord_event  3, 32, SCENE_KURTS_HOUSE_LOCKED, KurtsDoorLockedScript

	db 9 ; bg events
	bg_event 20, 29, BGEVENT_READ, VioletCitySign
	bg_event 28, 16, BGEVENT_READ, VioletGymSign
	bg_event  8, 16, BGEVENT_READ, SproutTowerSign
	bg_event  8, 14, BGEVENT_READ, EarlsPokemonAcademySign
	bg_event 28, 28, BGEVENT_READ, VioletCityPokecenterSign
	bg_event  4, 26, BGEVENT_READ, VioletCityMartSign
	bg_event 22,  4, BGEVENT_ITEM, VioletCityHiddenHyperPotion
	bg_event  4, 32, BGEVENT_READ, KurtsHouseSign
	bg_event 26, 22, BGEVENT_READ, BillsHouseSign2

	db 8 ; object events
	object_event 26, 30, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletCityLassScript, -1
	object_event 24, 18, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletCitySuperNerdScript, -1
	object_event 15, 25, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletCityGrampsScript, -1
	object_event 10, 21, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletCityYoungsterScript, -1
	object_event 17, 17, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletCityFruitTree, -1
	object_event 16,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VioletCityPPUp, EVENT_VIOLET_CITY_PP_UP
	object_event 23,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VioletCityRareCandy, EVENT_VIOLET_CITY_RARE_CANDY
