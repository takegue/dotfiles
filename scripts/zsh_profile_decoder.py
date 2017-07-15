#!/usr/bin/env python3

import datetime
import sys

SLOW_THRESHOLD = 7

def parse_line(raw_line):
    nonewline = raw_line.strip('\n')
    timestr, rest = nonewline.split(' ', 1)
    return int(timestr), rest

def main(filename):

    with open(filename) as f:
        count = 0
        line = next(f)
        start_time, rest = parse_line(line)
        print(f"0 0 {line}")

        prev_line = rest
        prev_line_start = start_time
        for line in f:
            count += 1
            if not line.strip(): continue
            if not line[0].isdigit():
                continue

            t, rest = parse_line(line)
            diff = t - prev_line_start

            try:
                t, rest = parse_line(line)
                diff = t - prev_line_start
                since_start=t-start_time
                if diff > SLOW_THRESHOLD:
                    print (f"{since_start} {diff} {prev_line}")
                prev_line_start = t
                prev_line = rest
            except ValueError:
                continue


if __name__ == "__main__":
    main(sys.argv[1])
