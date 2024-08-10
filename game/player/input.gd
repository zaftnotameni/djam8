class_name PlayerInput extends Node

const PLAYER_INPUT_UP := "player_up"
const PLAYER_INPUT_DOWN := "player_down" 
const PLAYER_INPUT_LEFT := "player_left"
const PLAYER_INPUT_RIGHT := "player_right"

static func input_wasd_normalized(w:=PLAYER_INPUT_UP,a:=PLAYER_INPUT_LEFT,s:=PLAYER_INPUT_DOWN,d:=PLAYER_INPUT_RIGHT)->Vector2:
  return Input.get_vector(a,d,w,s)
