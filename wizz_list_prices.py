#!/usr/bin/python
import sys
import json
import datetime

sys.argv.pop(0)

def printFlights( flight_type ):
  for f in doc[flight_type]:  
    if f['price'] is None:
      continue
    flight_date = f['date']
    weekday = datetime.datetime.strptime(flight_date, "%Y-%m-%dT%H:%M:%S").isoweekday()
    weekday = datetime.datetime.strptime(flight_date, "%Y-%m-%dT%H:%M:%S").strftime("%A")
    print(f['departureStation'] + " " + f['arrivalStation'] + " " + flight_date + " " + str(weekday) + "\t" + str(f['price']['amount']))

for arg in sys.argv:
  try:
    j=open(arg).read()
    doc=json.loads(j)
    printFlights('outboundFlights')
    printFlights('returnFlights')
  except:
    print arg, 'is strange'
