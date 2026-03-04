class_name MapGraph

# Настройки генерации
const levels: int = 10                   # Количество уровней глубины
const min_width: int = 2                 # Минимальное количество узлов на уровне
const max_width: int = 4                 # Максимальное количество узлов на уровне
const extra_connections_chance: float = 0.2  # Вероятность дополнительных связей

# Типы узлов
enum NodeType {
	BATTLE,
	ELITE,
	REST,
	SHOP,
	EVENT,
	BOSS
}

# Структура узла
class MapNode:
	var id: Vector2                    # Координаты (уровень, позиция)
	var type: NodeType                      # Тип из enum NodeType
	var connections: Array             # Список связанных узлов (Vector2)
	
	func _init(i: Vector2, t: NodeType):
		id = i
		type = t
		connections = []

# Генерация карты
func generate_map() -> Dictionary:
	var map_nodes = {}
	var last_level_nodes = []
	
	# Создаем узлы для каждого уровня
	for level in range(levels):
		var width = randi_range(min_width, max_width)
		
		# Особые случаи для первого и последнего уровня
		if level == 0:
			width = 1
		elif level == levels - 1:
			width = 1
		
		var current_level_nodes = []
		
		# Создаем узлы текущего уровня
		for pos in range(width):
			var node_id = Vector2(level, pos)
			var node_type = _get_node_type(level, pos, width)
			var node = MapNode.new(node_id, node_type)
			map_nodes[node_id] = node
			current_level_nodes.append(node_id)
			
			# Связываем с предыдущим уровнем
			if level > 0:
				_connect_to_previous_level(node, last_level_nodes, level)
		
		last_level_nodes = current_level_nodes
	
	# Добавляем случайные связи между несмежными уровнями
	_add_extra_connections(map_nodes)
	
	return map_nodes

# Определение типа узла
func _get_node_type(level: int, pos: int, width: int) -> NodeType:
	if level == 0:
		return NodeType.BATTLE
	elif level == levels - 1:
		return NodeType.BOSS
	
	var rand = randf()
	
	if level == levels - 2:
		if rand < 0.7: return NodeType.BATTLE
		elif rand < 0.9: return NodeType.SHOP
		else: return NodeType.REST
	
	# Распределение типов для средних уровней
	if rand < 0.5: return NodeType.BATTLE
	elif rand < 0.6: return NodeType.ELITE
	elif rand < 0.7: return NodeType.SHOP
	elif rand < 0.8: return NodeType.REST
	else: return NodeType.EVENT

# Связывание с предыдущим уровнем
func _connect_to_previous_level(node: MapNode, last_level: Array, current_level: int):
	if current_level == 1:
		# Для первого уровня связываем со всеми узлами предыдущего
		for prev_node in last_level:
			node.connections.append(prev_node)
		return
	
	# Выбираем 1-3 случайных узла с предыдущего уровня
	var connection_count = randi_range(1, min(3, last_level.size()))
	var candidates = last_level.duplicate()
	
	for i in range(connection_count):
		if candidates.is_empty():
			break
		var selected = candidates[randi() % candidates.size()]
		node.connections.append(selected)
		candidates.erase(selected)

# Добавление дополнительных связей
func _add_extra_connections(map_nodes: Dictionary):
	for node in map_nodes.values():
		if node.id.x < levels - 2 and randf() < extra_connections_chance:
			var next_level = node.id.x + 1
			var candidates = []
			
			# Ищем узлы через уровень
			for other in map_nodes.values():
				if other.id.x == next_level + 1:
					candidates.append(other.id)
			
			if not candidates.is_empty():
				var extra_target = candidates[randi() % candidates.size()]
				if not node.connections.has(extra_target):
					node.connections.append(extra_target)

# Визуализация в консоли (для отладки)
func print_map(map_nodes: Dictionary):
	for level in range(levels):
		var line = "Level " + str(level) + ": "
		for node in map_nodes.values():
			if node.id.x == level:
				line += _get_node_char(node.type) + " "
		print(line)
		
		# Печатаем связи
		if level < levels - 1:
			var conn_line = "Connections: "
			for node in map_nodes.values():
				if node.id.x == level:
					for conn in node.connections:
						conn_line += str(node.id.y) + "->" + str(conn.y) + " "
			print(conn_line)

func _get_node_char(type: NodeType) -> String:
	match type:
		NodeType.BATTLE: return "B"
		NodeType.ELITE: return "E"
		NodeType.REST: return "R"
		NodeType.SHOP: return "S"
		NodeType.EVENT: return "?"
		NodeType.BOSS: return "X"
		_: return "U"

# Дополнительная функция для получения всех узлов на определенном уровне
func get_nodes_at_level(map_nodes: Dictionary, level: int) -> Array:
	var result = []
	for node in map_nodes.values():
		if node.id.x == level:
			result.append(node)
	return result

# Функция для проверки достижимости узлов (опционально)
func validate_map(map_nodes: Dictionary) -> bool:
	# Проверяем, что все узлы достижимы из стартовой точки
	var start_node = map_nodes[Vector2(0, 0)]
	var visited = {}
	var queue = [start_node.id]
	
	while not queue.is_empty():
		var current_id = queue.pop_front()
		if visited.has(current_id):
			continue
		visited[current_id] = true
		
		var current_node = map_nodes[current_id]
		for connection in current_node.connections:
			if not visited.has(connection):
				queue.append(connection)
	
	# Проверяем, что посетили все узлы
	return visited.size() == map_nodes.size()
