

class_name RandomEventChoice
extends Resource

@export var choiceText : String = "Swim in the lake"
@export var nextEvent : RandomEvent = null  # Link to next event step
@export var nextEventID : String = "0-0"
@export var requirements : Dictionary = {}  # Example: {"strength": 5, "swimming": true}
@export var rewards : Dictionary = {}  # Example: {"exp": 10, "item": "Fish"}
