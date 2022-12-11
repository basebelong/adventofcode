#!/usr/bin/env gawk -f

# return 0 for draw or player num for winner
function get_round_winner(p1, p2) {
    if (p1 == p2) { return 0; }                # draw
    else if (p1 == 1 && p2 == 2) { return 2; } # rock paper
    else if (p1 == 1 && p2 == 3) { return 1; } # rock scissors
    else if (p1 == 2 && p2 == 1) { return 1; } # paper rock
    else if (p1 == 2 && p2 == 3) { return 2; } # paper scissors
    else if (p1 == 3 && p2 == 1) { return 2; } # scissors rock
    else if (p1 == 3 && p2 == 2) { return 1; } # scissors paper
}

function obj_to_num(hand) {
    switch (hand) {
        case "A": return 1;
        case "B": return 2;
        case "C": return 3;
        case "X": return 1;
        case "Y": return 2;
        case "Z": return 3;
        default:
            printf("%s %d %s\n", "Error: Illegal file format found on line", NR, "of input file.") > "/dev/stderr";
            error = 1;
    }
}

BEGIN {
    score1 = 0;
    score2 = 0;
}

{
    # normalize player input from file to numeric
    p1 = obj_to_num($1);
    p2 = obj_to_num($2);

    round_winner = get_round_winner(p1, p2);

    # increment both player score with chosen object score
    # does not depend on round winner
    score1 += p1;
    score2 += p2;

    # increment score for winner with 6
    # increment score for both with 3 if draw
    switch (round_winner) {
        case 0:
            score1 += 3;
            score2 += 3;
            break;
        case 1:
            score1 += 6;
            break;
        case 2:
            score2 += 6;
            break;
    }

    # debug
    print p1, p2, round_winner, score1, score2;
}

END {
    # exit in main block triggers END block to run
    # https://www.gnu.org/software/gawk/manual/html_node/Exit-Statement.html
    if (error > 0) {
        exit error;
    }

    if (score1 > score2) { winner = 1; }
    else if (score2 > score1) { winner = 2; }
    else if (score1 == score2) { winner = 0; }

    printf("%s %d\n", "Total score player 1:", score1);
    printf("%s %d\n", "Total score player 2:", score2);

}