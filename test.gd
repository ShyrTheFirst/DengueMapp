extends Node2D

const SOBRE_NOS = preload("res://sobre_nos.tscn")
#mapa
const WHATSAPP = preload("res://whatsapp.tscn")

func _on_info_pressed():
	var info = SOBRE_NOS.instantiate()
	get_parent().add_child(info)

func _on_quizz_pressed():
	get_tree().change_scene_to_file("res://quizz.tscn")

func _on_denuncia_pressed():
	var wpp = WHATSAPP.instantiate()
	get_parent().add_child(wpp)

func _on_mapa_pressed():
	OS.shell_open("https://jupyter.org/try-jupyter/notebooks/?path=DengueMapp.ipynb")

func _on_fechar_pressed():
	get_tree().quit()
