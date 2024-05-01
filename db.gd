extends Node
class_name db

var items: Array[Item]

func _ready() -> void:
  var json = load_json_file("res://db.json")
  for i in json["items"]:
    var tmp = Item.new()
    tmp.id = i["id"]
    tmp.name = i["name"]
    tmp.friendly_name = i["friendly_name"]
    tmp.atlas_cords.x = i["atlas_cords"]["x"]
    tmp.atlas_cords.y = i["atlas_cords"]["y"]
    items.append(tmp)

func load_json_file(file_path: String):
  if FileAccess.file_exists(file_path):
    var data_file = FileAccess.open(file_path, FileAccess.READ)
    var parsed_result = JSON.parse_string(data_file.get_as_text())

    if parsed_result is Dictionary:
      return parsed_result
    else:
      printerr('File located at "%s" is not a valid JSON file' % file_path)
  else:
    printerr('File located at "%s" not found' % file_path)

func get_item_by_id(id: int):
  var item = items.filter(func(i): return i["id"] == id)
  if item.size() > 0:
    return item[0]
  else:
    printerr('Item with id "%s" not found' % id)
    return null
