extends Control
class_name inventory

const ITEM_SLOT = preload ("res://ui/ItemSlot.tscn")
const HOVERED_ITEM = preload ("res://HoveredItem.tscn")

@export var inventory_size := 10

@onready var bag = $Bag as GridContainer

var bag_inventory = []
var selected_item: Item = null
var selected_item_index = null

func _ready() -> void:
  for i in range(inventory_size):
    var bag_slot = ITEM_SLOT.instantiate()
    bag_slot.inventory_index = i
    bag.add_child(bag_slot)
    bag_inventory.append(null)
  add_item(Db.get_item_by_id(1), 0)
  add_item(Db.get_item_by_id(2), 3)

  SignalBus.item_clicked.connect(on_item_clicked)
  SignalBus.slot_clicked.connect(on_slot_clicked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
  pass

func add_item(item: Item, slot_index: int) -> void:
  if bag_inventory[slot_index] != null:
    printerr("Slot is already occupied")
    return
  bag_inventory[slot_index] = item
  var slot = bag.get_child(slot_index)
  slot.set_item(item)

func remove_item(slot_index: int) -> void:
  if bag_inventory[slot_index] == null:
    printerr("Slot is already empty")
    return

func swap_items(index1: int, index2: int) -> void:
  var temp = bag_inventory[index1]
  bag_inventory[index1] = bag_inventory[index2]
  bag_inventory[index2] = temp
  var slot1 = bag.get_child(index1)
  var slot2 = bag.get_child(index2)
  slot1.set_item(bag_inventory[index1])
  slot2.set_item(bag_inventory[index2])

func start_dragging(slot_index: int) -> void:
  if bag_inventory[slot_index] == null:
    return
  pass

func _unhandled_key_input(event: InputEvent) -> void:
  if event is InputEventKey and event.is_pressed():
    if event.keycode == KEY_SPACE:
      swap_items(0, 3)
    if event.keycode == KEY_ENTER:
      print(selected_item)

# TODO: This has to have a better way to do this. Would like to not use a string to find the hovered item
func on_item_clicked(item: Item, inventory_index: int) -> void:
  if selected_item == null:
    selected_item = item
    selected_item_index = inventory_index
    var hover_item = HOVERED_ITEM.instantiate()
    hover_item.set_hover_texture(item.atlas_cords)
    add_child(hover_item)
    mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
  else:
    swap_items(inventory_index, selected_item_index)
    selected_item = null
    selected_item_index = null
    get_node("HoveredItem").queue_free()

func on_slot_clicked(inventory_index: int) -> void:
  if selected_item == null:
    return
  swap_items(inventory_index, selected_item_index)
  selected_item = null
  selected_item_index = null
  get_node("HoveredItem").queue_free()