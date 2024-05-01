extends Panel
class_name item_slot

const sprite_sheet_texture: Texture = preload ("res://assets/spritesheet.png")
@onready var item_texture: TextureRect = $TextureRect as TextureRect

var item: Item = null
var mouse_inside: bool = false

func _ready() -> void:
  mouse_entered.connect(on_mouse_entered)
  mouse_exited.connect(on_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
  pass

func set_item_texture(atlas_cords: Vector2) -> void:
  var atlas_texture: AtlasTexture = AtlasTexture.new()
  atlas_texture.atlas = sprite_sheet_texture
  atlas_texture.region = Rect2(atlas_cords.x, atlas_cords.y, 16, 16)
  item_texture.texture = atlas_texture

func set_item(item_data: Item) -> void:
  self.item = item_data
  set_item_texture(item.atlas_cords)

func on_mouse_entered() -> void:
  if item != null:
    self_modulate = Color.RED
    mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func on_mouse_exited() -> void:
  self_modulate = Color.WHITE
  mouse_default_cursor_shape = Control.CURSOR_ARROW