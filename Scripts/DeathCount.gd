extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(get_node("/root/GameData").number_of_deaths).pad_zeros(2)
