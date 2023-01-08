require 'socket'

class Utils
  def get_local_mac_and_ip_addr
    addr = Socket.getifaddrs
                 .select { |ifaddr| ifaddr.name == "en0" && !ifaddr.addr.ipv6? }
                 .map {|ifaddr| ifaddr.addr.inspect_sockaddr }
    {mac_addr: addr[0].slice(9..-2), ip_addr: addr[1]}
  end
end

a = Utils.new
p a.get_local_mac_and_ip_addr