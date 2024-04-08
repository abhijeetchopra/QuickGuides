# QuickGuide | MongoDB

<https://www.mongodb.com/try/download/community>

## Intro

NoSQL Document Database

CAP Theorem

- Consistency
- Availability
- Partition tolerance

MongoDB - C,P but not A; hence run in cluster of 3 nodes

## Run MongoDB locally

Easiest way is to run a detached docker container running a standalone mongodb

```bash
docker run -d --rm --name mongo-test -p 27017:27017 mongo:latest
```

To connect to database in above container using GUI based MongoDB Compass:

```bash
mongodb://localhost:27017
```

To shell into above container to run cli commands using MongoDB Shell (mongosh):

```bash
docker exec -it mongo-test mongosh
```

## Commands

CRUD Operations

- C - Create `dbcollection.insertOne()`
- R - Read `db.collection.find()`
- U - Update `db.collection.updateOne()`
- D - Delete `db.collection.deleteOne()`

Examples

```bash

# show databases
show dbs

# show collections
show collections

# create database
use my_database

# create collections
db.createCollection("my_collection")

# insert record
db.collection.insertOne(
    {
        "firstName": "John",
        "lastName": "Doe"
    }
)

# insert multiple records
db.collection.insertMany([
    {
        "firstName": "John",
        "lastName": "Doe"
    },
    {
        "firstName": "Jane",
        "lastName": "Doe"
    },
    {
        "firstName": "Jim",
        "lastName": "Smith"
    }
])

# read / find all record
db.collection.find()

# read / find record with filter
db.collection.find({"firstName" : "John"})

# update record
db.collection.updateOne()

# delete record
db.collection.deleteOne()

```
