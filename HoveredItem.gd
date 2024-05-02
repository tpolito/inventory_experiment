extends TextureRect

const sprite_sheet_texture: Texture = preload ("res://assets/spritesheet.png")

func _init() -> void:
  size = Vector2(16, 16)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  var mouse_pos = get_global_mouse_position()
  position = mouse_pos - size / 2

func set_hover_texture(atlas_cords: Vector2) -> void:
  var atlas_texture: AtlasTexture = AtlasTexture.new()
  atlas_texture.atlas = sprite_sheet_texture
  atlas_texture.region = Rect2(atlas_cords.x, atlas_cords.y, 16, 16)
  texture = atlas_texture