temperature_sda=$(smartctl -A /dev/sda | grep Temperature | awk '{print $10}')
temperature_sdb=$(smartctl -A /dev/sdb | grep Temperature_Celsius | awk '{print $10}')

crypto=$(curl -s -X GET "https://api.coingecko.com/api/v3/simple/price?ids=dogecoin&vs_currencies=usd" -H "accept: application/json")
doge_price=$(echo $crypto | jq -r '.dogecoin.usd')

mosquitto_pub -t mqtt_monitoring/host/temperature_sda -m "$temperature_sda" 
mosquitto_pub -t mqtt_monitoring/host/temperature_sdb -m "$temperature_sdb" 

mosquitto_pub -t mqtt_monitoring/crypto/$doge_price -m "$doge_price" 