class_name WeightedTable

var items: Array[Dictionary] = []
var weightSum = 0

func addItem(item, weight: int):
	items.append({
		"item": item,
		"weight": weight
	})
	weightSum += weight


func removeItem(item):
	var found = items.filter(func(i: Dictionary): return i.item == item)
	if found == null:
		return

	items = items.filter(func(i: Dictionary): return i.item != item)
	weightSum -= found[0].weight


func updateWeight(item, weight):
	# screw it lets be lazy
	removeItem(item)
	addItem(item, weight)


func pickItem():
	var currentWeight = 0
	var randomWeight = randi_range(1, weightSum)

	for item in items:
		currentWeight += item.weight
		if randomWeight <= currentWeight:
			return item.item
