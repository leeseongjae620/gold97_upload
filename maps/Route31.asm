	const_def 2 ; object constants
	;const ROUTE31_FISHER
	const ROUTE31_YOUNGSTER
	const ROUTE31_BUG_CATCHER
	const ROUTE31_COOLTRAINER_M
	const ROUTE31_FRUIT_TREE
	const ROUTE31_POKE_BALL1
	const ROUTE31_POKE_BALL2
	const ROUTE31_GRAMPS
	const ROUTE34_DAY_CARE_MON_1
	const ROUTE34_DAY_CARE_MON_2
	const ROUTE31_POKEFAN_M
	const ROUTE31_BUG_CATCHER_2

Route31_MapScripts:
	db 0 ; scene scripts


	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, .EggCheckCallback

.EggCheckCallback:
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .PutDayCareManOutside
	clearevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	setevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	jump .CheckMon1

.PutDayCareManOutside:
	setevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	clearevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	jump .CheckMon1

.CheckMon1:
	checkflag ENGINE_DAY_CARE_MAN_HAS_MON
	iffalse .HideMon1
	clearevent EVENT_DAY_CARE_MON_1
	jump .CheckMon2

.HideMon1:
	setevent EVENT_DAY_CARE_MON_1
	jump .CheckMon2

.CheckMon2:
	checkflag ENGINE_DAY_CARE_LADY_HAS_MON
	iffalse .HideMon2
	clearevent EVENT_DAY_CARE_MON_2
	return

.HideMon2:
	setevent EVENT_DAY_CARE_MON_2
	return

DayCareManScript_Outside:
	faceplayer
	opentext
	special DayCareManOutside
	waitbutton
	closetext
	ifequal TRUE, .end_fail
	clearflag ENGINE_DAY_CARE_MAN_HAS_EGG
	checkcode VAR_FACING
	ifequal RIGHT, .walk_around_player
	applymovement ROUTE31_GRAMPS, Route34MovementData_DayCareManWalksBackInside
	playsound SFX_ENTER_DOOR
	disappear ROUTE31_GRAMPS
.end_fail
	end

.walk_around_player
	applymovement ROUTE31_GRAMPS, Route34MovementData_DayCareManWalksBackInside_WalkAroundPlayer
	playsound SFX_ENTER_DOOR
	disappear ROUTE31_GRAMPS
	end

DayCareMon1Script:
	opentext
	special DayCareMon1
	closetext
	end

DayCareMon2Script:
	opentext
	special DayCareMon2
	closetext
	end


TrainerBugCatcherWade1:
	trainer BUG_CATCHER, WADE1, EVENT_BEAT_BUG_CATCHER_WADE, BugCatcherWade1SeenText, BugCatcherWade1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_BUG_CATCHER_WADE
	endifjustbattled
	opentext
	checkflag ENGINE_WADE
	iftrue .WadeRematch
	checkflag ENGINE_WADE_HAS_ITEM
	iftrue .WadeItem
	checkcellnum PHONE_BUG_CATCHER_WADE
	iftrue .AcceptedNumberSTD
	checkevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext BugCatcherWade1AfterText
	waitbutton
	setevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	scall .AskPhoneNumberSTD
	jump .Continue

.AskAgain:
	scall .AskAgainSTD
.Continue:
	askforphonenumber PHONE_BUG_CATCHER_WADE
	ifequal PHONE_CONTACTS_FULL, .PhoneFullSTD
	ifequal PHONE_CONTACT_REFUSED, .DeclinedNumberSTD
	trainertotext BUG_CATCHER, WADE1, MEM_BUFFER_0
	scall .RegisterNumberSTD
	jump .AcceptedNumberSTD

.WadeRematch:
	scall .RematchSTD
	winlosstext BugCatcherWade1BeatenText, 0
	copybytetovar wWadeFightCount
	ifequal 4, .Fight4
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight4:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight3
.Fight2:
	checkevent EVENT_BEAT_CHUCK
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_PRYCE
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer BUG_CATCHER, WADE1
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 1
	clearflag ENGINE_WADE
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, WADE2
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 2
	clearflag ENGINE_WADE
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, WADE3
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 3
	clearflag ENGINE_WADE
	end

.LoadFight3:
	loadtrainer BUG_CATCHER, WADE4
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 4
	clearflag ENGINE_WADE
	end

.LoadFight4:
	loadtrainer BUG_CATCHER, WADE5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WADE
	end

.WadeItem:
	scall .ItemSTD
	checkevent EVENT_WADE_HAS_BERRY
	iftrue .Berry
	checkevent EVENT_WADE_HAS_PSNCUREBERRY
	iftrue .Psncureberry
	checkevent EVENT_WADE_HAS_PRZCUREBERRY
	iftrue .Przcureberry
	checkevent EVENT_WADE_HAS_BITTER_BERRY
	iftrue .BitterBerry
.Berry:
	verbosegiveitem BERRY
	iffalse .PackFull
	jump .Done
.Psncureberry:
	verbosegiveitem PSNCUREBERRY
	iffalse .PackFull
	jump .Done
.Przcureberry:
	verbosegiveitem PRZCUREBERRY
	iffalse .PackFull
	jump .Done
.BitterBerry:
	verbosegiveitem BITTER_BERRY
	iffalse .PackFull
.Done:
	clearflag ENGINE_WADE_HAS_ITEM
	jump .AcceptedNumberSTD
.PackFull:
	jump .PackFullSTD

.AskPhoneNumberSTD:
	jumpstd asknumber1m
	end

.AskAgainSTD:
	jumpstd asknumber2m
	end

.RegisterNumberSTD:
	jumpstd registerednumberm
	end

.AcceptedNumberSTD:
	jumpstd numberacceptedm
	end

.DeclinedNumberSTD:
	jumpstd numberdeclinedm
	end

.PhoneFullSTD:
	jumpstd phonefullm
	end

.RematchSTD:
	jumpstd rematchm
	end

.ItemSTD:
	jumpstd giftm
	end

.PackFullSTD:
	jumpstd packfullm
	end


TrainerHikerAnthony:
	trainer HIKER, ANTHONY1, EVENT_BEAT_HIKER_ANTHONY, HikerAnthony2SeenText, HikerAnthony2BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_HIKER_ANTHONY
	endifjustbattled
	opentext
	checkflag ENGINE_ANTHONY
	iftrue .Rematch
	checkflag ENGINE_EEVEE_SWARM
	iftrue .Swarm
	checkcellnum PHONE_HIKER_ANTHONY
	iftrue .NumberAccepted
	checkevent EVENT_ANTHONY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext HikerAnthony2AfterText
	buttonsound
	setevent EVENT_ANTHONY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	jump .AskForPhoneNumber

.AskAgain:
	scall .AskNumber2
.AskForPhoneNumber:
	askforphonenumber PHONE_HIKER_ANTHONY
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	trainertotext HIKER, ANTHONY2, MEM_BUFFER_0
	scall .RegisteredNumber
	jump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext HikerAnthony2BeatenText, 0
	copybytetovar wAnthonyFightCount
	ifequal 4, .Fight4
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight4:
	checkevent EVENT_FAST_SHIP_CABINS_SE_SSE_GENTLEMAN
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_BEAT_ERIKA
	iftrue .LoadFight3
.Fight2:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_PRYCE
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer HIKER, ANTHONY1
	startbattle
	reloadmapafterbattle
	loadvar wAnthonyFightCount, 1
	clearflag ENGINE_ANTHONY
	end

.LoadFight1:
	loadtrainer HIKER, ANTHONY2
	startbattle
	reloadmapafterbattle
	loadvar wAnthonyFightCount, 2
	clearflag ENGINE_ANTHONY
	end

.LoadFight2:
	loadtrainer HIKER, ANTHONY3
	startbattle
	reloadmapafterbattle
	loadvar wAnthonyFightCount, 3
	clearflag ENGINE_ANTHONY
	end

.LoadFight3:
	loadtrainer HIKER, ANTHONY4
	startbattle
	reloadmapafterbattle
	loadvar wAnthonyFightCount, 4
	clearflag ENGINE_ANTHONY
	end

.LoadFight4:
	loadtrainer HIKER, ANTHONY5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ANTHONY
	end

.Swarm:
	writetext HikerAnthonyParaText
	waitbutton
	closetext
	end

.AskNumber1:
	jumpstd asknumber1m
	end

.AskNumber2:
	jumpstd asknumber2m
	end

.RegisteredNumber:
	jumpstd registerednumberm
	end

.NumberAccepted:
	jumpstd numberacceptedm
	end

.NumberDeclined:
	jumpstd numberdeclinedm
	end

.PhoneFull:
	jumpstd phonefullm
	end

.RematchStd:
	jumpstd rematchm
	end

TrainerFledglingPaulson:
	trainer FLEDGLING, PAULSON, EVENT_BEAT_FLEDGLING_PAULSON, FledglingPaulsonSeenText, FledglingPaulsonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FledglingPaulsonAfterText
	waitbutton
	closetext
	end


Route31YoungsterScript:
	jumptextfaceplayer Route31YoungsterText

Route31Sign:
	jumptext Route31SignText

DarkCaveSign:
	jumptext DarkCaveSignText

IlexSign:
	jumptext IlexSignText
	
Route31PokecenterSign:
	jumpstd pokecentersign

Route31CooltrainerMScript:
	jumptextfaceplayer Route31CooltrainerMText

Route31FruitTree:
	fruittree FRUITTREE_ROUTE_31

Route31Potion:
	itemball SUPER_POTION

Route31PokeBall:
	itemball POKE_BALL
	
Route34MovementData_DayCareManWalksBackInside:
	slow_step LEFT
	slow_step LEFT
	slow_step UP
	step_end

Route34MovementData_DayCareManWalksBackInside_WalkAroundPlayer:
	slow_step DOWN
	slow_step LEFT
	slow_step LEFT
	slow_step UP
	slow_step UP
	step_end


FledglingPaulsonSeenText:
	text "I battle right"
	line "by the #MON"
	cont "CENTER."
	para "That way it's easy"
	line "to heal after I"
	cont "lose."
	done

FledglingPaulsonBeatenText:
	text "Not again!"
	done

FledglingPaulsonAfterText:
	text "My #MON are"
	line "getting stronger,"
	cont "slowly but surely."
	done
	


Route31CooltrainerMText:
	text "Have you ever used"
	line "a #MON DAYCARE?"
	para "The friendly old"
	line "couple in that"
	para "house will raise"
	line "your #MON."
	done

BugCatcherWade1SeenText:
	text "I caught a bunch"
	line "of #MON. Let me"
	cont "battle with you!"
	done

BugCatcherWade1BeatenText:
	text "Awwwww…"
	done

BugCatcherWade1AfterText:
	text "You can catch"
	line "#MON even if"

	para "you have six with"
	line "you."

	para "If you catch one,"
	line "it'll go to your"
	cont "BOX automatically."
	done


Route31YoungsterText:
	text "I found a good"
	line "#MON in NIHON"
	cont "FOREST."

	para "I'm going to raise"
	line "it to take on"
	cont "JASMINE."

	para "She's the leader"
	line "of NUTYPE CITY's"
	cont "GYM."
	done

Route31SignText:
	text "ROUTE 106"

	para "NUTYPE CITY -"
	line "BIRDON TOWN"
	done

DarkCaveSignText:
	text "#MON DAYCARE"
	para "Let us raise your"
	line "#MON!"
	done

IlexSignText:
	text "NIHON FOREST"
	para "Entrance to the"
	line "right."
	done

HikerAnthony2SeenText:
	text "I came through the"
	line "forest, but I"

	para "still have plenty"
	line "of energy left."
	done

HikerAnthony2BeatenText:
	text "Whoa! You've got"
	line "more zip than me!"
	done

HikerAnthony2AfterText:
	text "We HIKERS are at"
	line "our best when"
	para "we're free to"
	line "explore endlessly."
	done

HikerAnthonyParaText:
	text "Hey, did you get"
	line "an EEVEE?"

	para "I caught one too."

	para "They're so fluffy!"
	done

Route31_MapEvents:
	db 0, 0 ; filler

	db 9 ; warp events
	warp_event  8,  5, NEW_ECRUTEAK_GATE_SOUTH, 3
	warp_event  9,  5, NEW_ECRUTEAK_GATE_SOUTH, 4
	warp_event 16, 12, ILEX_FOREST, 1
	warp_event 16, 13, ILEX_FOREST, 2
	warp_event 23,  8, ILEX_FOREST, 3
	warp_event 23,  9, ILEX_FOREST, 4
	warp_event 33,  5, DAY_CARE, 1
	warp_event 36,  5, DAY_CARE, 3
	warp_event  9, 10, ROUTE_32_POKECENTER_1F, 1

	db 0 ; coord events

	db 4 ; bg events
	bg_event 52,  8, BGEVENT_READ, Route31Sign
	bg_event 31,  5, BGEVENT_READ, DarkCaveSign
	bg_event 12, 12, BGEVENT_READ, IlexSign
	bg_event 10, 10, BGEVENT_READ, Route31PokecenterSign

	db 11 ; object events
	;object_event 52, 11, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route31MailRecipientScript, -1
	object_event  7, 13, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route31YoungsterScript, -1
	object_event 24,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerBugCatcherWade1, -1
	object_event 42, 12, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route31CooltrainerMScript, -1
	object_event  4, 11, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route31FruitTree, -1
	object_event 11,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route31Potion, EVENT_ROUTE_31_POTION
	object_event 33, 13, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route31PokeBall, EVENT_ROUTE_31_POKE_BALL
	object_event 38,  6, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareManScript_Outside, EVENT_DAY_CARE_MAN_ON_ROUTE_34
	object_event 40,  7, SPRITE_DAY_CARE_MON_1, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareMon1Script, EVENT_DAY_CARE_MON_1
	object_event 42,  6, SPRITE_DAY_CARE_MON_2, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareMon2Script, EVENT_DAY_CARE_MON_2
	object_event 49,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerHikerAnthony, -1
	object_event  4,  9, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerFledglingPaulson, -1
