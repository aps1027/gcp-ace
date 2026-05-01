# Auth MS
## Create migrate file
```
npx prisma migrate dev --schema=databases/auth/schema.prisma
```

## Reset DB
```
npx prisma migrate reset --force --schema=databases/auth/schema.prisma
```

## Run seed
```
node databases/auth/seed.ts
```

# Development
## Install packages
```
yarn
```

## Format
```
yarn lint
yarn format
```

## Generate Proto TS
```
cd protos
# for linux
sh build.sh

# for windows
sh build-windows.sh
```

## Start MS
```
# start auth ms
npx prisma migrate deploy --schema=databases/auth/schema.prisma
npx prisma generate --schema=databases/auth/schema.prisma
npx nest start auth -- watch

# start api gateway
npx nest start --watch
```

## Docker
```
docker compose up --build
docker compose exec auth node databases/auth/seed.ts
```