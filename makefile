up:
	docker compose up -d --build

down:
	docker compose down

start:
	cd backend && yarn install
	cd backend && yarn build
	cd backend && yarn forever start dist/main.js
stop:
	cd backend && yarn forever stopall