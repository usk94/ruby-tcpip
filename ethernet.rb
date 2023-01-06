class Ethernet
  # TODO: checksumを含める
  attr_reader :type, :dst_mac_addr, :src_mac_addr

  def initialize(type, dst_mac_addr, src_mac_addr)
    @type = type
    @dst_mac_addr = dst_mac_addr
    @src_mac_addr = src_mac_addr
  end
end

ether = Ethernet.new("ipv4", "1111", "2222")
p ether