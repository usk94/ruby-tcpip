require "socket"

class Ping
  ICMP_ECHOREPLY = 0 # Echo reply
  ICMP_ECHO      = 8 # Echo request
  ICMP_SUBCODE   = 0
  AF_PACKET = 0x11
  TYPE_ICMP_ECHO_REQUEST = 0x08

  # def initialize
  #   @seq = 0
  #   @bind_port = 0
  #   @bind_host = nil
  #   @data_size = 56
  #   @data = ''

  #   0.upto(@data_size){ |n| @data << (n % 256).chr }

  #   @ping_id = (Thread.current.object_id ^ Process.pid) & 0xffff
  # end

  # def to_trans_data()
  #   bynary_data =
  #     @type.to_s(2).rjust(8, "0") +
  #     @code.to_s(2).rjust(8, "0") +
  #     checksum.to_s(2).rjust(16, "0") +
  #     @id.to_s(2).rjust(16, "0") +
  #     @seq_number.to_s(2).rjust(16, "0")

  #   data_byte_arr = bynary_data.scan(/.{1,8}/)
  #   data_byte_arr.map! { |byte| byte.to_i(2).chr } # TO ASCII
  #   data_byte_arr.join + @data
  # end

  def ping
    socket = Socket.new(Socket::AF_INET, Socket::SOCK_RAW, Socket::IPPROTO_ICMP)

    socket.connect(Socket.pack_sockaddr_in(0, "8.8.8.8"))

    socket.send("hoge", 0)
  end
end

pinger = Ping.new
pinger.ping