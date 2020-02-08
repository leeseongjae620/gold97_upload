	db CHINCHOU ; 170

	db  80,  38,  33,  72,  56,  51
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC ; type
	db 190 ; catch rate
	db 90 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F25 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/chinchou/front.dimensions"
	db 0, 0, 0, 0 ; padding
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm ROLLOUT, MUD_SLAP, TOXIC, ZAP_CANNON, HIDDEN_POWER, SNORE, HYPER_BEAM, PROTECT, ENDURE, FRUSTRATION, THUNDER, RETURN, DOUBLE_TEAM, SWAGGER, SLEEP_TALK, REST, FLASH, THUNDERBOLT
	; end
