#!/usr/bin/python
import sys
import json

sys.argv.pop(0)

def printFlights():
  for t in doc["trips"]:  
    if t['destination'] is None:
      continue
    for d in t["dates"]:
      for f in d["flights"]:         
        print(t['origin'] + " " + t['destination'] + " " + f["time"][0] + " " + str(f['regularFare']['fares'][0]['amount']) + " " + doc["currency"] ) 

for arg in sys.argv:
  j=open(arg).read()
  doc=json.loads(j)

  printFlights()
