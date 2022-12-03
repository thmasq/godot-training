extends Area2D

func _on_spike_body_entered(body):
	if body is Knight:
		body.queue_free()
	if body is Wizard:
		body.queue_free()
	if body is Boss:
		body.queue_free()
	print(body.name)
