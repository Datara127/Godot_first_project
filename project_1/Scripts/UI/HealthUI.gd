extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var heartUIFull = $HpFull
onready var heartUIEmpty = $HpEmpty

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 7.5

func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_hearts * 7.5

func _ready():
	self.max_hearts = EntityStats.max_health
	self.hearts = EntityStats.health
	EntityStats.connect("health_changed", self, "set_hearts")
	EntityStats.connect("max_health_changed", self, "set_max_hearts")
