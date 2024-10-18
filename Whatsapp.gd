extends CanvasLayer

func _on_button_pressed():
	OS.shell_open("https://wa.me/message/5YEZYGMOSTJDF1")


func _on_voltar_pressed():
	queue_free()
