import requests
import json

offset = 0
url = f"https://api.spotify.com/v1/playlists/32twOqGf8gIswTgzG3IKxP/tracks?limit=100&offset="

headers = {"Authorization": "Bearer BQDs58JSogVlRAg2X5X6MA8pGmMjjQFQbL8rdyhydLXl0RQwAyKoXtJAVZeMIK7aH3NorUix6R6LwVATzHTIR5Mu63Q7hWSC9EPZQMNeJtYaeHRoO9bR7Rg1rvBD3D6quzrDcgeVJVOoglRAQAxQQWbVH4inuWo7SGC2nOIglIBEvN4oJI4iWe0mDXEX6q-9oTG-qJr4doKradSwgaiHWYLZvAdz6j2YZIlDcoK_bhVQn-AZQSX0C02GEtMZzuYaE3nom9f1Ze8-ST4"}

ret = requests.get(url + str(offset), headers=headers).json()

for i in range(1,10):
    offset = 100*i
    new = requests.get(url + str(offset), headers=headers).json()
    ret["items"].extend(new["items"])

print(len(ret["items"]))

with open('all_songs.json', 'w+') as f:
    json.dump(ret, f)