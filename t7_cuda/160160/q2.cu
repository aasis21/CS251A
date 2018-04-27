#include <stdio.h>
#include <cuda.h>
#include <stdlib.h>

__global__ void xor_it(int* darray, int* danswer, int num){
    int actual_id, tid;

    tid = threadIdx.x;
    actual_id = ( blockIdx.x * blockDim.x ) + tid;

    int i;
    for(i=(blockDim.x/2); i>0; i/=2){
        if(tid<i && actual_id+i<num){
            darray[actual_id] = darray[actual_id]^darray[actual_id+i];
        }
        __syncthreads();
    }
    if(tid==0){
        atomicXor(danswer, darray[actual_id]);
    }

}

int main(int argc, char **argv){

    int *harray, *darray, blocks;

    int *hanswer, *danswer;

    int num = atoi(argv[1]);
    int seed = atoi(argv[2]);

    harray = (int*) malloc(num*sizeof(int));

    hanswer = (int*) malloc(sizeof(int));
    *hanswer = 0;

    int i;
    srand(seed);
    for(i=0; i<num; i++){
        harray[i] = (int) rand();
    }

    cudaMalloc(&darray, num*sizeof(int));
    cudaMemcpy(darray, harray, num*sizeof(int), cudaMemcpyHostToDevice);

    cudaMalloc(&danswer, sizeof(int));
    cudaMemcpy(danswer, hanswer, sizeof(int), cudaMemcpyHostToDevice);

    blocks = num/1024;

    if(num % 1024){
        blocks++;
    }

    xor_it<<<blocks, 1024>>>(darray, danswer, num);

    cudaDeviceSynchronize();

    cudaMemcpy(hanswer, danswer, sizeof(int), cudaMemcpyDeviceToHost);

    printf("%d\n",*hanswer);

    free(hanswer);
    free(harray);
    cudaFree(darray);
    cudaFree(danswer);

}
