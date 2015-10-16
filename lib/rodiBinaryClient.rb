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

	private

	def self.send(command)
		payload = [command]
		@socket.write payload.pack('C*')
	end

end
