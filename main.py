from bs4 import BeautifulSoup
import time
import requests

def find_countries():
    url = ("https://www.scrapethissite.com/pages/simple/")

    page = requests.get(url)

    soup = BeautifulSoup(page.content, 'html.parser')

    countries = soup.find_all('div', class_= 'col-md-4 country')

    for index, country in enumerate (countries):
        country_name = country.h3.text.replace(" ","")
        country_info = country.div.text.replace(" ","")
        with open(f'post/{index}.txt', 'w', encoding="utf-8") as f:
            f.write(f'Country Name : {country_name.strip()} \n')
            f.write(f'{country_info.strip()}')
        print(f'file save: {index}')


if __name__ == '__main__':
    while True:
        find_countries()
        time.sleep(604800)