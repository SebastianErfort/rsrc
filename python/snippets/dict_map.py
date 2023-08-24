#!/usr/bin/python3
'''Use python inbuilt map() to modify dictionary'''

prices = {'apple': 0.40, 'orange': 0.35, 'banana': 0.25}
def discount(current_price):
    return (current_price[0], round(current_price[1] * 0.95, 2))
new_prices = dict(map(discount, prices.items()))
print(new_prices)
