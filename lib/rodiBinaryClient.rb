require "rodiBinaryClient/version"

module RodiBinaryClient
  
	def self.connect
		@socket = TCPSocket.new(ip, port)
	end
	 
	def self.desconnect
		@socket.close
	end

	def self.ip
		return '192.168.4.1'
	end

	def self.port
		return 1234
	end
	
	# --------- LED --------- #
	def self.turn_led_on
		send 51
	end
	def self.turn_led_off
		send 52
	end

	# --------- SERVO --------- #
	def move_left_servo(speed)
		send(53, [speed])
	end
	def move_right_servo(speed)
		send(54, [speed])
	end
	def moves_servos(left_speed , right_speed)
		send(55,[left_speed, right_speed])
	end
	def stop_servos
		send(55,[0,0])
	end

	# --------- TONE --------- #
	#-- this method has a problem when the frequency is greater than 100000 --#
	def play_tone(frequency)
		high_byte = frequency >> 8
		low_byte = frequency & 255
		send(56, [high_byte, low_byte])
	end
	def clear_tone
		send 57		
	end

	private

	def send(command, parameters = [])
		payload = [command] + parameters
		@socket.write payload.pack('C*')
	end

end
