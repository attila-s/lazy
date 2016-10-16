#!/usr/bin/python
import sys
import json

sys.argv.pop(0)

def printFlights( flight_type ):
  for f in doc[flight_type]:  
    if f['price'] is None:
      continue
    print(f['departureStation'] + " " + f['arrivalStation'] + " " + f['date'] + " " +str(f['price']['amount']))

for arg in sys.argv:
  try:
    j=open(arg).read()
    doc=json.loads(j)
    printFlights('outboundFlights')
    printFlights('returnFlights')
  except:
    print arg, 'is strange'
