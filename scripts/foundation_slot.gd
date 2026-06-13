extends PanelContainer

@onready var header_label = $Content/HeaderLabel
@onready var card_stack = $Content/CardStack

var category: String = ""



func _ready():
	header_label.text = "Empty"

func _can_drop_data(position, data):
	# Empty slot only accepts category cards
	if category == "":
		return data.is_category_card
	# Filled slot accepts matching word cards
	return data.is_category_card == false and data.category == category

func _drop_data(position, data):
	# If this is a category card, turn it into the header
	if data.is_category_card:
		category = data.category
		header_label.text = data.word
		data.queue_free()
		return
	
	#If this is a word card, add it under the header
	data.reparent(card_stack)
