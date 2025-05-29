
class_name MethodTrait
extends Resource

@export var myName : String 
@export var icon : Texture2D
@export var myListOrder : int = 0
@export var prerequisiteTraits : Array[MethodTrait] = []
@export var unlockRealm : String = "Mortal"
@export_multiline var myDescription : String = ""

@export var effects : Array[TraitEffect] = []
