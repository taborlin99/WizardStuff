extends GridContainer

var cell = preload("res://scenes/spell_creator_ui/spell_grid_cell.tscn")
@export var wand_name = "DefaultWand"

# Called when the node enters the scene tree for the first time.
func _ready():
	var wand = WandList.wand(wand_name)
	init(wand.rows, wand.columns, wand.wand_grid)

func init(cell_rows, cell_columns, wand_grid):
	columns = cell_columns
	for x in range(cell_rows):
		for y in range(cell_columns):
			var new_cell = cell.instantiate()
			add_child(new_cell)
			var flag = wand_grid[x][y]
			new_cell.set_state(flag)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
