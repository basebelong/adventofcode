#!/usr/bin/env gawk -f

function print_line(width) {
    i = 0;
    while (i <= width) {
        printf("-");
        i++;
    }
    printf("\n");
}

BEGIN {
    RS = "";
    FS = "\n";
    cols = 30;
    printf("%4s %8s %8s\n", "Elf", "Cals", "HiCals");
    print_line(cols);
}

{
    for (i = 1; i <= NF; i++){
        sum += $i;
    }

    sums[NR] = sum;

    if (sums[NR] > high_cal) {
        high_cal = sums[NR];
        high_elf = NR
    }

    printf("%4d %8d %8d\n", NR, sums[NR], high_cal);
    sum = 0;
}


END {
    printf("\n%s\n", "Result");
    print_line(cols);
    printf("%8s: %6d\n", "Elf", high_elf);
    printf("%8s: %6d\n", "Calories", high_cal)
}