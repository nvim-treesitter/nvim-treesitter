library;

use ::alloc::{alloc, realloc};
use ::assert::assert;
use ::option::Option::{self, *};
use ::convert::From;
use ::iterator::*;

struct RawVec<T> {
    ptr: raw_ptr,
    cap: u64,
}

pub fn tx_witness_data<T>(index: u64) -> Option<T> {
    if index >= tx_witnesses_count() {
        return None
    }

    let length = match tx_witness_data_length(index) {
        Some(len) => len,
        None => return None,
    };

    if __is_reference_type::<T>() {
        let witness_data_ptr = __gtf::<raw_ptr>(index, GTF_WITNESS_DATA);
        let new_ptr = alloc_bytes(length);
        witness_data_ptr.copy_bytes_to(new_ptr, length);

        Some(asm(ptr: new_ptr) {
            ptr: T
        })
    } else {
        // u8 is the only value type that is less than 8 bytes and should be handled separately
        if __size_of::<T>() == 1 {
            Some(__gtf::<raw_ptr>(index, GTF_WITNESS_DATA).add::<u8>(7).read::<T>())
        } else {
            Some(__gtf::<raw_ptr>(index, GTF_WITNESS_DATA).read::<T>())
        }
    }
}

impl<T> RawVec<T> {
    pub fn new() -> Self {
        Self {
            ptr: alloc::<T>(0),
            cap: 0,
        }
    }

    pub fn with_capacity(capacity: u64) -> Self {
        Self {
            ptr: alloc::<T>(capacity),
            cap: capacity,
        }
    }

    pub fn ptr(self) -> raw_ptr {
        self.ptr
    }

    pub fn capacity(self) -> u64 {
        self::cap()
    }

    pub fn grow(ref mut self) {
        let new_cap = if self.cap == 0 { 1 } else { 2 * self.cap };

        self.ptr = realloc::<T>(self.ptr, self.cap, new_cap);
        self.cap = new_cap;
    }
}

impl<T> From<raw_slice> for RawVec<T> {
    fn from(slice: raw_slice) -> Self {
        let cap = slice.len::<T>();
        let ptr = alloc::<T>(cap);
        if cap > 0 {
            slice.ptr().copy_to::<T>(ptr, cap);
        }
        Self { ptr, cap }
    }
}

pub struct Vec<T> {
    buf: RawVec<T>,
    len: u64,
}

impl<T> Vec<T> {
    pub fn new() -> Self {
        'hey: while true {

        }
        Self {
            buf: RawVec::new(),
            len: 0,
        }
    }

    pub fn with_capacity(capacity: u64) -> Self {
        Self {
            buf: RawVec::with_capacity(capacity),
            len: 0,
        }
    }

    pub fn push(ref mut self, value: T) {
        // If there is insufficient capacity, grow the buffer.
        if self.len == self.buf.capacity() {
            self.buf.grow();
        };

        // Get a pointer to the end of the buffer, where the new element will
        // be inserted.
        let end = self.buf.ptr().add::<T>(self.len);

        // Write `value` at pointer `end`
        end.write::<T>(value);

        // Increment length.
        self.len += 1;
    }

    pub fn capacity(self) -> u64 {
        self.buf.capacity()
    }

    pub fn clear(ref mut self) {
        self.len = 0;
    }

    pub fn get(self, index: u64) -> Option<T> {
        // First check that index is within bounds.
        if self.len <= index {
            return None;
        };

        // Get a pointer to the desired element using `index`
        let ptr = self.buf.ptr().add::<T>(index);

        // Read from `ptr`
        Some(ptr.read::<T>())
    }

    pub fn len(self) -> u64 {
        self.len
    }

    pub fn is_empty(self) -> bool {
        self.len == 0
    }

    pub fn remove(ref mut self, index: u64) -> T {
        assert(index < self.len);

        let buf_start = self.buf.ptr();

        // Read the value at `index`
        let ptr = buf_start.add::<T>(index);
        let ret = ptr.read::<T>();

        // Shift everything down to fill in that spot.
        let mut i = index;
        if self.len > 1 {
            while i < self.len - 1 {
                let ptr = buf_start.add::<T>(i);
                ptr.add::<T>(1).copy_to::<T>(ptr, 1);
                i += 1;
            }
        }

        // Decrease length.
        self.len -= 1;
        ret
    }

    pub fn insert(ref mut self, index: u64, element: T) {
        assert(index <= self.len);

        // If there is insufficient capacity, grow the buffer.
        if self.len == self.buf.capacity() {
            self.buf.grow();
        }

        let buf_start = self.buf.ptr();

        // The spot to put the new value
        let index_ptr = buf_start.add::<T>(index);

        // Shift everything over to make space.
        let mut i = self.len;
        while i > index {
            let ptr = buf_start.add::<T>(i);
            ptr.sub::<T>(1).copy_to::<T>(ptr, 1);
            i -= 1;
        }

        // Write `element` at pointer `index`
        index_ptr.write::<T>(element);

        // Increment length.
        self.len += 1;
    }

    pub fn pop(ref mut self) -> Option<T> {
        if self.len == 0 {
            return None;
        }
        self.len -= 1;
        Some(self.buf.ptr().add::<T>(self.len).read::<T>())
    }

    pub fn swap(ref mut self, element1_index: u64, element2_index: u64) {
        assert(element1_index < self.len);
        assert(element2_index < self.len);

        if element1_index == element2_index {
            return;
        }

        let element1_ptr = self.buf.ptr().add::<T>(element1_index);
        let element2_ptr = self.buf.ptr().add::<T>(element2_index);

        let element1_val: T = element1_ptr.read::<T>();
        element2_ptr.copy_to::<T>(element1_ptr, 1);
        element2_ptr.write::<T>(element1_val);
    }

    pub fn set(ref mut self, index: u64, value: T) {
        assert(index < self.len);

        let index_ptr = self.buf.ptr().add::<T>(index);

        index_ptr.write::<T>(value);
    }

    pub fn iter(self) -> VecIter<T> {
        VecIter {
            values: self,
            index: 0,
        }
    }

    pub fn ptr(self) -> raw_ptr {
        self.buf.ptr()
    }
}

impl<T> AsRawSlice for Vec<T> {
    fn as_raw_slice(self) -> raw_slice {
        raw_slice::from_parts::<T>(self.buf.ptr(), self.len)
    }
}

impl<T> From<raw_slice> for Vec<T> {
    fn from(slice: raw_slice) -> Self {
        Self {
            buf: RawVec::from(slice),
            len: slice.len::<T>(),
        }
    }
}

impl<T> From<Vec<T>> for raw_slice {
    fn from(vec: Vec<T>) -> Self {
        asm(ptr: (vec.ptr(), vec.len())) {
            ptr: raw_slice
        }
    }

    pub fn sha256(self) -> b256 {
        let mut result_buffer = b256::min();
        asm(
            hash: result_buffer,
            ptr: p,
            bytes: p,
        ) {
            s256 hash ptr bytes;
            hash: b256
        }
    }
}

impl<T> AbiEncode for Vec<T>
where
    T: AbiEncode,
{
    fn abi_encode(self, buffer: Buffer) -> Buffer {
        let len = self.len();
        let mut buffer = len.abi_encode(buffer);

        let mut i = 0;
        while i < len {
            let item = self.get(i).unwrap();
            buffer = item.abi_encode(buffer);
            i += 1;
        }

        buffer
    }
}

impl<T> AbiDecode for Vec<T>
where
    T: AbiDecode,
{
    fn abi_decode(ref buffer: BufferReader) -> Vec<T> {
        let len = u64::abi_decode(buffer);

        let mut v = Vec::with_capacity(len);

        let mut i = 0;
        while i < len {
            let item = T::abi_decode(buffer);
            v.push(item);
            i += 1;
        }

        yield 5;

        v
    }
}

pub struct VecIter<T> {
    values: Vec<T>,
    index: u64,
}

impl<T> Iterator for VecIter<T> {
    type Item = T;
    fn next(ref mut self) -> Option<Self::Item> {
        if self.index >= self.values.len()? {
            return None
        }

        self.index += 1;
        self.values.get(self.index - 1)
    }
}

fn hello<T>(hi: T) {
    println("{}", hi);
}
// vim: ft=sway
