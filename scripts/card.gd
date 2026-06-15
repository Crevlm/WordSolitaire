extends Button

signal card_clicked(card)

@export var word: String = "Dog"
@export var category: String = "Animals"
@export var is_category_card: bool = false
@export var required_count: int = 0
@export var is_face_down: bool = false


@onready var word_label = $WordLabel
@onready var card_back = $CardBack


func _ready():
	update_visual()
	
	
	
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
	
	if is_face_down:
		return null
	print("Dragging: " + word)
	return self

#Determines whether a dragged card can be dropped on this card
func _can_drop_data(position, data):
	if data == self:
		return false
		

	# Cards inside a foundation pile can accept drops only if the pile is not complete.
	if get_parent().name == "CardStack":
		var foundation_slot = get_parent().get_parent().get_parent()
		return foundation_slot.can_accept_word_card(data)
		
		
	return data.category == category
	
# Handles card drops in tableau and foundation piles
func _drop_data(position, data):
	print("Valid drop: " + data.word + " onto " + word)

	# If this card is inside a foundation pile,
	# let the FoundationSlot handle the drop/count.
	if get_parent().name == "CardStack":
		var foundation_slot = get_parent().get_parent().get_parent()
		foundation_slot.add_word_card(data)
		return

	# Otherwise this is normal tableau movement.
	var old_column = data.get_parent()
	data.reparent(get_parent())
	
	var board = get_tree().current_scene.reveal_top_card(old_column)
	
	
func update_visual():
	if is_face_down:
		card_back.visible = true
		word_label.visible = false
	else:
		card_back.visible = false
		word_label.visible = true
		word_label.text = word
		

func reveal():
	is_face_down = false
	update_visual()
