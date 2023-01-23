require "./ethernet"
require "./utils"
require "socket"

ARPHRD_ETHER = 1
ARPOP_REQUEST = 1
ETH_ALEN = 6
ETH_P_ARP = [0x0806].pack("S>").unpack1("S")
ETH_P_IP = 0x0800
ETH_TYPE_NUMBER_ARP = 0x0806
PACKET_BROADCAST = 1
PACKET_HOST = 0
TIMEOUT_TIME = 3
AF_PACKET = 0x11
ETH_P_ALL = [0x0003].pack('S>').unpack('S').first
SIOCGIFINDEX    = 0x8933   # bits/ioctls.h
SIOCGIFHWADDR   = 0x8927   # linux/sockios.h

class Arp
  # TODO: attr_readerいらないかも
  include Utils
  attr_reader :hardware_type, :protocol_type, :hardware_size, :protocol_size, :opcode, :sender_mac_addr,
              :sender_ip_addr, :target_mac_addr, :target_ip_addr
  def initialize(target_ip_addr)
    @hardware_type = [0x0001].pack("S>")
    @protocol_type = [0x0800].pack("S>")
    @hardware_size = [0x06].pack("C")
    @protocol_size = [0x04].pack("C")
    @opcode = [0x0001].pack("S>")
    @sender_mac_addr = get_packed_local_mac_addr
    @sender_ip_addr = get_packed_local_ip_addr
    @target_mac_addr = [0].pack("C") * 6
    @target_ip_addr = target_ip_addr.split(".").map(&:to_i).pack("C*")
  end

  def sum_data_without_address
    @hardware_type + @protocol_type + @hardware_size + @protocol_size + @opcode
  end

  def sum_address
    sum_data_without_address + @sender_mac_addr + @sender_ip_addr + @target_mac_addr + @target_ip_addr
  end

  def bind_if(socket, interface)
    # Get the system's internal interface index value
    ifreq = [ interface, '' ].pack('a16a16')
    socket.ioctl(SIOCGIFINDEX, ifreq)
    index_str = ifreq[16, 4]

    # Build our sockaddr_ll struct so we can bind to this interface. The struct
    # is defined in linux/if_packet.h and requires the interface index.
    eth_p_all_hbo = [ ETH_P_ALL ].pack('S').unpack('S>').first
    sll = [ Socket::AF_PACKET, eth_p_all_hbo, index_str ].pack('SS>a16')
    socket.bind(sll)
  end

  def send
    type = [0x0806].pack("S>")
    src_mac_addr = get_packed_local_mac_addr
    dst_mac_addr = [255].pack("C") * 6
    header = Ethernet.new(type, src_mac_addr, dst_mac_addr).header
    data = sum_data_without_address + sum_address
    request = header + data
    s = Socket.new(AF_PACKET, Socket::SOCK_RAW, ETH_P_ALL)
    # ARPはUDP通信でもTCP通信でもない？
    # client_socket_addr = Socket.pack_sockaddr_in(8863, Socket.gethostname)
    # s.bind(client_socket_addr)
    # bind_if(s)
    bind_if(s, "en0")
    res = s.send(request, 0)
    p res
  end
end

Arp.new("10.14.69.254").send
