package main

buffer: [1024]byte
buffer_off: int

@(export)
do_string :: proc(ptr: [^]byte, size: int) -> [^]byte
{
  for i := (size-1)/2; i >= 0; i -= 1
  {
    temp := ptr[size-1-i]
    ptr[size-1-i] = ptr[i]
    ptr[i] = temp
  }

  return ptr
}

@(export)
mem_alloc :: proc(size: int) -> rawptr
{
  ptr := &buffer[buffer_off]
  buffer_off += size

  return ptr
}

@(export)
mem_clear :: proc()
{
  for &b in buffer do b = 0
  buffer_off = 0
}
