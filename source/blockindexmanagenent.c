// REM Sample
int current_block_index = 0;

void add_data_to_cache(void* data, size_t size) {
  if (block_array[current_block_index].size + size > 1 * 1024 * 1024 * 1024) {
	// Allocate new block if current one is full
	block_array[++current_block_index].data = malloc(1 * 1024 * 1024 * 1024);  // Allocate 1 GB for new block
	block_array[current_block_index].size = 0;
  }
  // Copy data to current block
  memcpy(block_array[current_block_index].data + block_array[current_block_index].size, data, size);
  block_array[current_block_index].size += size;
}
