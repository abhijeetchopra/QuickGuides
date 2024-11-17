#!/usr/bin/env python3

def check_parity(n):
    parity = None
    if n % 2 == 0:
        parity = "even"
    else:
        parity = "odd"
    return parity

def main():
    print("Enter a number:")
    n = int(input().strip())
    print(check_parity(n))

if __name__ == '__main__':
    main()
