#!/usr/bin/python
import sys
import json

sys.argv.pop(0)

def printFlights( flight_type ):
  for f in doc[flight_type]:  
    if f['price'] is None:
      continue		
    print(f['departureStation'] + " " + f['date'] + " " +str(f['price']['amount']))

for arg in sys.argv:
  j=open(arg).read()
  doc=json.loads(j)

  printFlights('outboundFlights')
  printFlights('returnFlights')
