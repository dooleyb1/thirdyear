#include <stdio.h>
  int main () {
        int num;
        printf("Enter your input:");
        scanf("%d", &num);
        printf("Roman Number: ");
        while (num > 0) {
                if (num >= 1000) {
                        /* M - 1000 */
                        printf("M");
                        num = num - 1000;
                } else if (num >= 500) {
                        /*
                         * D is 500. CM is 900
                         * CM = M - C = 1000 - 100 => 900
                         */
                        if (num >= 900) {
                                printf("CM");
                                num = num - 900;
                        } else {
                                printf("D");
                                num = num - 500;
                        }
                } else if (num >= 100) {
                        /*
                         * C is 100. CD is 400
                         * CD = D - C = 500 - 100 => 400
                         */
                        if (num >= 400) {
                                printf("CD");
                                num = num - 400;
                        } else {
                                printf("C");
                                num = num - 100;
                        }
                } else if (num >= 50) {
                        /*
                         * L is 50. XC is 90
                         * XC = C - X = 100 - 10 => 90
                         */
                        if (num >= 90) {
                                printf("XC");
                                num = num - 90;
                        } else {
                                printf("L");
                                num = num - 50;
                        }
                } else if (num >= 9) {
                        /*
                         * XL is 40. IX is 9. X is 10
                         * XL = L - X = 50 - 10 = 40
                         * IX = X - I = 10 - 1 = 9
                         */
                        if (num >= 40) {
                                printf("XL");
                                num = num - 40;
                        } else if (num == 9) {
                                printf("IX");
                                num = num - 9;
                        } else {
                                printf("X");
                                num = num - 10;
                        }
                } else if (num >= 4) {
                        /*
                         * V is 5 and IV is 4
                         * IV = V - I = 5 - 1 => 4
                         */
                        if (num >= 5) {
                                printf("V");
                                num = num - 5;
                        } else {
                                printf("IV");
                                num = num - 4;
                        }
                } else {
                        printf("I");
                        num = num - 1;
                }
        }
        printf("\n");
  }
