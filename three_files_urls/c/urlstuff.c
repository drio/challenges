#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "khash.h"

#define TARGET_KEY_NAME "embedCode"

KHASH_MAP_INIT_STR(str, int)

typedef struct {
  int  read_key_name;
  char key_name[100];
  int  ki;
  int  read_key_value;
  char key_value[100];
  int  vi;
} sm_vars; // Vars for the state machine

void reset_ds(sm_vars *ds) {
  ds->key_name[0] = '\0';
  ds->key_value[0] = '\0';
  ds->read_key_name = 0;  // Flags we have to read a key name
  ds->ki = 0;             // position to write in key_nane
  ds->read_key_value = 0; // Flags we have to read a value
  ds->vi = 0;             // position to write in key_value
}

int main() {
  int ret;
  khiter_t k;
  khash_t(str) *h;

  char c;
  sm_vars svm;
  char *new_key;

  h = kh_init(str);
  reset_ds(&svm);

  // Use machine state to implement logic
  for(;;) {
    c = getchar();
    if(c == EOF) break;

    if (c == '?' || c == '&' || c == '\n') { // Start URL data or we have a key/value
      svm.key_value[svm.vi] = '\0';
      if (strcmp(svm.key_name, TARGET_KEY_NAME) == 0) { 
        new_key = (char *) malloc(sizeof(char) * strlen(svm.key_value) + 1);
        strcpy(new_key, svm.key_value);
		    k = kh_put(str, h, new_key, &ret);
      }
      //printf("[%s] [%s]\n", svm.key_name, svm.key_value);
      reset_ds(&svm);
      svm.read_key_name = 1; // start reading the key name
      continue;
    }

    if (c == '=') { // If TARGET, read the value of that key
      svm.key_name[svm.ki] = '\0'; // So strcmp works
      svm.read_key_name = 0; svm.read_key_value = 1;
      svm.ki = 0; svm.vi = 0;
      continue;
    }

    if (svm.read_key_name) { // We are going to read a key name
      svm.key_name[svm.ki] = c; 
      svm.ki += 1;
    }

    if (svm.read_key_value) { // We have to read the key value
      svm.key_value[svm.vi] = c;
      svm.vi += 1;
    }
  }

  // Dump uniq results
  // printf("hash size: %d\n", kh_size(h));
  for (k = kh_begin(h); k != kh_end(h); ++k)
    if (kh_exist(h, k)) printf("%s\n", kh_key(h, k));

  kh_destroy(str, h);
  return(0);
}
