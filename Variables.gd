extends Node

var rng = RandomNumberGenerator.new()

var counter = 0

var companies = {
	"tech": {
		"Pear":"ÐPEAR",
		"Novidia":"ÐNOIA",
		"Macrohard":"ÐMAFT",
		"Goggle":"ÐGGLE",
		"Smasnug":"ÐSMSG",
		"Outel":"ÐOUTL",
		"AND":"ÐAND",
		"Huaiwei":"ÐHIAW"
	},
	"shopping": {
		"Wolmart":"ÓWMT",
		"Amazoff":"ÓAMZF",
		"EBuy":"ÓEBY",
		"AliBabiš":"ÓABS",
		"PriceCo":"ÓPRCO",
		"Azla.cz":"ÓAZLA",
		"Houska.cz":"ÓHSKA",
		"Tescon":"ÓTSCN"
	},
	"fashion": {
		"Louis Crouton":"ÒLICN",
		"Baddidas":"ÒBDDS",
		"Chapell":"ÒHPL",
		"Mike":"ÒMKE",
		"Tuna":"ÒTNA",
		"Over Armor":"ÒOVAR",
		"Old Balance":"ÒODBL",
		"Kevin Clein":"ÒCNKN"
	},
	"food": {
		"Burger Queen":"ÑBGQ",
		"Four Guys":"ÑFRGS",
		"McDaniels":"ÑMCDS",
		"Chickpotle":"ÑCKPL",
		"Moonbucks":"ÑMBKS",
		"Metro":"ÑMTR",
		"Pizza House":"ÑPZSH",
		"Sandwich Avenue":"ÑSWAV"
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

var monitors = {"1": null, "2": null, "3": null, "4": null}

var unlocked = []

var price = 0

var quota = 750

var money = 500

var days = 7

func start() -> void:
	rng = RandomNumberGenerator.new()
	counter = 0
	stocks = {}
	history = {}
	stories_saved = []
	stories_shown = {"saveable":[],"read":[]}
	monitors = {"1": null, "2": null, "3": null, "4": null}
	unlocked = []
	price = 0
	quota = 750
	money = 500
	days = 7
	for cat in companies:
		for cmp in companies[cat]:
			stocks[companies[cat][cmp]] = rng.randf_range(100, 1000)
			history[companies[cat][cmp]] = [stocks[companies[cat][cmp]]]

func tick_stocks() -> void:
	var blocked_stocks = tick_stories()
	for stock in stocks:
		if stock in blocked_stocks:
			continue
		var add = rng.randf_range(-7.5, 7.5)
		var mvmt = ""
		if stocks[stock] + add > 0 and stocks[stock] + add < 2000:
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
		var sngle = stories.keys().pick_random()
		var cat = stories[sngle].keys().pick_random()
		var company = companies[cat].keys().pick_random()
		var story_type = stories[sngle][cat].keys().pick_random()
		var percentage = 0
		if story_type == "good":
			percentage = rng.randi_range(0,15)
		elif story_type == "bad":
			percentage = rng.randi_range(-15,0)
		else:
			percentage = rng.randi_range(-15, 15)
		var story = [stories[sngle][cat][story_type].pick_random(), sngle, cat, company, percentage, 5]
		print(story)
		stories_shown["saveable"].append(story)
	else:
		counter += 1
	for stry in stories_shown["saveable"]:
		if stry[5] > 0:
			stry[5] -= 1
		else:
			stories_shown["saveable"].erase(stry)
			stories_shown["read"].append(stry)
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

func tick_days() -> void:
	days -= 1

func rotate_left(event: InputEvent, monitor: String) -> void:
	if event is InputEventMouseButton and monitors[monitor] != null:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if monitors[monitor] == 0:
				get_parent().monitors[monitor] = len(get_parent().unlocked) - 1
			else:
				get_parent().monitors[monitor] -= 1

func rotate_right(event: InputEvent, monitor: String) -> void:
	if event is InputEventMouseButton and monitors[monitor] != null:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if monitors[monitor] == len(unlocked) - 1:
				monitors[monitor] = 0
			else:
				monitors[monitor] += 1

func random_path() -> Array[String]:
	var cat = companies.keys().pick_random()
	var cmp = companies[cat].keys().pick_random()
	var stck = companies[cat][cmp]
	return [cat, cmp, stck]
