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
	
