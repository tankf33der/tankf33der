const std = @import("std");

pub fn main() !void {
    var inputs = std.ArrayList([]u8).init(std.debug.global_allocator);
    defer inputs.deinit();

    var in = try std.Buffer.initSize(std.debug.global_allocator, 1);
    defer in.deinit();

    var i: usize = 0;
    while (i < 2) {
        defer i += 1;
        std.debug.warn("Input number {}:\n", i + 1);
        try inputs.append(try std.io.readLine(&in));
    }

    var inputs_iter = inputs.iterator();

    i = 0;
    while (inputs_iter.next()) |val| {
        defer i += 1;
        const number = try std.fmt.parseInt(u32, val[0..], 10);
        std.debug.warn("\n{}: {}", i + 1, number + 1);
    }
}

