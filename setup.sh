echo "=====> Building DB Service"
docker-compose build --no-cache db
echo "=====> Starting DB Service"
docker-compose up -d db
echo "=====> Building Backend Service"
docker-compose build --no-cache backend || { echo 'Backend build failed' ; exit 1; }
echo "=====> Seting up Backend Databases"
docker-compose run --rm --no-deps backend rake db:setup || { echo 'Database setup failed' ; exit 1; }
echo "=====> Starting Backend Service"
docker-compose up -d backend