#!/usr/bin/env bash
color="color1"
textcolor="color"
tabspace=35
myipadress=0.0.0.0
while getopts c:s:t: flag
do
    case "${flag}" in
        c) color="$OPTARG";;
        s) showcity="$OPTARG";;
        t) showcountry="$OPTARG";;
    esac
done

ipdatafle="/home/nemanja/.config/conky/ipscript/ipdata.json"

printdata ()
{
    echo "\${goto $tabspace}\${$color}Public IP:    \${$textcolor}$(getipfromfile)"
    echo "\${goto $tabspace}\${$color}City:         \${$textcolor}$(getcityfromfile)" 
    echo "\${goto $tabspace}\${$color}Region:       \${$textcolor}$(getregionfromfile)" 
    echo "\${goto $tabspace}\${$color}ZIP code:     \${$textcolor}$(getzipfromfile)" 
    #TODO: Split line: 
#    echo "\${goto $tabspace}\${$color}ISP:          \${$textcolor}$(getispfromfile)" 

#{
#  "ip": "194.28.129.28",
#  "hostname": "ip-194-28-129-28.oriontelekom.rs",
#  "city": "Novi Sad",
#  "region": "Vojvodina",
#  "country": "RS",
#  "loc": "45.2517,19.8369",
#  "org": "AS9125 Drustvo za telekomunikacije Orion telekom doo Beograd-Zemun",
#  "postal": "21102",
#  "timezone": "Europe/Belgrade",
#  "readme": "https://ipinfo.io/missingauth"
#}
}

reloadipdata ()
{
     curl -s GET "https://ipinfo.io/" > $ipdatafle
}

trytogetmyip ()
{
    ip=$(curl -s "www.icanhazip.com")
#    ip=1.1.1.1;
    if expr "$ip" : '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' >/dev/null; then
        echo $ip
    else
        #TODO: Add more links to get my IP 
        echo 0.0.0.0
    fi
}

getipfromfile ()
{
    echo $(jq -r '.ip' $ipdatafle);
}

getcityfromfile ()
{
    echo $(jq -r '.city' $ipdatafle);
}
getregionfromfile ()
{
    echo $(jq -r '.region' $ipdatafle);
}
getzipfromfile ()
{
    echo $(jq -r '.postal' $ipdatafle);
}
getispfromfile ()
{
    echo $(jq -r '.org' $ipdatafle);
}

myipadress=$(trytogetmyip);
if [ $myipadress != 0.0.0.0 ]; then
    ipfromfile=$(getipfromfile);
    if [ $ipfromfile != $myipadress ]; then
        reloadipdata
    fi
    
    printdata
else
    echo "\${goto $tabspace}\${$color}IP get error."
fi
