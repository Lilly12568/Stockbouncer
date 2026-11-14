extends Node3D

var rng = RandomNumberGenerator.new()

var counter = 0

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
	"single": {
		"tech": {
			"good": [
				"%c wins award for clean energy use! (%p %s)",
				"Engineers at %c speak out about their GREAT working conditions! (%p %s)",
				"%c ranked top 3 worldwide for ENERGY EFFICIENCY! (%p %s)",
				"%c discovers NANOBOTS! (%p %s)"
			],
			"random":[
				"Big changes at %c... What will happen?? (%p %s)",
				"New CEO takes over %c in CONTROVERSIAL decision! (%p %s)",
				"MASSIVE workforce shift at %c. Will they thrive or collapse?! (%p %s)"
			],
			"bad": [
				"%c batteries EXPLODING in rain! (%p %s)",
				"Cobalt miners STRIKE at %c (%p %s)",
				"%c products found OBSOLETE in three days! (%p %s)",
				"%c ranked #1 WORST tech company of 2026! (%p %s)"
			]
		},
		"shopping": {
			"good": [
				"%c ranked #1 for Christmas spending! (%p %s)",
				"Shipments at %c slated to shipe 500% faster! (%p %s)",
				"10 reasons why buying at %c is all the rage! (%p %s)",
				"Strapped for cash? %c is the king of budget! (%p %s)"
			],
			"random":[
				"Big changes at %c... What will happen?? (%p %s)",
				"New CEO takes over %c in CONTROVERSIAL decision! (%p %s)",
				"MASSIVE workforce shift at %c. Will they thrive or collapse?! (%p %s)"
			],
			"bad": [
				"%c discovered shipping DRUGS OVERSEAS! (%p %s)",
				"Contraband found in %c shipments WORLDWIDE! (%p %s)",
				"New %c workforce found to be made totally of shrimp! (%p %s)",
				"AWFUL deals found at %c. (%p %s)"
			]
		},
		"fashion": {
			"good": [
				"You've gotta admit. %c is the new style! (%p %s)",
				"Every celebrity wore %c to the SAME PARTY! (%p %s)",
				"%c clothing shown to attract ALL THE BABES! (%p %s)",
				"Study shows women wearing %c have NO PERIOD CRAMPS! (%p %s)",
				"Want smoother skin? Wear %c, study shows! (%p %s)"
			],
			"random":[
				"Big changes at %c... What will happen?? (%p %s)",
				"New CEO takes over %c in CONTROVERSIAL decision! (%p %s)",
				"MASSIVE workforce shift at %c. Will they thrive or collapse?! (%p %s)"
			],
			"bad": [
				"%c is OUT. Streaking is in! (%p %s)",
				'"I wouldn\'t be caught dead wearing %c", critic says (%p %s)',
				"%c is PAST THEIR PRIME. (%p %s)",
				"%c clothing found filled with MITES! (%p %s)",
				"%c discovered using CHILD LABOUR! (%p %s)",
				"Feeling trendy? DON'T wear %c! (%p %s)",
				"%c factories set on fire WORLDWIDE! (%p %s)"
			]
		},
		"food": {
			"good": [
				"Cancer patient eats at %c, is instantly cured! (%p %s)",
				"Critics LOVE the new meals at %c! (%p %s)",
				"Make-A-Wish kid earns lifetime supply of %c! (%p %s)",
				"%c rated most eco-friendly food 3rd year in a row. (%p %s)"
			],
			"random":[
				"Big changes at %c... What will happen?? (%p %s)",
				"New CEO takes over %c in CONTROVERSIAL decision! (%p %s)",
				"MASSIVE workforce shift at %c. Will they thrive or collapse?! (%p %s)"
			],
			"bad": [
				"%c employees found SPITTING IN FOOD! (%p %s)",
				"%c failed EVERY HEALTH INSPECTION! (%p %s)",
				"%c reviewers HATE the new food! (%p %s)",
				"Food at %c given near 38% mortality rate! (%p %s)"
			]
		}
	},
	"category": {
		"tech": {
			"good": [
				"CLEAN ENERGY causes tech sector to SOAR! (%p tech)"
			],
			"bad": [
				"WORLDWIDE BLACKOUT as tech sector CRACKS! (%p tech)"
			]
		},
		"shopping": {
			"good": [
				"Shopping sector BOOMS as global economy grows (%p shopping)"
			],
			"bad": [
				"GLOBAL TARRIFS cuts resources to shopping sector! (%p shopping)"
			]
		},
		"fashion": {
			"good": [
				"Fashion industry THRIVING under new child labor laws! (%p fashion)"
			],
			"bad": [
				"Fashion industry COLLAPSES under new silk costs! (%p fashion)"
			]
		},
		"food": {
			"good": [
				"Fast food sector expands RAPIDLY due to lowered food health restrictions! (%p food)"
			],
			"bad": [
				"Fast food sector PLUMMETS due to new health and safety guidelines (%p food)"
			]
		}
	}
}

var stocks = {}

var history = {}

var stories_saved = []

var stories_shown = {"saveable":[],"read":[]}

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
	var blocked_stocks = tick_stories()
	for stock in stocks:
		if stock in blocked_stocks:
			continue
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
	#print(stocks)
	#print(history)
	var prnt = """"""
	for stock in stocks:
		prnt += stock + ": " + str(stocks[stock]) + "\n"
	#print(prnt)

func tick_stories() -> Array:
	var blocked_stocks = []
	if counter >= 5:
		counter = 0
		var sngle = stories.keys()[rng.randi_range(0, len(stories)-1)]
		var cat = stories[sngle].keys()[rng.randi_range(0, len(stories[sngle])-1)]
		var company = companies[cat].keys()[rng.randi_range(0, len(companies[cat])-1)]
		var story_type = stories[sngle][cat].keys()[rng.randi_range(0, len(stories[sngle][cat])-1)]
		var percentage = 0
		if story_type == "good":
			percentage = rng.randi_range(0,15)
		elif story_type == "bad":
			percentage = rng.randi_range(-15,0)
		else:
			percentage = rng.randi_range(-15, 15)
		var story = [stories[sngle][cat][story_type][rng.randi_range(0, len(stories[sngle][cat][story_type])-1)], sngle, cat, company, percentage, 5]
		print(story)
		stories_shown["saveable"].append(story)
	else:
		counter += 1
	for stry in stories_shown["saveable"]:
		if stry[5] > 0:
			stry[5] -= 1
		else:
			stories_shown["saveable"].erase(stry)
			if stry[1] == "single":
				print(stocks[companies[stry[2]][stry[3]]])
				stocks[companies[stry[2]][stry[3]]] += stocks[companies[stry[2]][stry[3]]] * (float(stry[4]) / 100)
				print(stocks[companies[stry[2]][stry[3]]])
				blocked_stocks.append(companies[stry[2]][stry[3]])
				history[companies[stry[2]][stry[3]]].append([stocks[companies[stry[2]][stry[3]]], "up" if stry[4] > 0 else "down"])
			else:
				for stock in companies[stry[2]].values():
					print(stock + ": " + str(stocks[stock]))
					stocks[stock] += stocks[stock] * (float(stry[4]) / 100)
					print(stock + ": " + str(stocks[stock]))
					blocked_stocks.append(stock)
					history[stock].append([stocks[stock], "up" if stry[4] > 0 else "down"])
	return blocked_stocks
