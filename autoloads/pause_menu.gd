extends CanvasLayer

#
#	Exports
#

signal pause_changed(is_paused: bool)

#
#	Private Variables
#

var _is_paused: bool = false
var _can_pause: bool = true

#
#	Godot Functions
#

func _ready():
	set_paused(false, true)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		set_paused(not _is_paused)
		get_viewport().set_input_as_handled()
#
#	Public Functions
#

func set_paused(is_paused: bool, force: bool = false) -> void:
	if is_paused and not _can_pause and not force: return
	
	_is_paused = is_paused
	visible = is_paused
	if not _is_paused:
		$SettingsWindow.hide()

	pause_changed.emit()

func set_can_pause(can_pause: bool) -> void:
	_can_pause = can_pause

#
#	Signals
#

func _on_resume_button_pressed():
	set_paused(false)

func _on_quit_button_pressed():
	$QuitConfirmationDialog.show()

func _on_quit_confirmation_dialog_confirmed():
	get_tree().quit()


func _on_settings_button_pressed():
	$SettingsWindow.show()
