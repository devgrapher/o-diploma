.PHONY: push

docker:
	docker-compose build

push:
	aws lightsail push-container-image --region ap-northeast-2 --service-name odiploma  --label odiploma --image odiploma:latest 
