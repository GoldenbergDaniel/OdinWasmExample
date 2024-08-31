package main

BUFFER_SIZE :: 1024

buffer: [BUFFER_SIZE]byte
buffer_off: int

@(export)
do_string :: proc(ptr: [^]byte, size: int) -> [^]byte
{
  if size < 0 || size > BUFFER_SIZE - buffer_off do return nil

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
