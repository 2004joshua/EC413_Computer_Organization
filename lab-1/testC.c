#include <stdio.h>
// SOLUTION FILE

int main()
{
  int var_int;                    // 2

  unsigned char uchar1, uchar2;   // 3
  signed char schar1, schar2;

  int x, y;                       // 4

  char i;                         // 5
  char shift_char;

  int a[10] = {0,10,20,30,40,50,60,70,80,90};    // 6

  int b[10], c[10];               // 7
  int *ip, *ip2;
  int j, k;

  char AString[] = "HAL";           // 8

  // 1 -- change "World" to your name
  printf("\n\n PART 1 ---------\n");

  printf("\n Hello Joshua Arrevillaga! \n");

  // 2 -- find sizes of the other C datatypes
  printf("\n\n PART 2 ----------\n");

  printf("\n size of data type int = %zu", sizeof(int));
  printf("\n size of data type char = %zu", sizeof(char)); 
  printf("\n size of data type float = %zu", sizeof(float)); 
  printf("\n size of data type double = %zu", sizeof(double)); 
  printf("\n size of data type short int = %zu", sizeof(short int));
  printf("\n size of data type long int = %zu", sizeof(long int)); 
  printf("\n size of data type unsigned short int = %zu", sizeof(unsigned short int)); 

  // sizeof() returns size_t so use %zu

  // 3 -- explore signed versus unsigned datatypes and their interactions
  printf("\n\n PART 3 ----------\n");

  uchar1 = 0xFF;
  uchar2 = 0xFE;
  schar1 = 0xFF;
  schar2 = 0xFE;

  printf("\n uchar1 = %d ", uchar1);
  printf("\n schar1 = %d ", schar1);
  
  printf("\n\nThe differience between uchar1 and schar1 is their respective data type.\n"); 
  printf("uchar1 is an unsigned interger and schar1 is a signed integer. \n");
  printf("\n This means the signed integer is outputting the negtive number while the unsigned integer is the 2's complement of that number"); 

  // comparing the uchars
  if(uchar1 < uchar2) {
    printf("\n uchar2 is larger: %d", uchar2); 
  }
  else {
    printf("\n uchar1 is larger: %d", uchar1); 
  } 

  // comparing the schars
  if(schar1 < schar2) {
    printf("\n schar2 is larger: %d", schar2);
  }
  else {
    printf("\n schar1 is larger: %d", schar1); 
  }

  if(schar1 < uchar1) {
    printf("\n uchar1 is larger!");
  }
  else {
    printf("\n schar1 is larger!");
  }

  printf("\n schar1 + schar2 = %d", schar1 + schar2);
  printf("\n This is expected since (-1) + (-2) is -3");

  printf("\n uchar1 + uchar2 = %d", uchar1 + uchar2);
  printf("\n This is expected since (255) + (254) is 509");

  printf("\n schar1 + uchar1 = %d", schar1 + uchar1); 
  printf("\n This is expcted since (-1) + (255) is 254");

  printf("\n It is expected that the unsigned variable would be greater since the signed ones are negative");

  // 4 -- Booleans
  printf("\n\n PART 4 ----------\n");

  x = 1; y = 2;

  int bool_true = x != y; 
  int bool_false = x == y; 

  printf("\n The value for true is: %d", bool_true); 
  printf("\n The value for false is: %d", bool_false);

  printf("\n The size of a boolean is: %zu", sizeof(x | x)); 

  printf("\n\n PART 4.1 ----------\n");
  printf("\n x & y = %d", x & y);   // Bitwise AND
  printf("\n x && y = %d", x && y); // Logical AND

  printf("\n\n PART 4.2 ----------\n");
  printf("\n ~x = %d", ~x);   // Bitwise NOT
  printf("\n !x = %d", !x);   // Logical NOT

  printf("\n\n The differnce between ~ and ! is ~ is a not bitwise operator and ! is a not logical operator");

  // 5 -- shifts
  printf("\n\n PART 5 ----------\n");

  shift_char = 15;
  i = 1;

  printf("\n shift_char << %d = %d", i, shift_char << i);

  // Shifting right by 1
  printf("\n shift_char >> %d = %d", i, shift_char >> i);  // Expected result: 7 (00000111)

  // Shifting left by 3 places
  i = 3;
  printf("\n shift_char << %d = %d", i, shift_char << i);  // Expected result: 120 (01111000)

  // Shifting left by more than 3 places
  i = 4;
  printf("\n shift_char << %d = %d", i, shift_char << i);  // Expected result: 240 (11110000)

  // Shifting left by more than 7 places
  i = 8;
  printf("\n shift_char << %d = %d", i, shift_char << i);  // Expected result: 3840 (This will overflow an 8-bit value)
    
  
  // HINT: If you cannot observe any "interesting" results using the above statement,
  // try assigning the shifted value to a different variable and then printing the new 
  // variable.


  // 6 -- pointer basics
  printf("\n\n PART 6 ----------\n");

  ip = a;
  printf("\nstart %d %d %d %d %d %d %d \n",
	 a[0], *(ip), *(ip+1), *ip++, *ip, *(ip+3), *(ip-1));

  
  printf("\nstart %d %d %d %d %d %d %d \n",
	 a[1], *(ip), *(ip+1), *ip++, *ip, *(ip+3), *(ip-1));

  printf("\nThe size of an integer pointer is: %zu", sizeof(ip)); 

  printf("\n\n The pointer value of ip = %x", ip);
  printf("\n The pointer value is in hex because it that place in memory, which is very large to the point is needs to be written in hex");
  printf("\n The pointer value value of ip + 1 = %x", ip + 1);
  printf("\n The difference between ip and ip + 1 is 4 because ip + 1 point at the next integer value which is 4 bytes");


  // The difference its by four is because the datatype size is 4 so it increment by so

  // 7 -- programming with pointers
  printf("\n\n PART 7 ----------\n");

  printf("\n I am reversing the array by conventional array indices\n");//doing this
  int z = 9;
  for(i = 0; i < 10; i++){
    b[i] = a[z];
    z--;
  }
  printf("\n a = ");
  for(i = 0; i < 10; i++){
    printf("%d ", a[i]);
  }
  printf("\n and in reverse is");
  printf("\n b = ");
  for(i = 0; i < 10; i++){
    printf("%d ", b[i]);
  }

  printf("\n\n Second I am reversing the array by pointers\n");//doing this 
  int *p1, *p2, *p3;

  p1 = a;
  p2 = c + 9;
  p3 = c; //have to make a third so it points to the start of the c array without any changes in the while loop 

  while (p1 < a + 10) {
    *p2 = *p1;
    p1++;
    p2--;
  } //using the while loop and thee second pointer to get the reverse order of the array

  p1 = a;
  printf("\n a = ");
  for(i = 0; i < 10; i++){
    printf("%d ", *p1++);
  }

  //using the third pointer to start from first point of c
  printf("\n c = ");
  for(i = 0; i < 10; i++){
    printf("%d ", *p3++);
  }

  // 8 -- strings
  printf("\n\n PART 8 ----------\n");

  printf("\n %s \n", AString);

  //Printing ascii value of characters 
  printf(" These are the ASCII values of characters (HAL) in string");
  printf("\n H = %d", AString[0]);
  printf("\n A = %d", AString[1]);
  printf("\n L = %d", AString[2]);

  //Printing the value of byte after last character
  printf("\n\n Value of the last byte in string = %d, which is a null character", AString[3]);

  //Printing ascii value of characters + 1
  printf("\n\n These are ASCII values of characters in string + 1");
  printf("\n H + 1 = %c", AString[0] + 1);
  printf("\n A + 1 = %c", AString[1] + 1);
  printf("\n L + 1 = %c", AString[2] + 1);
  printf("\n We get IBM which is expected because that is the next letter or in decimal (+1) from the previous");

  //Adding 60 to last byte and printing 
  AString[3] = AString[3] + 60;
  printf("\n\n %s", AString);
  printf("\n This makes sense because the last byte is 0 but adding 60 give us < because its int value from the ASCII table is 60");

  // 9 -- address calculation
  printf("\n\n PART 9 ----------\n");
  printf(" Printing out output array addresses by direct refrence\n");
  ip2 = b;
  for (k = 0; k < 10; k++){
    printf("\n %d -- %x", k, ip2);
    b[k] = a[k];
    *ip2++;
  }         // direct reference to array element

  printf("\n");

  printf("\n Printing out output array addresses by indirect refrence\n");
  ip = a;
  ip2 = b;
  for (k = 0; k < 10; k++){
    printf("\n %d -- %x", k, ip2);
    *ip2++ = *ip++; 
  }    // indirect reference to array element


  // all done
  printf("\n\n ALL DONE\n");
}
