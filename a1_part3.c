#include <stdio.h>

int fast_exp(int a, int b) {
    if (b == 0) {
        return 1;
    } else {
        int c = fast_exp(a, b/2);
        if (b % 2 == 0) {
            return c * c;
        } else {
            return a * c * c;
        }
    }
}

int main() {
    int x, n;
    // 0 <= x <= 10000
    // 0 <= n <= 10000
    // x^n doesn't overflow in 32-bit integers
    scanf("%d %d", &x, &n);
    int ans = fast_exp(x, n);
    printf("%d\n", ans);
    return 0;
}
