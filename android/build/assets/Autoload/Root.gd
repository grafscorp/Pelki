extends Node

signal savegamesignal

var dialogue = {
	1:{
		"Name":"",
		"Text":"monologue_01",
		"Next":3,
		"description":"",
	},
	2:{
		"Name":"Shaman",
		"Text":"dialogue_01",
		"Next":4
	},
	3:{
		"Name":"",
		"Text":"monologue_02",
		"Next":0,
		"description":"",
	},
	4:{
		"Name":"Shaman",
		"Text":"dialogue_02",
		"Next":0,
		"description":"",
	},
	5:{
		"Name":"Spirit",
		"Text":"dialogue_03",
		"Next":6,
		"descpition":"",
	},
	6:{
		"Name":"",
		"Text":"dialogue_04",
		"Next":7,
		"descpition":"",
	},
	7:{
		"Name":"Spirit",
		"Text":"dialogue_05",
		"Next":0,
		"descpition":"",
	},
	8:{
		"Name":"",
		"Text":"monologue_06",
		"Next":0,
	},
	9:{
		"Name":"",
		"Text":"monologue_07",
		"Next":0
	}
}

var profileInfo = {
	"Name" : "",
	"HpPlayer" : 0,
	"EnergyPlayer":0,
}
