	const_def 2 ; object constants
	const OLIVINECITY_SAILOR1
	const OLIVINECITY_STANDING_YOUNGSTER
	const OLIVINECITY_SAILOR2
	const OLIVINECITY_OLIVINE_RIVAL

OlivineCity_MapScripts:
	db 2 ; scene scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.DummyScene0:
	end

.DummyScene1:
	end

.FlyPoint:
	setflag ENGINE_FLYPOINT_OLIVINE
	return

OlivineCityRivalSceneTop:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	applymovement OLIVINECITY_OLIVINE_RIVAL, MovementData_0x1a88d2
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext OlivineCityRivalText
	waitbutton
	closetext
	;applymovement PLAYER, MovementData_0x1a88f4
	applymovement OLIVINECITY_OLIVINE_RIVAL, MovementData_0x1a88db
	turnobject PLAYER, LEFT
	applymovement OLIVINECITY_OLIVINE_RIVAL, MovementData_0x1a88db2
	setscene SCENE_FINISHED
	disappear OLIVINECITY_OLIVINE_RIVAL
	special RestartMapMusic
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_SWIMMER_GUY
	special LoadUsedSpritesGFX
	end

OlivineCityRivalSceneBottom:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	applymovement OLIVINECITY_OLIVINE_RIVAL, MovementData_0x1a88d6
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext OlivineCityRivalText
	waitbutton
	closetext
	;applymovement PLAYER, MovementData_0x1a88f7
	applymovement OLIVINECITY_OLIVINE_RIVAL, MovementData_0x1a88e8
	turnobject PLAYER, LEFT
	applymovement OLIVINECITY_OLIVINE_RIVAL, MovementData_0x1a88db2
	disappear OLIVINECITY_OLIVINE_RIVAL
	setscene SCENE_FINISHED
	special RestartMapMusic
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_SWIMMER_GUY
	special LoadUsedSpritesGFX
	end

OlivineCitySailor1Script:
	jumptextfaceplayer OlivineCitySailor1Text

OlivineCityStandingYoungsterScript:
	faceplayer
	opentext
	random 2
	ifequal 0, .FiftyFifty
	writetext OlivineCityStandingYoungsterPokegearText
	waitbutton
	closetext
	end

.FiftyFifty:
	writetext OlivineCityStandingYoungsterPokedexText
	waitbutton
	closetext
	end

OlivineCitySailor2Script:
	jumptextfaceplayer OlivineCitySailor2Text

OlivineCitySign:
	jumptext OlivineCitySignText

OlivineGymSign:
	jumptext OlivineGymSignText

OlivineLighthouseSign:
	jumptext OlivineLighthouseSignText

OlivineCityPokecenterSign:
	jumpstd pokecentersign

OlivineCityMartSign:
	jumpstd martsign

MovementData_0x1a88d2:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

MovementData_0x1a88d6:
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

MovementData_0x1a88db:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step_end

MovementData_0x1a88db2:
	step LEFT
	step LEFT
	step LEFT
	step_end

MovementData_0x1a88e8:
	step UP
	step LEFT
	step LEFT
	step LEFT
	step_end

MovementData_0x1a88f4:
	step DOWN
	turn_head UP
	step_end

MovementData_0x1a88f7:
	step UP
	turn_head DOWN
	step_end

OlivineCityRivalText:
	text "<PLAY_G>!"
	para "It's been a while!"
	para "You just got"
	line "through NIHON"
	cont "FOREST, right?"
	para "It's a tough place."
	para "But it's filled"
	line "with #MON!"
	para "I'm actually not"
	line "in the mood to"
	cont "battle right now."
	para "I'm headed back"
	line "out to the FOREST"
	para "to look for more"
	line "#MON!"
	para "Can't miss the"
	line "opportunity to"
	para "look for the"
	line "strongest #MON"
	cont "to add to my team!"
	para "This city's pretty"
	line "cool, though!"
	para "There's a GYM"
	line "LEADER that uses"
	cont "the STEEL-TYPE!"
	para "I'd never even"
	line "heard of that type"
	cont "before!"
	para "Anyways, I'm off!"
	line "See you around!"
	done

OlivineCitySailor1Text:
	text "I've always had"
	line "a dream to move"
	para "farther north"
	line "where it snows."
	done

OlivineCityStandingYoungsterPokegearText:
	text "That thing you"
	line "have--it's a #-"
	cont "GEAR, right? Wow,"
	cont "that's cool."
	done

OlivineCityStandingYoungsterPokedexText:
	text "Wow, you have a"
	line "#DEX!"

	para "That is just so"
	line "awesome."
	done

OlivineCitySailor2Text:
	text "The canal that"
	line "runs through this"
	para "city is a sight"
	line "to behold at"
	cont "sunset."
	done

OlivineCitySignText:
	text "NUTYPE CITY"

	para "A bustling city"
	line "by rough waters"
	done

OlivineGymSignText:
	text "NUTYPE CITY"
	line "#MON GYM"
	cont "LEADER: JASMINE"

	para "The Steel-Clad"
	line "Defense Girl"
	done

OlivineLighthouseSignText:
	text "FIGHTING DOJO"
	done

OlivineCity_MapEvents:
	db 0, 0 ; filler

	db 13 ; warp events
	warp_event  7,  8, OLIVINE_POKECENTER_1F, 1
	warp_event 30,  9, OLIVINE_GYM, 1
	warp_event 35, 30, OLIVINE_TIMS_HOUSE, 1
	warp_event 34, 15, FIGHTING_DOJO, 2
	warp_event 11, 28, OLIVINE_PUNISHMENT_SPEECH_HOUSE, 1
	warp_event 23, 22, OLIVINE_GOOD_ROD_HOUSE, 1
	warp_event  5, 23, OLIVINE_CAFE, 1
	warp_event  7, 14, OLIVINE_MART, 1
	warp_event 23, 13, OLIVINE_HOUSE_BETA, 1
	warp_event 18,  5, NEW_OLIVINE_GATE_WEST, 3
	warp_event 33, 15, FIGHTING_DOJO, 1
	warp_event 19,  5, NEW_OLIVINE_GATE_WEST, 4
	warp_event 31,  9, OLIVINE_GYM, 2

	db 2 ; coord events
	coord_event  2,  9, SCENE_DEFAULT, OlivineCityRivalSceneTop
	coord_event  2, 10, SCENE_DEFAULT, OlivineCityRivalSceneBottom

	db 5 ; bg events
	bg_event 30, 21, BGEVENT_READ, OlivineCitySign
	bg_event 32, 10, BGEVENT_READ, OlivineGymSign
	bg_event 30, 15, BGEVENT_READ, OlivineLighthouseSign
	bg_event  8,  8, BGEVENT_READ, OlivineCityPokecenterSign
	bg_event  8, 14, BGEVENT_READ, OlivineCityMartSign

	db 4 ; object events
	object_event 10, 31, SPRITE_JANINE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCitySailor1Script, -1
	object_event 24,  9, SPRITE_STANDING_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineCityStandingYoungsterScript, -1
	object_event 26, 25, SPRITE_FISHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCitySailor2Script, -1
	object_event  7,  8, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_OLIVINE_CITY
