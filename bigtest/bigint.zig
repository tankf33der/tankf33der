const warn = std.debug.warn;
const std = @import("std");
const big = @import("std").math.big.int.initSet;

pub fn main() void {
   var buffer: [64 * 8192]u8 = undefined;
   var fixed = std.heap.FixedBufferAllocator.init(buffer[0..]);
   const al = &fixed.allocator;

   var a = try big(al, 0x123);
   
   warn("Mike\n");
}

