#!/usr/bin/python
import sys
import json

sys.argv.pop(0)

for arg in sys.argv:
  j=open(arg).read()
  doc=json.loads(j)

  for f in doc['outboundFlights']:  
    if f['price'] is None:
      continue	
    print(f['date'] + " " +str(f['price']['amount']))
