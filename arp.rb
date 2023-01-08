class Arp
  attr_reader :hardware_type, :protocol_type, :hardware_size, :protocol_size, :opcode, :sender_mac_addr,
              :sender_ip_addr, :target_mac_addr, :target_ip_addr
  def initialize(sender_mac_addr, sender_ip_addr, target_ip_addr)
    @hardware_type = 0x0001
    @protocol_type = 0x0800
    @hardware_size = 0x06
    @protocol_size = 0x04
    @opcode = 0x0001
    @sender_mac_addr = sender_mac_addr
    @sender_ip_addr = sender_ip_addr
    @target_mac_addr = 0x000000000000
    @target_ip_addr = target_ip_addr
  end
end

a = Arp.new(1, 1, 1)
p a