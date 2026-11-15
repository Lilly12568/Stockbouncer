extends Node

func round_to_decimal(value: float, decimal_places: int) -> float:
	var factor = pow(10.0, decimal_places)
	return round(value * factor) / factor

var rng = RandomNumberGenerator.new()

var selected = null

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
				"%c wins award for cleanㅤenergy use! (%p %s)",
				"Engineers at %c speak outㅤabout their GREAT working conditions! (%p %s)",
				"%c ranked top 3 worldwideㅤfor ENERGY EFFICIENCY! (%p %s)",
				"%c discovers NANOBOTS!ㅤ(%p %s)"
			],
			"random":[
				"Big changes at %c...ㅤWhat will happen?? (%p %s)",
				"New CEO takes over %c inㅤCONTROVERSIAL decision! (%p %s)",
				"MASSIVE workforce shift at %c.ㅤWill they thrive or collapse?! (%p %s)"
			],
			"bad": [
				"%c batteriesㅤEXPLODING in rain! (%p %s)",
				"Cobalt minersㅤSTRIKE at %c (%p %s)",
				"%c products foundㅤOBSOLETE in three days! (%p %s)",
				"%c ranked #1 WORST techㅤcompany of 2026! (%p %s)"
			]
		},
		"shopping": {
			"good": [
				"%c ranked #1 forㅤChristmas spending! (%p %s)",
				"Shipments at %c slatedㅤto shipe 500% faster! (%p %s)",
				"10 reasons why buyingㅤat %c is all the rage! (%p %s)",
				"Strapped for cash? %c isㅤthe king of budget! (%p %s)"
			],
			"random":[
				"Big changes at %c...ㅤWhat will happen?? (%p %s)",
				"New CEO takes over %c inㅤCONTROVERSIAL decision! (%p %s)",
				"MASSIVE workforce shift atㅤ%c. Will they thrive or collapse?! (%p %s)"
			],
			"bad": [
				"%c discovered shippingㅤDRUGS OVERSEAS! (%p %s)",
				"Contraband found in %cㅤshipments WORLDWIDE! (%p %s)",
				"New %c workforce foundㅤto be made totally of shrimp! (%p %s)",
				"AWFUL deals foundㅤat %c. (%p %s)"
			]
		},
		"fashion": {
			"good": [
				"You've gotta admit. %cㅤis the new style! (%p %s)",
				"Every celebrity wore %cㅤto the SAME PARTY! (%p %s)",
				"%c clothing shown to attractㅤALL THE BABES! (%p %s)",
				"Study shows women wearingㅤ%c have NO PERIOD CRAMPS! (%p %s)",
				"Want smoother skin? Wearㅤ%c, study shows! (%p %s)"
			],
			"random":[
				"Big changes at %c...ㅤWhat will happen?? (%p %s)",
				"New CEO takes over %c inㅤCONTROVERSIAL decision! (%p %s)",
				"MASSIVE workforce shift atㅤ%c. Will they thrive or collapse?! (%p %s)"
			],
			"bad": [
				"%c is OUT. Streakingㅤis in! (%p %s)",
				'"I wouldn\'t be caught deadㅤwearing %c", critic says (%p %s)',
				"%c is PAST THEIRㅤPRIME. (%p %s)",
				"%c clothing foundㅤfilled with MITES! (%p %s)",
				"%c discovered usingㅤCHILD LABOUR! (%p %s)",
				"Feeling trendy?ㅤDON'T wear %c! (%p %s)",
				"%c factories set onㅤfire WORLDWIDE! (%p %s)"
			]
		},
		"food": {
			"good": [
				"Cancer patient eats atㅤ%c, is instantly cured! (%p %s)",
				"Critics LOVE the newㅤmeals at %c! (%p %s)",
				"Make-A-Wish kid earnsㅤlifetime supply of %c! (%p %s)",
				"%c rated most eco-friendlyㅤfood 3rd year in a row. (%p %s)"
			],
			"random":[
				"Big changes at %c...ㅤWhat will happen?? (%p %s)",
				"New CEO takes over %c inㅤCONTROVERSIAL decision! (%p %s)",
				"MASSIVE workforce shift atㅤ%c. Will they thrive or collapse?! (%p %s)"
			],
			"bad": [
				"%c employees foundㅤSPITTING IN FOOD! (%p %s)",
				"%c failed EVERYㅤHEALTH INSPECTION! (%p %s)",
				"%c reviewers HATE theㅤnew food! (%p %s)",
				"Food at %c given nearㅤ38% mortality rate! (%p %s)"
			]
		}
	},
	"category": {
		"tech": {
			"good": [
				"CLEAN ENERGY causes techㅤsector to SOAR! (%p tech)"
			],
			"bad": [
				"WORLDWIDE BLACKOUT asㅤtech sector CRACKS! (%p tech)"
			]
		},
		"shopping": {
			"good": [
				"Shopping sector BOOMS as globalㅤeconomy grows (%p shopping)"
			],
			"bad": [
				"GLOBAL TARRIFS cuts resourcesㅤto shopping sector! (%p shopping)"
			]
		},
		"fashion": {
			"good": [
				"Fashion industry THRIVING underㅤnew child labor laws! (%p fashion)"
			],
			"bad": [
				"Fashion industry COLLAPSES underㅤnew silk costs! (%p fashion)"
			]
		},
		"food": {
			"good": [
				"Fast food sector expands RAPIDLY due toㅤlowered food health restrictions! (%p food)"
			],
			"bad": [
				"Fast food sector PLUMMETS due to newㅤhealth and safety guidelines (%p food)"
			]
		}
	}
}

var stocks = {}

var history = {}

var stories_saved = {"1":null, "2":null, "3":null}
var monitors = {"1": null, "2": null, "3": null, "4": null}
var stories_shown = {"1":null, "2":null, "3":null, "4":null, "5":null, "6":null}

var unlocked = []

var price = 0

var quota = 750

var money = 500

var days = 7

var playing = false

var inventory = {}

var bought_in = {}

func start(force: bool= false) -> void:
	if not playing or force:
		rng = RandomNumberGenerator.new()
		counter = 0
		stocks = {}
		history = {}
		stories_saved = {"1":null, "2":null, "3":null}
		stories_shown = {"1":null, "2":null, "3":null, "4":null, "5":null, "6":null}
		monitors = {"1": null, "2": null, "3": null, "4": null}
		unlocked = []
		price = 0
		quota = 750
		money = 500
		days = 7
		inventory = {}
		bought_in = {}
		for cat in companies:
			for cmp in companies[cat]:
				inventory[companies[cat][cmp]] = 0
				bought_in[companies[cat][cmp]] = 0
				stocks[companies[cat][cmp]] = round_to_decimal(rng.randf_range(100, 1000), 2)
				history[companies[cat][cmp]] = [[stocks[companies[cat][cmp]], "none"]]

func tick_stocks() -> void:
	var blocked_stocks = tick_stories()
	for stock in stocks:
		if stock in blocked_stocks:
			continue
		var add = round_to_decimal(rng.randf_range(-7.5, 7.5), 2)
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
		var story = [stories[sngle][cat][story_type].pick_random(), sngle, cat, company, percentage, 15]
		stories_shown["6"] = stories_shown["5"]
		stories_shown["5"] = stories_shown["4"]
		stories_shown["4"] = stories_shown["3"]
		stories_shown["3"] = stories_shown["2"]
		stories_shown["2"] = stories_shown["1"]
		stories_shown["1"] = story
	else:
		counter += 1
	for stry in stories_shown:
		if stories_shown[stry] == null:
			continue
		stry = stories_shown[stry]
		if stry[5] == 0:
			if stry[1] == "single":
				stocks[companies[stry[2]][stry[3]]] += stocks[companies[stry[2]][stry[3]]] * (float(stry[4]) / 100)
				stocks[companies[stry[2]][stry[3]]] = round_to_decimal(stocks[companies[stry[2]][stry[3]]], 2)
				print(stocks[companies[stry[2]][stry[3]]])
				blocked_stocks.append(companies[stry[2]][stry[3]])
				history[companies[stry[2]][stry[3]]].append([stocks[companies[stry[2]][stry[3]]], "up" if stry[4] > 0 else "down"])
			else:
				for stock in companies[stry[2]].values():
					print(stock + ": " + str(stocks[stock]))
					stocks[stock] += stocks[stock] * (float(stry[4]) / 100)
					stocks[stock] = round_to_decimal(stocks[stock], 2)
					print(stock + ": " + str(stocks[stock]))
					blocked_stocks.append(stock)
					history[stock].append([stocks[stock], "up" if stry[4] > 0 else "down"])
		stry[5] -= 1
		stories_shown[stry] = stry
	return blocked_stocks

func tick_days() -> void:
	days -= 1
	if days <= 0:
		get_tree().change_scene_to_file("res://quota_scene.tscn")

func rotate_left(event: InputEvent, monitor: String) -> void:
	if event is InputEventMouseButton and monitors[monitor] != null:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if monitors[monitor] == 0:
				monitors[monitor] = len(unlocked) - 1
			else:
				monitors[monitor] -= 1

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

func buy_stock(stock: String) -> void:
	var amount = 0.1
	var value = stocks[stock] * amount
	if stock in stocks and amount > 0 and value <= money:
		money -= round_to_decimal(value, 2)
		inventory[stock] += amount
		bought_in[stock] += round_to_decimal(value, 2)


func sell_stock(stock: String) -> void:
	var amount = 0.1
	var value = stocks[stock] * amount
	if stock in stocks and amount > 0 and inventory[stock] >= amount:
		inventory[stock] -= amount
		money += round_to_decimal(value, 2)
		bought_in[stock] -= round_to_decimal(value, 2)

func steal_news(news: String) -> void:
	if stories_saved["1"] == null:
		stories_saved["1"] = stories_shown[news]
		stories_shown[news] = null
	elif stories_saved["2"] == null:
		stories_saved["2"] = stories_shown[news]
		stories_shown[news] = null
	elif stories_saved["3"] == null:
		stories_saved["3"] = stories_shown[news]
		stories_shown[news] = null

func push_news(news: String) -> void:
	var e = stories_saved[news]
	e[5] = 0
	if stories_shown["1"] == null:
		stories_shown["1"] = e
		stories_saved[news] = null
	else:
		stories_shown["6"] = stories_shown["5"]
		stories_shown["5"] = stories_shown["4"]
		stories_shown["4"] = stories_shown["3"]
		stories_shown["3"] = stories_shown["2"]
		stories_shown["2"] = stories_shown["1"]
		stories_shown["1"] = e
		stories_saved[news] = null
