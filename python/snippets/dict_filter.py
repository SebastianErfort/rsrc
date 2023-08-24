#!/usr/bin/python3
'''Use python inbuilt filter() to select items from dictionary'''

prices = {'apple': 0.40, 'orange': 0.35, 'banana': 0.25}
def has_low_price(price):
    return prices[price] < 0.4
low_price = list(filter(has_low_price, prices.keys()))
print(low_price)
