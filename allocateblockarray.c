// REM SAmple
#define MAX_BLOCKS 512
Block* block_array;

int allocate_block_array() {
  block_array = (Block*)malloc(sizeof(Block) * MAX_BLOCKS);
  if (!block_array) {
	return -1; // Error handling
  }
  return 0;
}

