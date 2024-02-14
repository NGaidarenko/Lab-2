#!/bin/bash

ip=$@
numbers=($(echo $ip | tr "." " ")) #Create list with words strip by dot

binarIp(){ # function to convert from binary to decimal
	echo "obase=2; $1" | bc
}

for ((i=0; i<4; i++ )); do 3
 	if [[ $i -eq 3 ]]; then  
 		bin=$(binarIp ${numbers[i]})
        	printf "%08d\n" $bin
 	else  
 		bin=$(binarIp ${numbers[i]})
        	printf "%08d." $bin
 		
 	fi
 done
