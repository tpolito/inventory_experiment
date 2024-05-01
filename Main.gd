extends Node2D

func _unhandled_input(event: InputEvent) -> void:
  if event is InputEventKey and event.is_pressed():
    if event.keycode == KEY_ESCAPE:
      get_tree().quit();
    if event.keycode == KEY_R:
      get_tree().reload_current_scene()
