#include <stdio.h>

int main() {
    int n;
    // 1 <= n <= 30
    scanf("%d", &n);
    int a[n];
    // a_0 <= a_1 <= a_2 <= ... <= a_{n-1}
    // input_loop with 2 arguments -> i and n
    // i = 0 initially, n from input
    // terminate when i = n
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
    }
    int x;
    scanf("%d", &x);
    int l = 0, r = n;
    int i;
    while (l < r) {
        i = (l+r)/2;
        if (a[i] == x) {
            printf("Yes at index %d", i);
            return 0;
        } else if (a[i] < x) {
            l = i+1;
        } else {
            r = i;
        }
    }
    printf("Not found");
    return 0;
}
