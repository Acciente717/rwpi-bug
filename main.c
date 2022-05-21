extern volatile int vola1;
extern volatile int vola2;
extern volatile int vola3;
extern volatile int vola4;
extern volatile int vola5;

int main(void) {
    vola1 += 1;
    vola2 += 2;
    vola3 += 3;
    vola4 += 4;
    vola5 += 5;

    return 0;
}
