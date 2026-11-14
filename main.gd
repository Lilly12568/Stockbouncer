extends Node3D

var rng = RandomNumberGenerator.new()


var companies = {
	"tech": {
		"Pear":"PEAR",
		"Novidia":"NOIA",
		"Macrohard":"MAFT",
		"Goggle":"GGLE",
		"Smasnug":"SMSG",
		"Outel":"OUTL",
		"AND":"AND",
		"Huaiwei":"HIAW"
	},
	"shopping": {
		"Wolmart":"WMT",
		"Amazoff":"AMZF",
		"EBuy":"EBY",
		"AliBabiš":"ABS",
		"PriceCo":"PRCO",
		"Azla.cz":"AZLA",
		"Houska.cz":"HSKA",
		"Tescon":"TSCN"
	},
	"fashion": {
		"Louis Crouton":"LICN",
		"Baddidas":"BDDS",
		"Chapell":"CHPL",
		"Mike":"MKE",
		"Tuna":"TNA",
		"Over Armor":"OVAR",
		"Old Balance":"ODBL",
		"Kevin Clein":"CNKN"
	},
	"food": {
		"Burger Queen":"BGQ",
		"Four Guys":"FRGS",
		"McDaniels":"MCDS",
		"PFC":"PFC",
		"Chickpotle":"CKPL",
		"Moonbucks":"MBKS",
		"Metro":"MTR",
		"Pizza House":"PZSH",
		"Sandwich Avenue":"SWAV"
	}
}

var stories = {
	"tech": {
		"good": [
			"%c wins award for clean energy use!",
			"Engineers at %c speak out about their GREAT working conditions!",
			"%c ranked top 3 worldwide for ENERGY EFFICIENCY!",
			"%c discovers NANOBOTS!"
		],
		"random":[],
		"bad": [
			"%c batteries EXPLODING in rain!",
			"Cobalt miners STRIKE at %c",
			"%c products found OBSOLETE in three days!",
			"%c ranked #1 WORST tech company of 2026!"
		],
		"flip": []
	},
	"shopping": {
		"good": [
			"%c ranked #1 for Christmas spending!",
			"Shipments at %c slated to shipe 500% faster!",
			"10 reasons why buying at %c is all the rage!",
			"Strapped for cash? %c is the king of budget!"
		],
		"random":[],
		"bad": [
			"%c discovered shipping DRUGS OVERSEAS!",
			"Contraband found in %c shipments WORLDWIDE!",
			"New %c workforce found to be made totally of shrimp!",
			"AWFUL deals found at %c."
		],
		"flip": []
	},
	"fashion": {
		"good": [
			"You've gotta admit. %c is the new style!",
			"Every celebrity wore %c to the SAME PARTY!",
			"%c clothing shown to attract ALL THE BABES!",
			"Study shows women wearing %c have NO PERIOD CRAMPS!",
			"Want smoother skin? Wear %c, study shows!"
		],
		"random":[],
		"bad": [
			"%c is OUT. Streaking is in!",
			'"I wouldn\'t be caught dead wearing %c", critic says',
			"%c is PAST THEIR PRIME.",
			"%c clothing found filled with MITES!",
			"%c discovered using CHILD LABOUR!",
			"Feeling trendy? DON'T wear %c!",
			"%c factories set on fire WORLDWIDE!"
		],
		"flip": []
	},
	"food": {
		"good": [
			"Cancer patient eats at %c, is instantly cured!",
			"Critics LOVE the new meals at %c!",
			"Make-A-Wish kid earns lifetime supply of %c!",
			"%c rated most eco-friendly food 3rd year in a row."
		],
		"random":[],
		"bad": [
			"%c employees found SPITTING IN FOOD!",
			"%c failed EVERY HEALTH INSPECTION!",
			"%c reviewers HATE the new food!",
			"Food at %c given near 38% mortality rate!"
		],
		"flip": []
	}
}

var stocks = {}

var history = {}

var story_saved = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for cat in companies:
		for cmp in companies[cat]:
			stocks[companies[cat][cmp]] = rng.randf_range(100, 1000)
			history[companies[cat][cmp]] = [stocks[companies[cat][cmp]]]
	print(stocks)
	print(history)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	for stock in stocks:
		var add = rng.randf_range(-7.5, 7.5)
		var mvmt = ""
		if stocks[stock] + rng.randf_range(-7.5, 7.5) > 0:
			stocks[stock] += add
			if add > 0.25: mvmt = "up"
			elif add < -0.25: mvmt = "down"
			else: mvmt = "none"
		else:
			mvmt = "none"
		history[stock].append([stocks[stock], mvmt])
		if len(history[stock]) > 15:
			history[stock].pop_front()
	print(stocks)
	print(history)
	var prnt = """"""
	for stock in stocks:
		prnt += stock + ": " + str(stocks[stock]) + "\n"
	$CanvasLayer/Label.text = prnt
