#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include<pthread.h>
#include <string.h>
#include <stdlib.h>


#define MAX_THREADS 64
#define MAX_THREADS 64
#define USAGE_EXIT(s) do{ \
        printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
        exit(-1);\
        }while(0);
char * account_Id [10000];
double account_Balance[10000];
char *tempDataPtr ;
static int transaction_count ;
int thread_count ;
static int counter = 0;

pthread_mutex_t read_lock;
pthread_mutex_t account_lock[10000]; // a lock alloted to each account


void trans_data_Updation(char *transaction){ // Receives transaction as string which is later broken into data
  int transaction_seq , transaction_class , account_id1 , account_id2 ;
  double transaction_amount ;
   //printf("account no 1 : %d :: account no 2 :: %d\n", &account_id1, account_id2);
  sscanf(transaction, "%d %d %lf %d %d ",&transaction_seq,&transaction_class,&transaction_amount,&account_id1,&account_id2);
  printf("%s\n",transaction );
  //printf("account no 1 : %d :: account no 2 :: %d\n", &account_id1 , account_id2 -1001);

  // TO Choose that which class did the transaction belong to
  switch (transaction_class){
    case 1 :
            pthread_mutex_lock(&account_lock[account_id1-1001]);
            account_Balance[account_id1-1001] += 0.99 * transaction_amount ;
            //printf("Added Rs. %lf to Account No : %d\n",transaction_amount , account_id1 - 1001 );
            //printf("---------------------\n");
            pthread_mutex_unlock(&account_lock[account_id1-1001]);
            break;
    case 2 :
            pthread_mutex_lock(&account_lock[account_id1-1001]);
            account_Balance[account_id1-1001] -= 1.01 * transaction_amount ;
            //printf("Withdrawn Rs. %lf from Account No : %d\n",transaction_amount , account_id1  - 1001 );
            //printf("---------------------\n");
            pthread_mutex_unlock(&account_lock[account_id1-1001]);
            break;
    case 3 :
            pthread_mutex_lock(&account_lock[account_id1-1001]);
            account_Balance[account_id1-1001] += 0.071 * transaction_amount ;
            //printf("Interest of Rs. %lf mentioned to Account No : %d\n",transaction_amount , account_id1  - 1001 );
            ////printf("---------------------\n");
            pthread_mutex_unlock(&account_lock[account_id1-1001]);
            break;
    case 4 :
            pthread_mutex_lock(&account_lock[account_id1-1001]);
            account_Balance[account_id1-1001] -= 1.01 * transaction_amount ;
            
            //printf("Transffered Rs. %lf from Account No : %d to Account No : %d \n",transaction_amount , account_id1  - 1001 , account_id2 - 1001 );
            //printf("---------------------\n");
            pthread_mutex_unlock(&account_lock[account_id1-1001]);
	    pthread_mutex_lock(&account_lock[account_id2-1001]);

             account_Balance[account_id2-1001] += 0.99 * transaction_amount ;
            pthread_mutex_unlock(&account_lock[account_id2-1001]);
            break;
  printf("aaa\n");


  }
}

void data_Extract(char *fileEnd) {
  char *cptr;
  // char *endptr = (char *)arg;
  int len;
  char transaction[250];
  while (1) {

    pthread_mutex_lock(&read_lock);
    counter++;

    if (tempDataPtr >= fileEnd  || counter > transaction_count ) {
      pthread_mutex_unlock(&read_lock);
      printf("broke\n" );
      printf("counter : %d\n", counter);
      break;
    }

    cptr = tempDataPtr;
    tempDataPtr = strchr(cptr, '\n');

    len = (int)(tempDataPtr - cptr);
    strncpy(transaction, cptr, len);
    cptr[len] = "\0";
    printf("%s \n",cptr);
    //printf("counter : %d\n",counter );

    tempDataPtr+=1;

    printf("len=%d %s done\n",len,transaction);
    pthread_mutex_unlock(&read_lock);

    /*Perform the real calculation*/
    //printf("start----%s\n",transaction);
    //printf("%s\n",transaction );

    trans_data_Updation(transaction) ;
  }
  pthread_exit(NULL);

}

int main(int argc, char const *argv[])
{


    struct timeval start, end;


  int fd, ctr;
  unsigned long size, bytes_read = 0, hash_count;
  char *fileBeginPtr, *fileEndPtr;
  //pthread_t threads[THREADS];

  if (argc != 5) {
    printf("Usage: %s <fileneme>\n", argv[0]);
    exit(-1);
  }
  fd = open(argv[2], O_RDONLY);
  if (fd < 0) {
    printf("Can not open file\n");
    exit(-1);
  }

  size = lseek(fd, 0, SEEK_END);
  if (size <= 0) {
    perror("lseek");
    exit(-1);
  }

  if (lseek(fd, 0, SEEK_SET) != 0) {
    perror("lseek");
    exit(-1);
  }

  fileBeginPtr = malloc(size);
  if (!fileBeginPtr) {
    perror("mem");
    exit(-1);
  }


  transaction_count = atoi(argv[3]);
  if (transaction_count <= 0)
    USAGE_EXIT("invalid num txn");

  thread_count = atoi(argv[4]);
  if (thread_count <= 0 || thread_count > MAX_THREADS) {
    USAGE_EXIT("invalid num of threads");
  }
  pthread_t THREADS_ARR[thread_count];

  FILE * fp;
  char * line = NULL;
  size_t len = 0;
  ssize_t read_0;
  printf("%s\n", argv[1] );
  fp = fopen(argv[1], "r");
  printf("11\n");
  if (fp == NULL)
    exit(EXIT_FAILURE);
  int i = 0 ;
  while ((read_0 = getline(&line, &len, fp)) != -1) {
    // printf("%s",line);
    double some ;
    sscanf( line, "%s %lf", &account_Id[i], &some);
    account_Balance[i] = some ;
    i ++ ;
    // printf("%lf\n",some );
    //printf("Retrieved line of length %zu :\n", read);
    //printf("%s", line);
  }
  printf("%lf\n", account_Balance[0]);
  fclose(fp);
  if (line)
    free(line);




  do {
    unsigned long bytes;
    fileEndPtr = fileBeginPtr + bytes_read;
    bytes = read(fd, fileEndPtr, size - bytes_read);
    if (bytes < 0) {
      perror("read");
      exit(-1);
    }
    bytes_read += bytes;
  } while (size != bytes_read);
  fileEndPtr = fileBeginPtr + size ;
  printf("%c\n", *(fileBeginPtr + size - 2));
  printf("transaction_count : %d :: thread_count : %d\n", transaction_count, thread_count );

  /***************/

   tempDataPtr = fileBeginPtr;
    fileEndPtr = fileBeginPtr + size;
    pthread_mutex_init(&read_lock, NULL);

    for (int j = 0; j < 10000; j++)
       pthread_mutex_init(&account_lock[j], NULL);

    for(ctr=0; ctr < thread_count;ctr++){
       if(pthread_create(&THREADS_ARR[ctr], NULL, data_Extract , fileEndPtr) != 0){
             perror("error in creating threads");
             exit(-1);
       }
    }
    for(ctr=0; ctr < thread_count; ++ctr)
           pthread_join(THREADS_ARR[ctr], NULL);

    free(fileBeginPtr); // freed the memory stored by string
    close(fd);
    FILE * print_data;

    print_data = fopen ("answer.txt", "w+");
    int account_count = 10000;
    for(int i = 0; i < 10000 ; i++){
      fprintf(print_data , "%d %0.2lf\n", i + 1001 ,account_Balance[i] );
      printf("==================================\n" );
      printf(print_data , "%d %0.2lf\n", i + 1001 ,account_Balance[i] );

        }
    //fclose(fp);


  return 0;
}
