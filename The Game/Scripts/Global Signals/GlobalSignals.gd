extends Node

#Item that is consumable emits this signal to give its effect to the player
signal on_give_player_ceffect(consumableEffect : ConsumableEffect)

#GameManager emits this signal to notify the CalendarBar that is should update the visualized date
signal update_date_bar(date : Array)

#Emitted by Cultivate_window (atleast for now) to send the number of days player spend in cultivation for xp adding
signal spend_time_cultivating(days:int)


#_____WINDOW VISIBILITY_____

#Any window emits to tell gameManager to manage active windows
signal gameManager_toggle_my_window(activeWindow : String)
#GameManager emits to tell Player base to toggle its window
signal toggle_base_window()
#GameManager emits to tell World view to toggle its window
signal toggle_world_window()
#GameManager emits to tell inventory to toggle its window
signal toggle_player_inventory()
#GameManager emits to tell character screen to toggle its window
signal toggle_character_screen()
#GameManager emits to tell player screen to toggle specific screen open, like inventory or character screen
signal toggle_player_screen(screen:String)




#Anyone can emit to ask GameManager to send specific manager
signal send_manager(manager:String)

#Tile_info_window emits when player presses travel button, to start traveling
signal travel_btn_pressed()

#Map emits in calculate_travel_days() to send travel days to Tile_Info_Window
signal get_travel_days_to_window(days:int)


signal game_manager_pass_days_call(days:int)

#Fot Item_Tool_Tip_Window, to make the tooltip calls
signal show_inventory_tooltip(item)
signal hide_inventory_tooltip()

#Emitted by Item when clicked, captured by inventory in player_screen
signal equip_item(item)
