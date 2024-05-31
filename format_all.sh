#!/bin/sh

log_file="format_all.log"

current_date () {
    date --iso-8601='ns' | sed 's/\+.*$//'
}

red='\033[0;31m'
green='\033[0;32m'
bold='\033[1m'
reset='\033[0m'


# clear log file
echo "" > $log_file
# log current date
echo "Format started: $(current_date)" >> $log_file

for file in $(find "scripts" -name "*.gd" -type f); do
    
    echo "Formatting $file"
    echo "$(current_date) formatting $file" >> $log_file
    
    formatter_output=$(gdformat $file)
    if [ $? -ne 0 ]; then
        echo -e "${bold}${red}Error formatting $file. Output written to $log_file${reset}"
        echo $formatter_output >> $log_file
        continue
    fi
    
    # run linter
    linter_error=$(gdlint $file 2>&1 > /dev/null)
    # check if linter failed
    if [ $? -ne 0 ]; then
        echo -e "${bold}${red}Error linting $file. Output written to $log_file${reset}"
        echo $linter_error >> $log_file
    fi
    
    
done

# log current date
echo "Format finished: $(current_date)" >> $log_file