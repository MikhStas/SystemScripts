#Get currency rates from privatbank website

import requests
import re


class Currency:
    def __init__(self, name, id_sell, id_buy):
        self.name = name
        self.id_sell = id_sell
        self.id_buy = id_buy
        self.sell_rate = None
        self.buy_rate = None
        self.rate_source = 'https://privatbank.ua/ru'

    def get_rate(self):
        responce = requests.get(self.rate_source)
        html = responce.text
        regular_str = r'\D+(\d+\.?\d+)'

        match_str = self.id_sell + regular_str
        match = re.search(match_str, html)
        self.sell_rate = match.group(1)

        match_str = self.id_buy + regular_str
        match = re.search(match_str, html)
        self.buy_rate = match.group(1)

    def print_rate(self):
        print(self.name, "Sell:", self.sell_rate, "Buy:", self.buy_rate)


if __name__ == "__main__":
    eur = Currency('EUR', 'EUR_sell', 'EUR_buy')
    usd = Currency('USD', 'USD_sell', 'USD_buy')
    rub = Currency('RUB', 'RUB_sell', 'RUB_buy')

    currencies = [eur, usd, rub]
    for cur in currencies:
        cur.get_rate()
        cur.print_rate()
