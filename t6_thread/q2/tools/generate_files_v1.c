#include<stdio.h>
#include<stdlib.h>

#define ACS 10000
#define START 1001

#define DEBUG 0
#if DEBUG
#define DED_RATE 0.00	//0.01
#define INT_RATE 1		//1.071
#else
#define DED_RATE 0.01
#define INT_RATE 1.071
#endif

#define REAL_INPUT 0

struct transaction{
       int seq;
       int type;
       double amount;
       int ac1;
       int ac2;
};

enum{
         DEPOSIT=1,
         WDRAW,
         INTEREST,
         TRANSFER,
         MAX_TTYPE
};
int main(int argc, char **argv)
{
  
   FILE *fp;
   int ctr, num_transactions;
   double acc_balance[10000];
   struct transaction t;
   if(argc != 5){
         printf("usage: %s acc-file-name trx-file-name of-transactions opfile-name\n", argv[0]);
         exit(-1);
   }
  
  num_transactions = atoi(argv[3]);

  if(num_transactions <= 0 || num_transactions > 1000000000) {
       printf("Invalid numnber of transactions\n");
       exit(-1);
  }

  fp = fopen(argv[1], "w");
 
  if(!fp){
         perror("");
         exit(-1);    
  }
  
  for(ctr=0; ctr<ACS; ++ctr){
#if REAL_INPUT
         acc_balance[ctr] = 100000.0 + drand48() * 100000.0;
#else
         acc_balance[ctr] = 100000.0 + random() % 100000;
#endif
         fprintf(fp, "%d %.2f\n", ctr+START, acc_balance[ctr]);
  }   
  fclose(fp); 
  
  fp = fopen(argv[2], "w");
 
  if(!fp){
         perror("");
         exit(-1);    
  }
  
  for(ctr=0; ctr<num_transactions; ++ctr){
     int ac1, ac2;

     t.seq = ctr + 1;
     t.type = 1 + random() % TRANSFER;
     t.ac1 = 1001 + (random() % ACS);
     ac1 = t.ac1 - 1001;
     if(t.type == TRANSFER){
        do{
          t.ac2 = 1001 + (random() % ACS);
          ac2 = t.ac2 - 1001;
        }while(t.ac1 == t.ac2);
     }else{
        t.ac2 = 0;
     }

     switch(t.type){
     case INTEREST:
       t.amount = 0;
       acc_balance[ac1] *= INT_RATE;
       break;
     case DEPOSIT:
#if REAL_INPUT
       t.amount =  100.0 + drand48() * 100000.0;
#else
       t.amount =  100.0 + random() % 100000;
#endif
       acc_balance[ac1] += t.amount - t.amount * DED_RATE;
       break;
     case WDRAW:
     case TRANSFER:
     {
       double balance;
       int limit = ACS;
       if(acc_balance[ac1] < 1000){
         do{
           t.ac1 = 1001 + (random() % ACS);
           ac1= t.ac1 - 1001;
           limit--;
           if (limit <= 0) {
             printf("balances too low\n");
             t.type = DEPOSIT;
             break;
           }
         }while(acc_balance[ac1] < 1000);
         if (limit <= 0) {
           continue;
         }
       }
       balance = acc_balance[ac1];
       do{
#if REAL_INPUT
          t.amount = 0.9 * drand48() * acc_balance[ac1];
#else
          t.amount = 0.9 * (random() % (long int) acc_balance[ac1]);
#endif
          balance -= t.amount + t.amount * DED_RATE;
                                   
       }while(balance < 0);
                      
       acc_balance[ac1] = balance;
     }
       if(t.ac2)  /*TRANSFER*/
          acc_balance[ac2] +=  t.amount - t.amount * DED_RATE;
          break;
     default:
       printf("Error\n");
       exit(-1);
     }
#if DEBUG //print balances
      int ctr2;
      char type_str[MAX_TTYPE][10] = {"", "DP", "WD", "IN", "TR",};
      printf("%3d %s %.2f %d %d\n", t.seq, type_str[t.type], t.amount, t.ac1, t.ac2);
      for(ctr2 = 0; ctr2 < ACS; ++ctr2){
		  printf("%.2f\t", acc_balance[ctr2]);
	  }
	  printf("\n");
#endif
      fprintf(fp, "%d %d %.2f %d %d\n", t.seq, t.type, t.amount, t.ac1, t.ac2);
   }

   fclose(fp);

   fp = fopen(argv[4], "w");

   if(!fp){
      perror("");
      exit(-1);
   }

   for(ctr=0; ctr<ACS; ++ctr)
     fprintf(fp, "%d %.2f\n", ctr+START, acc_balance[ctr]);

   fclose(fp);
}
