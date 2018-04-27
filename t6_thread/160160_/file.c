#include <stdio.h>
#include <stdlib.h>



struct txn{
    int txn_id;
    int txn_type;
    double txn_amount;
    int txn_acct1;
    int txn_acct2;

};
int main(){
    FILE *infile;
    infile = fopen("text.txt", "r");
    if(infile == NULL)
    {
       printf("Can not open file 1!\n");
    }
    else
    {
       char acct_id[255],acct_bal[255];
       int status1,id;
       double acct[10000],bal;
       do
       {
         status1 = fscanf(infile, "%s", &acct_id);
         status1 = fscanf(infile, "%s", &acct_bal);
         bal = atof(acct_bal);
         id = atoi(acct_id);
         acct[id-1001] = bal;
         printf("-- %f\n", acct[id-1001]);

      }while(status1 != -1);
    }
    fclose(infile);


    int n =10;
    struct txn my_txn[n];
    FILE *txn_file;
    txn_file = fopen("txn.txt", "r");
    if(txn_file == NULL)
    {
       printf("Can not open file 1!\n");
    }
    else
    {
       char txn_id[255],txn_type[255],txn_amount[255],txn_a1[255],txn_a2[255];
       int status1;
       do
       {
           status1 = fscanf(txn_file, "%s", &txn_id);
           status1 = fscanf(txn_file, "%s", &txn_type);
           status1 = fscanf(txn_file, "%s", &txn_amount);
           status1 = fscanf(txn_file, "%s", &txn_a1);
           status1 = fscanf(txn_file, "%s", &txn_a2);
           printf(" %s %s %s %s %s\n",txn_id,txn_type,txn_amount,txn_a1,txn_a2);
           (my_txn[txn_id-1]).txn_id = txn_id;



      }while(status1 != -1);
    }


    fclose(infile);





    return 0;
}
