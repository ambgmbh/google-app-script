// Rem Sample Code
#include <cuda_runtime.h>

void* host_cache;
size_t cache_size = 512 * 1024 * 1024; // 512 MB

int allocate_host_cache() {
  cudaError_t err = cudaMallocHost(&host_cache, cache_size);
  if (err != cudaSuccess) {
	return -1; // Error handling
  }
  return 0;
}
