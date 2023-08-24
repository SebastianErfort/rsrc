# Search on Google
# pip install google-search
from googlesearch.googlesearch import GoogleSearch

def Get_Google_Search(query):
    Google = GoogleSearch()
    r = Google.search(query, num_results=10)
    for data in r.results:
        print("Title: " + data.title)
        print("Content: " + data.getText())

Get_Google_Search("python programming")
