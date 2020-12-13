#!/usr/bin/env python3

import re

number_of_valid_passwords = 0

with open("passwords.txt") as password_file:
    for line in password_file.read().splitlines():
        lowest_number, highest_number, letter, password = re.split(r'[- :]+', line)
        if int(lowest_number) <= password.count(letter) <= int(highest_number):
            number_of_valid_passwords += 1

print(number_of_valid_passwords)
