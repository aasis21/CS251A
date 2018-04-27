#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<fcntl.h>
#include<pthread.h>
#include<string.h>
#include<math.h>


#define MAX_THREADS 64
#define USAGE_EXIT(s) do{ \
        printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
        exit(-1);\
        }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

pthread_mutex_t lock;
pthread_mutex_t lock_acct[10000];
static char *dataptr;
static int no_txn;
static int txn_ctr;
static double acct[10000];

void update_api(char *txn,double *acct){

    int txn_id,txn_type,txn_acct1,txn_acct2;
    double txn_amount;

    sscanf( txn, "%d %d %lf %d %d ", &txn_id, &txn_type, &txn_amount,&txn_acct1,&txn_acct2);

    //txn reading complete

    if(txn_type==1){
        double to_add = 0.99 * txn_amount;
        pthread_mutex_lock(&lock_acct[txn_acct1-1001]);
        acct[txn_acct1-1001] = acct[txn_acct1-1001] + to_add;
        pthread_mutex_unlock(&lock_acct[txn_acct1-1001]);
    }
    else if(txn_type==2){
        double to_sub = 1.01 * txn_amount;
        pthread_mutex_lock(&lock_acct[txn_acct1-1001]);
        acct[txn_acct1-1001] = acct[txn_acct1-1001] - to_sub;
        pthread_mutex_unlock(&lock_acct[txn_acct1-1001]);
    }
    else if(txn_type==3){
        pthread_mutex_lock(&lock_acct[txn_acct1-1001]);
        acct[txn_acct1-1001] = 1.071 * acct[txn_acct1-1001];
        pthread_mutex_unlock(&lock_acct[txn_acct1-1001]);

    }
    else if(txn_type==4){
        double service = 0.01 * txn_amount;
        pthread_mutex_lock(&lock_acct[txn_acct1-1001]);
        acct[txn_acct1-1001] = acct[txn_acct1-1001] - txn_amount - service;
        pthread_mutex_unlock(&lock_acct[txn_acct1-1001]);

        pthread_mutex_lock(&lock_acct[txn_acct2-1001]);
        acct[txn_acct2-1001] = acct[txn_acct2-1001] + txn_amount - service;
        pthread_mutex_unlock(&lock_acct[txn_acct2-1001]);
        //unlock
    }


}

void *update(void *arg){
    char *cptr;
    char *endptr = (char *)arg;
    int len;
    char ctxn[250];

    while(1){
         pthread_mutex_lock(&lock);
         if(dataptr >= endptr){
               pthread_mutex_unlock(&lock);
               break;
         }
         cptr = dataptr;
         dataptr = strchr(cptr, '\n');

         len = (int)(dataptr-cptr);
         strncpy(ctxn,cptr,len);
         dataptr++;
         //printf("len=%d %s done\n",len,ctxn);
         pthread_mutex_unlock(&lock);

         /*Perform the real calculation*/
         //printf("start----%s\n",ctxn);
         update_api(ctxn,acct);
         //printf("done----%s\n",ctxn);
   }
   pthread_exit(NULL);

}

int main(int argc, char **argv){

    struct timeval start, end;
    int  num_threads,num_txn;

    if(argc !=5)
             USAGE_EXIT("not enough parameters");

    num_txn = atoi(argv[3]);
    if(num_txn <=0)
            USAGE_EXIT("invalid num txn");

    num_threads = atoi(argv[4]);
    if(num_threads <=0 || num_threads > MAX_THREADS){
            USAGE_EXIT("invalid num of threads");
    }


    /* Parameters seems to be alright. Lets start our business*/


    FILE *infile;
    infile = fopen(argv[1], "r");
    if(infile == NULL)
    {
       printf("Can not open file 1!\n");
    }
    else
    {
       char acct_id[255],acct_bal[255];
       int status1,id;
       double bal;
       do
       {
         status1 = fscanf(infile, "%s", &acct_id);
         status1 = fscanf(infile, "%s", &acct_bal);
         bal = atof(acct_bal);
         id = atoi(acct_id);
         acct[id-1001] = bal;
         //printf("-- %f\n", acct[id-1001]);

      }while(status1 != -1);
    }
    fclose(infile);


    int fd, ctr;
    unsigned long size, bytes_read = 0;
    char *buff, *cbuff;
    fd = open(argv[2], O_RDONLY);
    if(fd < 0){
          printf("Can not open file\n");
          exit(-1);
    }

   size = lseek(fd, 0, SEEK_END);
   if(size <= 0){
          perror("lseek");
          exit(-1);
   }

   if(lseek(fd, 0, SEEK_SET) != 0){
          perror("lseek");
          exit(-1);
   }

   buff = malloc(size);
   if(!buff){
          perror("mem");
          exit(-1);
   }
   /*Read the complete file into buff*/
   do{
        unsigned long bytes;
        cbuff = buff + bytes_read;
        bytes = read(fd, cbuff, size - bytes_read);
        if(bytes < 0){
            perror("read");
            exit(-1);
        }
        //printf("mainfile%s",cbuff);
        bytes_read += bytes;
    }while(size != bytes_read);


    pthread_t threads[num_threads];
    dataptr = buff;
    cbuff = buff + size;
    pthread_mutex_init(&lock, NULL);

    for (int j = 0; j < 10000; j++)
       pthread_mutex_init(&lock_acct[j], NULL);

    gettimeofday(&start, NULL);

    for(ctr=0; ctr < num_threads;ctr++){
       if(pthread_create(&threads[ctr], NULL, update , cbuff) != 0){
             perror("pthread_create");
             exit(-1);
       }
    }
    for(ctr=0; ctr < num_threads; ++ctr)
           pthread_join(threads[ctr], NULL);

    gettimeofday(&end, NULL);
    //printf("Time taken = %ld microsecs\n", TDIFF(start, end));
    free(buff);
    close(fd);
    for(int i = 0;i<10000;i++){
        printf("%d %.2f\n",i+1001,acct[i]);
    }

}
