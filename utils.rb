require 'socket'

IF_NAME = "en0"

module Utils
  def get_packed_local_mac_addr
    mac_addr = Socket.getifaddrs
                .select { |ifaddr| ifaddr.name == IF_NAME && !ifaddr.addr.ipv4? &&!ifaddr.addr.ipv6? }
                .first
                .addr
                .to_sockaddr
    mac_addr[-6..-1]
  end

  def get_packed_local_ip_addr
    ip_addr = Socket.getifaddrs
                .select { |ifaddr| ifaddr.name == "en0" && ifaddr.addr.ipv4? }
                .first
                .addr
                .ip_address
    ip_addr.split(".").map { |s| [s.to_i].pack("C") }.join
  end
end
