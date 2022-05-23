volatile int vola1 = 0;
volatile int vola2 = 0x2333;
volatile int vola3 = 0x3742;
volatile int vola4 = 0x4444;
volatile int vola5 = 0;

int main(void) {
    vola1 += 1;
    vola2 += 2;
    vola3 += 3;
    vola4 += 4;
    vola5 += 5;

    return 0;
}
