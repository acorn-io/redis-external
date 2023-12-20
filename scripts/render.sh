#!/bin/sh

cat > /run/secrets/output<<EOF
services: redis: {
  address: "${address}"
  default: true
  secrets: ["admin"]
  ports: "6379:${port}"
  data: {
    proto: "${proto}"
    dbName: "${dbName}"
  }
}

secrets: admin: {
  type: "basic"
  data: {
    username: "${adminUsername}"
    password: "${adminPassword}"
  }
}
EOF