#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>


#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))


__global__ void find_xor(int *input,int N, int* answer){
    int g_inx = blockIdx.x * blockDim.x + threadIdx.x;
    int b_inx = threadIdx.x;
    for(int i=blockDim.x/2;i>0;i=i/2){
        if((b_inx < i)&& (g_inx + i < N)){
            input[g_inx] = input[g_inx]^input[g_inx + i];
        }
        __syncthreads();
    }
    if(b_inx==0){
        atomicXor(answer,input[g_inx]);
    }

}

int main(int argc, char **argv){
    struct timeval start, end,s_start,s_end;
    int *h_input,*h_ans,*d_input,*d_ans;
    int N = atoi(argv[1]);
    srand(atoi(argv[2]));
    h_input = (int *)malloc(N * sizeof(int));
    h_ans = (int *)malloc(sizeof(int));
    h_ans[0] = 0;
    cudaMalloc(&d_input, N*sizeof(int));
    CUDA_ERROR_EXIT("cudaMalloc");

    cudaMalloc(&d_ans, sizeof(int));
    CUDA_ERROR_EXIT("cudaMalloc");

    for(int i=0; i<N; i++){
        h_input[i] = (int)rand();
    }
    cudaMemcpy(d_input,h_input, N*sizeof(int) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");
    cudaMemcpy(d_ans,h_ans,sizeof(int) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");

    gettimeofday(&start, NULL);
    int blocks = N /1024;
    if(N % 1024)
        ++blocks;

    find_xor<<<blocks, 1024>>>(d_input,N,d_ans);
    CUDA_ERROR_EXIT("kernel invocation");
    cudaDeviceSynchronize();
    gettimeofday(&end, NULL);

    /* Copy back result*/
    cudaMemcpy(h_ans,d_ans,sizeof(int) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");

    //printf("gpu Processsing =%ld microsecs\n", TDIFF(start, end));
    cudaFree(d_input);
    cudaFree(d_ans);

    gettimeofday(&s_start, NULL);
    int h_ans_seq=0;
    for (int i=0;i<N;i++){
         h_ans_seq = h_ans_seq^h_input[i];
    }
    gettimeofday(&s_end, NULL);

    printf("cpu Processsing =%ld microsecs\n", TDIFF(s_start, s_end));
    if(*h_ans==h_ans_seq){
         printf("congrats :) , Answer is %d\n",h_ans_seq);
     }
     else{
         printf(":( wrong answer, real: %d, yours: %d\n",h_ans_seq,*h_ans);
    }
    printf("%d\n",h_ans[0]);
    free(h_ans);
    free(h_input);

}
