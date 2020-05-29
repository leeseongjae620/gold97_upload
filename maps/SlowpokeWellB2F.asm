	const_def 2 ; object constants
	const SLOWPOKEB2F_SILVER
	const SLOWPOKEB2F_BLUE
	const SLOWPOKEB2F_OAK
	const SLOWPOKEB2F_ROCKET1
	const SLOWPOKEB2F_ROCKET2
	const SLOWPOKEB2F_ROCKET3
	const SLOWPOKEB2F_GYM_GUY

SlowpokeWellB2F_MapScripts:
	db 2 ; scene scripts
	scene_script .SceneSlowpoke2Rockets ; SCENE_DEFAULT
	scene_script .SceneSlowpoke2Nothing ; SCENE_SLOWPOKE2_NOTHING

	db 0 ; callbacks
	
.SceneSlowpoke2Rockets
	end
	
.SceneSlowpoke2Nothing
	end

RocketEncounterScript:
	turnobject SLOWPOKEB2F_BLUE, DOWN
	showemote EMOTE_SHOCK, SLOWPOKEB2F_BLUE, 15
	opentext
	writetext BlueProblemText
	waitbutton
	closetext
	applymovement PLAYER, TwoStepsUpMovement
	turnobject SLOWPOKEB2F_BLUE, UP
	applymovement SLOWPOKEB2F_OAK, OakStepUpMovement
	opentext
	writetext OakStopThisText
	waitbutton
	closetext
	applymovement SLOWPOKEB2F_OAK, OakStepBackMovement
	showemote EMOTE_SHOCK, SLOWPOKEB2F_ROCKET2, 15
	opentext
	writetext WeDoWhatWeWantText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, SLOWPOKEB2F_SILVER, 15
	opentext
	writetext WeAreAllTrainersText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, SLOWPOKEB2F_ROCKET3, 15
	opentext
	writetext WellSeeText
	waitbutton
	closetext
	applymovement SLOWPOKEB2F_ROCKET1, RocketWalksToBlue
	applymovement SLOWPOKEB2F_ROCKET2, RocketWalksToMe
	applymovement SLOWPOKEB2F_ROCKET3, RocketWalksToSilver
	winlosstext GruntM4SeenText, GruntM4BeatenText
	loadtrainer GRUNTM, GRUNTM_4,
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .returnfrombattle

.returnfrombattle
	opentext
	writetext RocketsPlan
	waitbutton
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	disappear SLOWPOKEB2F_ROCKET1
	disappear SLOWPOKEB2F_ROCKET2
	disappear SLOWPOKEB2F_ROCKET3
	pause 15
	special FadeInQuickly
	pause 15
	applymovement SLOWPOKEB2F_OAK, OakReadyForSpeech
	opentext
	writetext OakSpeechText
	waitbutton
	closetext
	applymovement SLOWPOKEB2F_OAK, OakLeavesMovement
	turnobject SLOWPOKEB2F_BLUE, RIGHT
	opentext
	writetext BlueOutText
	waitbutton
	closetext
	applymovement SLOWPOKEB2F_BLUE, BlueLeavesMovement
	turnobject SLOWPOKEB2F_SILVER, LEFT
	opentext
	writetext SilverOutText
	waitbutton
	closetext
	applymovement SLOWPOKEB2F_SILVER, SilverLeavesMovement
	disappear SLOWPOKEB2F_BLUE
	disappear SLOWPOKEB2F_OAK
	disappear SLOWPOKEB2F_SILVER
	setevent EVENT_RIVAL_BURNED_TOWER
	setevent EVENT_CINNABAR_ROCKS_CLEARED
	setscene SCENE_SLOWPOKE2_NOTHING
	setmapscene ELM_ENTRANCE, SCENE_ELM_ENTRANCE_NOTHING
	clearevent EVENT_EXPLODING_TRAP_21
	playmapmusic
	end

SlowpokeWellB1FNPCScript:
	end
	
OakLeavesMovement:
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end
	
SilverLeavesMovement:
	step DOWN
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end
	
BlueLeavesMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

OakReadyForSpeech:
	step UP
	step UP
	step RIGHT
	step RIGHT
	turn_head DOWN
	step_end

TwoStepsUpMovement:
	step UP
	step RIGHT
	step UP
	step_end

OakStepUpMovement:
	step UP
	step_end
	
OakStepBackMovement:
	step DOWN
	turn_head UP
	step_end
	
RocketWalksToSilver:
	step DOWN
	step DOWN
	step_end
	
RocketWalksToBlue:
	step DOWN
	step RIGHT
	step DOWN
	step_end
	
RocketWalksToMe:
	step DOWN
	step LEFT
	step DOWN
	step_end
	
OneStepUp:
	step UP
	step_end
	

SlowpokeWellB2FGymGuyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_KINGS_ROCK_IN_SLOWPOKE_WELL
	iftrue .GotKingsRock
	writetext SlowpokeWellB2FGymGuyText
	buttonsound
	verbosegiveitem KINGS_ROCK
	iffalse .NoRoom
	setevent EVENT_GOT_KINGS_ROCK_IN_SLOWPOKE_WELL
.NoRoom:
	closetext
	end

.GotKingsRock:
	writetext SlowpokeWellB2FGymGuyText_GotKingsRock
	waitbutton
	closetext
	end

SlowpokeWellB2FGymGuyText:
	text "I'm waiting to see"
	line "SLOWPOKE's moment"
	cont "of evolution."

	para "Through observa-"
	line "tion, I made a new"
	cont "discovery."

	para "A SLOWPOKE with a"
	line "KING'S ROCK often"

	para "gets bitten by a"
	line "TURBAN."

	para "Here, I'll share a"
	line "KING'S ROCK with"
	cont "you."
	done

SlowpokeWellB2FGymGuyText_GotKingsRock:
	text "I'm going to be"
	line "like SLOWPOKE."

	para "I'll wait patient-"
	line "ly, so I can see"
	cont "one evolve."
	done
	
OakSpeechText:
	text "OAK: This research"
	line "trip didn't go as"
	cont "planned…"
	para "But!"
	para "It is far more"
	line "important that we"
	para "rescued the"
	line "SLOWPOKE that live"
	para "in this WELL from"
	line "losing their TAILs"
	cont "to TEAM ROCKET."
	para "I'm going to see"
	line "if I can find any"
	para "information about"
	line "why TEAM ROCKET"
	cont "has returned."
	para "This could be bad."
	line "BLUE and I will"
	cont "return to the lab."
	para "<PLAY_G>, <RIVAL>!"
	line "You two should go"
	para "ahead and continue"
	line "your LEAGUE"
	cont "CHALLENGE."
	para "If you need me,"
	line "you know where"
	cont "I'll be."
	done
	
BlueOutText:
	text "BLUE: Thanks for"
	line "your help today,"
	cont "guys."
	done
	
SilverOutText:
	text "<RIVAL>: See ya"
	line "around, <PLAY_G>!"
	done

RocketsPlan:
	text "This doesn't"
	line "really matter."
	para "TEAM ROCKET is"
	line "already so far"
	para "along with our"
	line "plan that small"
	para "setbacks like this"
	line "mean nothing!"
	para "You'll soon see"
	line "the fruits of our"
	para "labor when all"
	line "#MON are under"
	cont "our control!"
	para "Team, retreat!"
	done

GruntM4SeenText:
	text "ARGH! Beaten by"
	line "children?"
	done

GruntM4BeatenText:
	text "Ha! Told ya!"
	done

WeDoWhatWeWantText:
	text "TEAM ROCKET will"
	line "do what it wants!"
	para "You can't stop us!"
	done
	
WeAreAllTrainersText:
	text "<RIVAL>: BLUE,"
	line "<PLAY_G>, and I"
	cont "are trainers!"
	para "We sure could stop"
	line "you!"
	para "My #MON are"
	line "stronger than"
	cont "anyone's!"
	done
	
WellSeeText:
	text "Ha!"
	para "We'll see about"
	line "that!"
	done

BlueProblemText:
	text "BLUE: <PLAY_G>!"
	line "It's a good thing"
	para "you and <RIVAL>"
	line "showed up!"
	para "We've got a"
	line "problem!"
	done

OakStopThisText:
	text "OAK: You people"
	line "are hurting these"
	cont "innocent SLOWPOKE!"
	para "It's not right to"
	line "cut their TAILs"
	para "off to sell them"
	line "for profit!"
	done

SlowpokeWellB2F_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  8, 15, SLOWPOKE_WELL_B1F, 2
	warp_event  9, 15, SLOWPOKE_WELL_B1F, 2

	db 1 ; coord events
	coord_event  9, 10, SCENE_DEFAULT, RocketEncounterScript


	db 0 ; bg events

	db 8 ; object events
	object_event 11,  8, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FNPCScript, EVENT_RIVAL_BURNED_TOWER
	object_event  9,  8, SPRITE_BLUE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FNPCScript, EVENT_RIVAL_BURNED_TOWER
	object_event  8,  8, SPRITE_OAK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FNPCScript, EVENT_RIVAL_BURNED_TOWER
	object_event  8,  5, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FNPCScript, EVENT_RIVAL_BURNED_TOWER
	object_event 12,  5, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FNPCScript, EVENT_RIVAL_BURNED_TOWER
	object_event 10,  5, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FNPCScript, EVENT_RIVAL_BURNED_TOWER
	object_event  4,  2, SPRITE_GYM_GUY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB2FGymGuyScript, EVENT_EXPLODING_TRAP_21
