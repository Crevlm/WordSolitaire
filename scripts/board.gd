extends Control

#Stores the currently selected card
# Null means no card is selected 

var selected_card = null

func _ready():
	print("Board Ready")
	
	for column in $MainLayout/Tableau.get_children():
		
		if column.get_child_count() == 0:
			continue
		var card = column.get_child(0)
		card.card_clicked.connect(_on_card_clicked)
	

func _on_card_clicked(card):
	if selected_card == card:
		card.set_selected(false)
		print("Deselected: " + card.word)
		selected_card = null
		return

	if selected_card != null:
		selected_card.set_selected(false)

	selected_card = card
	card.set_selected(true)
	print("Selected: " + card.word)
	
func reveal_top_card(column):
	print("Reveal check on: " + column.name)

	if column.get_child_count() == 0:
		print("Column empty")
		return

	var top_card = column.get_child(column.get_child_count() - 1)
	print("Top card is: " + top_card.word)

	if top_card.is_face_down:
		print("Revealing: " + top_card.word)
		top_card.reveal()
	else:
		print("Top card already face up")
