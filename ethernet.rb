class Ethernet
  attr_reader :type, :dst_mac_addr, :src_mac_addr

  def initialize(type, src_mac_addr, dst_mac_addr)
    @type = type
    @src_mac_addr = src_mac_addr
    @dst_mac_addr = dst_mac_addr
  end
end
