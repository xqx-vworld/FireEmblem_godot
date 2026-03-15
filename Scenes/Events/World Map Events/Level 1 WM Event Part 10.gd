extends World_Map_Event

class_name Level1_WM_Event_Part10

# New Game start
var level = "res://Scenes/Battlefield/Chapter 2.tscn"

# Eirika Start and move
#212 181
var eirika_final = Vector2(259, 234)
var eirika_initial = Vector2(212, 181)

func _init():
	# Text
	text_array = [
		"由于战争带来的动荡，一伙伙强盗与窃贼趁机在王国内制造混乱。",
		"尽管战争刚刚结束，但王国军队因遭受了惨重的损失，无力巡逻边境的村庄。",
		"特纳斯王转而派遣其女儿艾瑞卡与骑士团长塞思去调查附近的一起骚乱……"
	]
	
	# Signals needed
	WorldMapScreen.Eirika_Tween.connect("finished", Callable(self, "after_eirika_move"))
	WorldMapScreen.get_node("Message System").connect("no_more_text", Callable(self, "after_text"))
	
	# Set text position bottom
	# WorldMapScr     een.get_node("Message System").set_position(Messaging_System.TOP)
	
	# Place Fort and Castle
	#228 172 233 137 274 231
	castle_waypoints_array.append(Vector2(228, 172))
	fort_waypoints_array.append(Vector2(243, 300))
	village_waypoints_array.append(Vector2(174, 380))

func run():
	# Set Eirika's initial position
	WorldMapScreen.get_node("Eirika").position = eirika_initial
	
	# 1.5 second pause
	await get_tree().create_timer(2).timeout
	
	# Move Eirika and start text
	WorldMapScreen.get_node("Message System").start(text_array)
	WorldMapScreen.move_eirika(eirika_final, 5)

func build_map():
	# Create castle
	for c_waypoint in castle_waypoints_array:
		WorldMapScreen.place_castle_waypoint(c_waypoint)
	
	# Create fort
	for f_waypoint in fort_waypoints_array:
		WorldMapScreen.place_fort_waypoint(f_waypoint)
	
	# Villages
	for v_waypoint in village_waypoints_array:
		WorldMapScreen.place_village_waypoint(v_waypoint)

func after_text():
	await get_tree().create_timer(0.5).timeout
	SceneTransition.change_scene_to_file("res://Scenes/Chapter/Chapter Background.tscn", 0.1)
	WorldMapScreen.exit()
	await SceneTransition.scene_changed
	SceneTransition.get_tree().current_scene.start("1", "Victims of War", level, 2)
	queue_free()
