class_name AutoloadState extends Node

signal sig_game_state_changed(new_state:GameState)

enum GameState { INITIAL = 0, LOADING, TITLE, GAME, PAUSED }

var game_state : GameState = GameState.INITIAL
var game_state_stack : Array[GameState] = [GameState.INITIAL]

func mark_as_initial(): mark_as(GameState.INITIAL)
func mark_as_loading(): mark_as(GameState.LOADING)
func mark_as_title(): mark_as(GameState.TITLE)
func mark_as_game(): mark_as(GameState.GAME)
func mark_as_paused(): mark_as(GameState.PAUSED)

func push_initial(): push_as(GameState.INITIAL)
func push_loading(): push_as(GameState.LOADING)
func push_title(): push_as(GameState.TITLE)
func push_game(): push_as(GameState.GAME)
func push_paused(): push_as(GameState.PAUSED)

func pop_initial(): pop_as(GameState.INITIAL)
func pop_loading(): pop_as(GameState.LOADING)
func pop_title(): pop_as(GameState.TITLE)
func pop_game(): pop_as(GameState.GAME)
func pop_paused(): pop_as(GameState.PAUSED)

func pop_as(expected_current_state:GameState):
	if expected_current_state != game_state: return
	game_state_stack.pop_back()
	if game_state_stack.is_empty(): game_state_stack.push_back(GameState.INITIAL)
	game_state = game_state_stack[-1]
	print_verbose('game_state = %s' % GameState.find_key(game_state))
	print_verbose('game_state_stack = %s' % str(game_state_stack.map(name_of)))
	sig_game_state_changed.emit(game_state)

func push_as(new_state:GameState):
	if new_state == game_state: return
	game_state = new_state
	game_state_stack.push_back(new_state)
	print_verbose('game_state = %s' % GameState.find_key(game_state))
	print_verbose('game_state_stack = %s' % str(game_state_stack.map(name_of)))
	sig_game_state_changed.emit(game_state)

func mark_as(new_state:GameState):
	if new_state == game_state: return
	game_state = new_state
	game_state_stack = [new_state]
	print_verbose('game_state = %s' % GameState.find_key(game_state))
	print_verbose('game_state_stack = %s' % str(game_state_stack.map(name_of)))
	sig_game_state_changed.emit(game_state)

func name_of(state_id:GameState) -> String:
	return GameState.find_key(state_id)
