# 03/01/2021
# Pierre Bourdin
# pierre@pi3rrot.net
#
# This is a very dumb script.
# It can break your routine, and is not fully working...
# I would like to do it with Python, but sometimes, ninjas doesn't have their Katana ;)
# 


#/bin/bash

if [ ! -z $1 ] && [ ! -z $2 ] && [ ! -z $3 ]; then
	if [ "$2" == "start" ] || [ "$2" == "end" ] || [ "$2" == "middle" ]; then
		
		HTTPS_OR_NOT=$(echo $1 | cut -d":" -f1)
		if [ "$HTTPS_OR_NOT" = "http" ] || [ "$HTTPS_OR_NOT" = "https" ]; then
			BUFFER=$(curl -s -L $1)
			#Start with
			if [ "$2" == "start" ]; then
				
				COUNTER=$(echo $BUFFER | grep -oh "$3" | wc -l)

        		for ((i=1; i <= $COUNTER; i++)); do
					PART1=$(echo $BUFFER | awk -F"$3" '{print $2}')
					PART2=$(echo $PART1 | cut -d" " -f1)
					FINALWORD=$3$PART2

                    if [[ "$OLDFINALWORD" != "$FINALWORD" ]]; then
					    echo "[$FINALWORD]"
                        OLDFINALWORD=$FINALWORD
                    else
                        BUFFER=$(echo $BUFFER | sed s/"$3"//)
                    fi
			    done

			fi
			
			if [ "$2" == "end" ]; then
                while $(echo $BUFFER | grep $3 > /dev/null); do

                    PART1=$(echo $BUFFER | awk -F"$3" '{print $1}')
	    			PART2=$(echo $PART1 | rev | cut -d" " -f1 | rev)
                
                    FINALWORD=$PART2$3

                  if [[ "$OLDFINALWORD" != "$FINALWORD" ]]; then
                        echo "[$FINALWORD]"
                        OLDFINALWORD=$FINALWORD
                  else
                        BUFFER=$(echo $BUFFER | sed s/"$FINALWORD"//g)
                    
                  fi
              done

          fi

			
		else 
			echo "Invalid URL"
			exit 1
		fi
		
				
	else 
		echo "Invalid command"
		exit 1	
	fi


fi
