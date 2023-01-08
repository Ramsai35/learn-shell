  script_location=$(pwd)
  LOG=/tmp/roboshop.log

  status_check() {
    if [ $? -eq 0 ]; then
      echo -e "\e[36m Success\e[0m"
    else
      echo Fail
      echo "refer error log file at,LOG - ${LOG}"
      exit
    fi
  }

  print_head(){
    echo -e "\e[1m $1 \e[0m"
  }