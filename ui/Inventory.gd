extends Control

const ITEM_SLOT = preload ("res://ui/ItemSlot.tscn")

@export var inventory_size := 10

@onready var bag = $Bag as GridContainer

var inventory = []
var bag_inventory = []

var test_index = 3

func _ready() -> void:
  for i in range(inventory_size):
    var bag_slot = ITEM_SLOT.instantiate()
    bag.add_child(bag_slot)
    bag_inventory.append(null)
  add_item(Db.get_item_by_id(1), 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass

func add_item(item: Item, slot_index: int) -> void:
  bag_inventory[slot_index] = item
  var slot = bag.get_child(slot_index)
  slot.set_item(item)

func _unhandled_input(event: InputEvent) -> void:
  if event is InputEventKey and event.is_pressed():
    if event.keycode == KEY_SPACE:
      add_item(Db.get_item_by_id(2), test_index)