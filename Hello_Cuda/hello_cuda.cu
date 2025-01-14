#include <iostream>

// Kernel function to be executed on the GPU
__global__ void helloCUDA() {
    printf("Hello, CUDA! This is thread %d\n", threadIdx.x);
}

int main() {
    // Launch the kernel with 10 threads
    helloCUDA << <1, 10 >> > ();

    // Wait for the GPU to finish
    cudaDeviceSynchronize();

    std::cout << "GPU kernel execution complete!\n";
    return 0;
}