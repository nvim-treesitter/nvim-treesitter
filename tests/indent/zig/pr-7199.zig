const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, world!\n", .{});
    {
        std.debug.print("All your codebase are belong to us.\n", .{});
    }
}
