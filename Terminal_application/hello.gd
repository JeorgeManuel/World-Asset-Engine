extends TerminalApplication
extends Node

func init():
    name = "hello"
    description = "pinging google.com to test internet capability"

func run(terminal: Terminal, params: Array):
    
	var http := HTTPRequest.new()
	add_child(http)

	http.request_completed.connect(_on_response)

	http.request("https://www.google.com")


func _on_response(result, response_code, headers, body):
	print("Response code:", response_code)
