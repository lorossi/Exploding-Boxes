class_name CellFactory

extends Node

enum CellType { BASE, EXPLOSIVE, GROWTH, EXTRA_POINTS }

static var base_cell: Resource = ResourceLoader.load("res://scenes/cell/base_cell.tscn")
static var explosive_cell: Resource = ResourceLoader.load("res://scenes/cell/explosive_cell.tscn")
static var growth_cell: Resource = ResourceLoader.load("res://scenes/cell/growth_cell.tscn")
static var extra_points_cell: Resource = ResourceLoader.load(
	"res://scenes/cell/extra_points_cell.tscn"
)

static var cell_scenes = {
	CellType.BASE: base_cell,
	CellType.EXPLOSIVE: explosive_cell,
	CellType.GROWTH: growth_cell,
	CellType.EXTRA_POINTS: extra_points_cell
}


static func create_cell(cell_type: CellType) -> Cell:
	if cell_type not in cell_scenes:
		return null

	return cell_scenes[cell_type].instantiate()


static func create_base_cell() -> Cell:
	return create_cell(CellType.BASE)


static func create_random_special_cell() -> SpecialCell:
	var r = randf()
	if r < 1.0 / 3.0:
		return create_cell(CellType.EXPLOSIVE)
	if r < 2.0 / 3.0:
		return create_cell(CellType.GROWTH)

	return create_cell(CellType.EXTRA_POINTS)


static func create_random_cell(base_probability: float = 0.75) -> Cell:
	if randf() < base_probability:
		return create_base_cell()

	return create_random_special_cell()
