extends FileDialog

class TicketObject:
	var ticket_dictionary : Dictionary[String,String]
	func set_ticket(key : String, value : String):
		ticket_dictionary[key] = value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	file_selected.connect(func (path):
		var loaded_file : FileAccess = FileAccess.open(path, FileAccess.READ)
		var ticket_categories : PackedStringArray = loaded_file.get_csv_line()
		var ticket_list : Array[TicketObject]
		var next_line : PackedStringArray = loaded_file.get_csv_line()
		while not loaded_file.eof_reached():
			var new_ticket : TicketObject = TicketObject.new()
			for i in ticket_categories.size() - 1:
				new_ticket.set_ticket(ticket_categories[i], next_line[i])
			ticket_list.append(new_ticket)
			next_line = loaded_file.get_csv_line()
		for tickets in ticket_list:
			if tickets.ticket_dictionary[ticket_categories[7]] == "Open":
				print(tickets.ticket_dictionary[ticket_categories[0]])
	)
