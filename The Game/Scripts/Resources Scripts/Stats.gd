extends Resource
class_name Stats

#Fundamentals
@export var lifeSpan: int = 100
@export var age: int = 18
@export var maxHP: int = 100
@export var maxEnergy: int = 50
@export var currentHP: int = 100
@export var currentEnergy: int = 50
#Physical
@export var vitality: int = 10
@export var strength: int = 10
@export var endurance: int = 10
@export var agility: int = 10
@export var constitution : int = 10
#Mental
@export var mind: int = 10
@export var intelligence: int = 10
@export var comprehension: int = 10
@export var perception: int = 10
#Spiritual
@export var spiritualSense: int = 10
@export var willpower: int = 10
@export var soulSense: int = 10
#Social
@export var charisma: int = 10
@export var insight: int = 10
@export var leadership: int = 10
#Growth & Fate
@export var potential: int = 10
@export var destiny: int = 10 
@export var luck: int = 10
#Wealth
@export var crystals : int = 100
@export var coins : int = 100

var statNames : Dictionary = {
	lifeSpan: "Lifespan",
	age : "Age",
	maxHP : "Maximum Hitpoints",
	currentHP : "Current Hitpoints",
	maxEnergy : "Maximum Energy",
	currentEnergy : "Current Energy",
	vitality : "Vitality",
	strength : "Strength",
	endurance : "Endurance",
	agility : "Agility",
	constitution : "Constitution",
	mind : "Mind",
	intelligence : "Intelligence",
	comprehension : "Comprehension",
	spiritualSense : "Spiritual Sense",
	willpower : "Willpower",
	soulSense : "Soul Sense",
	perception : "Perception",
	charisma : "Charisma",
	insight : "Insight",
	leadership : "Leadership",
	potential : "Potential",
	destiny : "Destiny",
	luck : "Luck",
	crystals : "Spiritual Crystals",
	coins : "Coins"
	
}
