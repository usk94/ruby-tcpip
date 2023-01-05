class Arp
  attr_reader :hardware_type, :protocol_type, :hardware_size, :protocol_size, :opcode, :sender_mac_addr,
              :sender_ip_addr, :target_mac_addr, :target_ip_addr
  def initialize
    @hardware_type = hardware_type
    @protocol_type = protocol_type
    @hardware_size = hardware_size
    @protocol_size = protocol_size
    @opcode = opcode
    @sender_mac_addr = sender_mac_addr
    @sender_ip_addr = sender_ip_addr
    @target_mac_addr = target_mac_addr
    @target_ip_addr = target_ip_addr
  end
end