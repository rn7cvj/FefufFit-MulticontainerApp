init:
	git clone https://github.com/azpantic/FefuFitnessAPI.git stable
	git clone https://github.com/Git-GA/fefu-fitness.git FefuFitnessWEB

update:
	cd FefuFitnessAPI
	git pull
	cd ..
	cd FefuFitnessWEB
	git pull
	cd ..

run:
	docker-compose down
	docker-compose up -d

stop:
	docker-compose down

build-run-test:
	docker-compose up --build

build-run-deploy:
	docker-compose up --build -d
	