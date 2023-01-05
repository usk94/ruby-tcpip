class Ethernet
  # TODO: checksumを含める
  attr_reader :type, :dst_mac_addr, :src_mac_addr

  def initialze
    @type = type
    @dst_mac = dst_mac
    @src_mac = src_mac
  end
end
