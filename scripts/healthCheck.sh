#!/bin/bash
echo "> Health check 시작"
echo "> curl -s http://localhost:8080/v1/uncomfortable "

for RETRY_COUNT in {1..15}
do
  RESPONSE=$(curl -s http://localhost:8080/v1/uncomfortable)
#  UP_COUNT=$(echo $RESPONSE | grep 'UP' | wc -l)

  if [ $RESPONSE.statuscode -eq 200 ]
  then # $RESPONSE 가 status 200 인지 확인
      echo "> Health check 성공"
      break
  else
      echo "> Health check의 응답을 알 수 없거나 혹은 status가 UP이 아닙니다."
      echo "> Health check: ${RESPONSE}"
  fi

  if [ $RETRY_COUNT -eq 10 ]
  then
    echo "> Health check 실패. "
    exit 1
  fi

  echo "> Health check 연결 실패. 재시도..."
  sleep 10
done
exit 0