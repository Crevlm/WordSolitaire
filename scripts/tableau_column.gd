extends Control

const CARD_SPACING = 25

func update_layout():
	var y_offset = 0
	
	for card in get_children():
		card.position = Vector2(0, y_offset)
		
		if card.is_face_down:
			y_offset +=15
		else:
			y_offset += CARD_SPACING
