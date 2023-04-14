extends Node


func _ready():
	Au.MenuSoundPlay()

func MenuSoundPlay():
	$MenuSound.play()

func MenuSoundStop():
	$MenuSound.stop()

func WinPlay():
	$WinAudio.play()

func LosePlay():
	$LoseAudio.play()

func UiPlay():
	$Ui.play()

func PlanePlay():
	$Plane.play()
	
func _on_menu_sound_finished():
	$MenuSound.play()
