memory.grow(1);
const index = 1;
const value = 24;
store<u8>(index, value);
export function indexOne(): i32 {
  return load<u8>(1);
}