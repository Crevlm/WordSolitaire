extends Button

signal card_clicked(card)

@export var word: String = "Dog"
@export var category: String = "Animals"
@export var is_category_card: bool = false

@onready var word_label = $WordLabel

func _ready():
	word_label.text = word
func _pressed():
	if is_category_card:
		print("Category Card: " + word)
	else:
		print("Word Card: " + word)
	card_clicked.emit(self)

# Mark the currently selected card as a different color when it's selected versus not.
func set_selected(is_selected: bool):
	if is_selected:
		modulate = Color(0.75, 0.85, 1.0)
	else:
		modulate = Color(1, 1, 1)

# Prints that the current selected card is being dragged 
func _get_drag_data(position):
	print("Dragging: " + word)
	return self

func _can_drop_data(position, data):
	if data == self:
		return false
	return data.category == category
	
func _drop_data(position, data):
	print("Valid drop: " + data.word + " onto " + word)
	data.reparent(get_parent())
