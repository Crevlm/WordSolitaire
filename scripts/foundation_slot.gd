extends PanelContainer

@onready var header_label = $Content/HeaderLabel
@onready var card_stack = $Content/CardStack

var category: String = ""

var required_count: int = 0
var current_count: int = 0
var is_complete: bool = false



func _ready():
	header_label.text = "Empty"


func _can_drop_data(position, data):
	if is_complete:
		return false
	# Empty slot only accepts category cards
	if category == "":
		return data.is_category_card
	# Filled slot accepts matching word cards
	return data.is_category_card == false and data.category == category and current_count < required_count


func _drop_data(position, data):

	# If this is a category card, turn it into the header
	if data.is_category_card:
		category = data.category
		required_count = data.required_count
		current_count = 0
		is_complete = false
		
		update_header()
		
		data.queue_free()
		return
	
	# If the pile is already complete, reject extra word cards
	if current_count >= required_count:
		return
	
	# If this is a word card, add it under the header
	data.reparent(card_stack)
	current_count += 1
	update_header()
	
	if current_count >= required_count:
		is_complete = true
		print("Category Complete: " + category)

# Updates the header to reflect x/x cards remaining to complete the stack
func update_header():
	if is_complete:
		header_label.text = "✓ " + category
	else:
		header_label.text = category + " " + str(current_count) + "/" + str(required_count)
		
# Returns true if this foundation pile can accept the word card.	
func can_accept_word_card(card):
	return card.is_category_card == false and card.category == category and current_count < required_count
	
	
# Adds a word card to the foundation pile and updates progress.
func add_word_card(card):
	if not can_accept_word_card(card):
		return

	card.reparent(card_stack)
	current_count += 1
	

	if current_count >= required_count:
		is_complete = true
		print("Category Complete: " + category)	
	update_header()
