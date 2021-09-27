import csv
from urllib.request import urlopen
from bs4 import BeautifulSoup

url = "https://gamerch.com/umamusume/entry/231673"
dest = "./data/umamusume_parameter.csv"

def main():
    html = urlopen(url)
    soup = BeautifulSoup(html, 'html.parser')

    table = soup.find("div", class_="mu__table--scroll_inside")
    rows = table.find_all("tr")

    with open(dest, 'w', encoding="utf-8") as file:
        writer = csv.writer(file)

        for row in rows:
            row_arr = []
            cells = row.find_all(["th", "td"])
            
            for cell in cells[1:]:
                row_arr.append(cell.get_text())
            
            writer.writerow(row_arr)

if __name__ == "__main__":
    main()