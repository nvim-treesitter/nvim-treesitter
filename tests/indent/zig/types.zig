// https://github.com/nvim-treesitter/nvim-treesitter/pull/7199
const std = @import("std");

pub const Point = struct {
    x: f32,
    y: f32,
};

pub const Space = enum {
    cartesian,
    polar,
};

pub const Data = union {
    int: u32,
    float: f32,
};

pub const Opaque = opaque {
    pub fn thunk(ptr: *Opaque) void {
        std.debug.print("{}\n", .{ptr});
    }
};
