#!/usr/bin/env python3

import re

number_of_valid_passwords_old = 0
number_of_valid_passwords_new = 0

with open("passwords.txt") as password_file:
    for line in password_file.read().splitlines():
        number1, number2, letter, password = re.split('[- :]+', line)

        if int(number1) <= password.count(letter) <= int(number2):
            number_of_valid_passwords_old += 1

        if (password[int(number1) - 1] == letter) != (password[int(number2) - 1] == letter):
            number_of_valid_passwords_new += 1

print(number_of_valid_passwords_old)
print(number_of_valid_passwords_new)
