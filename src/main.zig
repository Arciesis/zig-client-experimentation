const std = @import("std");
const common = @import("common");

pub fn main() !void {
    const sock = try std.posix.socket(std.posix.AF.INET, std.posix.SOCK.DGRAM, std.posix.IPPROTO.UDP);
    defer std.posix.close(sock);

    const addr = try std.net.Address.resolveIp(common.parseArgsAsIp(), 55555);
    try std.posix.connect(sock, &addr.any, addr.getOsSockLen());

    const prt = try std.posix.send(sock, "A long Message from client to see what happens if the buffer is to short", 0);
    std.debug.print("{d}\n", .{prt});
}
