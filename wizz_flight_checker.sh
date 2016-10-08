#!/bin/bash

cat > destinations.txt <<END
Alghero (Sardinia)	AHO
Alicante	ALC
Baku	GYD
Barcelona El Prat	BCN
Bari	BRI
Bergen	BGO
Birmingham	BHX
Bologna	BLQ
Bourgas (Black Sea)	BOJ
Brussels Charleroi	CRL
Bucharest	OTP
Catania (Sicily)	CTA
Corfu	CFU
Dortmund	DTM
Dubai	DWC
Eindhoven	EIN
Faro	FAO
Frankfurt Hahn	HHN
Fuerteventura (Canary Islands)	FUE
Glasgow	GLA
Gothenburg Landvetter	GOT
Hanover	HAJ
Heraklion (Crete)	HER
Ibiza	IBZ
Karlsruhe/Baden-Baden	FKB
Kutaisi (Georgia)	KUT
Kyiv Zhulyany	IEV
Lamezia Terme	SUF
Lanzarote (Canary Islands)	ACE
Larnaca (Cyprus)	LCA
Lisbon	LIS
Liverpool	LPL
London Luton	LTN
Madrid	MAD
Malaga	AGP
Malmo	MMX
Malta	MLA
Milan Malpensa	MXP
Moscow	VKO
Naples	NAP
Nice	NCE
Palma de Mallorca	PMI
Porto Airport	OPO
Reykjavik	KEF
Rhodes	RHO
Riga	RIX
Rome Fiumicino	FCO
Sofia	SOF
Stockholm Skavsta	NYO
Targu Mures	TGM
Tel Aviv	TLV
Tenerife (Canary Islands)	TFS
Thessaloniki	SKG
Varna (Black Sea)	VAR
Warsaw Chopin	WAW
Zakynthos	ZTH
Alghero (Sardinia)	AHO
Alicante	ALC
Baku	GYD
Barcelona El Prat	BCN
Bari	BRI
Bergen	BGO
Birmingham	BHX
Bologna	BLQ
Bourgas (Black Sea)	BOJ
Brussels Charleroi	CRL
Bucharest	OTP
Catania (Sicily)	CTA
Corfu	CFU
Dortmund	DTM
Dubai	DWC
Eindhoven	EIN
Faro	FAO
Frankfurt Hahn	HHN
Fuerteventura (Canary Islands)	FUE
Glasgow	GLA
Gothenburg Landvetter	GOT
Hanover	HAJ
Heraklion (Crete)	HER
Ibiza	IBZ
Karlsruhe/Baden-Baden	FKB
Kutaisi (Georgia)	KUT
Kyiv Zhulyany	IEV
Lamezia Terme	SUF
Lanzarote (Canary Islands)	ACE
Larnaca (Cyprus)	LCA
Lisbon	LIS
Liverpool	LPL
London Luton	LTN
Madrid	MAD
Malaga	AGP
Malmo	MMX
Malta	MLA
Milan Malpensa	MXP
Moscow	VKO
Naples	NAP
Nice	NCE
Palma de Mallorca	PMI
Porto Airport	OPO
Reykjavik	KEF
Rhodes	RHO
Riga	RIX
Rome Fiumicino	FCO
Sofia	SOF
Stockholm Skavsta	NYO
Targu Mures	TGM
Tel Aviv	TLV
Tenerife (Canary Islands)	TFS
Thessaloniki	SKG
Varna (Black Sea)	VAR
Warsaw Chopin	WAW
Zakynthos	ZTH
END

export day=2017-04-01; 

for i in $(seq 1 25); do 
  day=$(date '+%Y-%m-%d' -d "$day+10 days"); 
  echo $day; 
  curl 'https://be.wizzair.com/3.3.2/Api/asset/farechart' -H 'pragma: no-cache' -H 'origin: https://wizzair.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.8' -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36' -H 'content-type: application/json' -H 'accept: application/json, text/plain, */*' -H 'cache-control: no-cache' -H 'authority: be.wizzair.com' -H 'cookie: ASP.NET_SessionId=2daurb0kdarwj4lokgrvxznn; _ga=GA1.2.578244284.1475920242; _gat=1' -H 'referer: https://wizzair.com/' --data-binary '{"wdc":false,"flightList":[{"departureStation":"BUD","arrivalStation":"FAO","date":"'$day'"},{"departureStation":"FAO","arrivalStation":"BUD","date":"'$day'"}],"dayInterval":10}' --compressed | tee $day.out
  sleep $(( ( RANDOM % 3 )  + 1 ))
 done
