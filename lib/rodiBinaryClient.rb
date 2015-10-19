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
	def self.move_left_servo(speed)
		send(53, [speed])
	end
	def self.move_right_servo(speed)
		send(54, [speed])
	end
	def self.moves_servos(left_speed , right_speed)
		send(55,[left_speed, right_speed])
	end
	def self.stop_servos
		send(55,[0,0])
	end

	# --------- TONE --------- #
	#-- this method has a problem when the frequency is greater than 100000 --#
	def self.play_tone(frequency)
		high_byte = frequency >> 8
		low_byte = frequency & 255
		send(56, [high_byte, low_byte])
	end
	def self.clear_tone
		send 57		
	end

	# --------- IR --------- #
	def self.read_both_ir
		send 1
		return read_unpack 4
	end
	def self.read_left_ir
		send 2
		return read_unpack 2
	end
	def self.read_right_ir
		send 3
		return read_unpack 2
	end

	# --------- SONAR --------- #
	def self.read_sonar
		send 4
		return (read 2).ord
	end

	private

	def self.send(command, parameters = [])
		payload = [command] + parameters
		@socket.write payload.pack('C*')
	end

	def self.read(count_bytes)
		return @socket.recv count_bytes
	end

	def self.read_unpack(count_bytes)
		return (read count_bytes).unpack('n*')
	end
end
