up:
	docker compose up -d --build

down:
	docker compose down

build-backend:
	cd backend && yarn build
	cd backend && yarn forever start dist/main.js
stop-backend:
	cd backend && yarn forever stopall