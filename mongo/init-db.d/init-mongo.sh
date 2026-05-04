#!/bin/bash

## Set new user to database
mongosh $MONGO_DB -u $MONGO_INITDB_ROOT_USERNAME -p $MONGO_INITDB_ROOT_PASSWORD --eval "db.createUser({ user: '$MONGO_DB_USERNAME', pwd:  '$MONGO_DB_PASSWORD', roles: [{ role: 'readWrite', db: '$MONGO_DB'}]})" --authenticationDatabase admin

## Seed Users and Contacts into database
mongosh $MONGO_DB <<EOF 
    var rootUser = '$MONGO_INITDB_ROOT_USERNAME';
    var rootPassword = '$MONGO_INITDB_ROOT_PASSWORD';
    var admin = db.getSiblingDB('$MONGO_INITDB_DATABASE');
    admin.auth(rootUser, rootPassword);

db.users.drop();
db.users.insertMany([
  {
    "_id": ObjectId("6759daeb097c7d69426b7649"),
    "create_date": new Date("2024-12-11T19:29:19.895Z"),
    "username": "pushkarwani63@gmail.com",
    "email": "pushkarwani63@gmail.com",
    "password": "\$2a\$10\$nc0yO2eeCDOLg6sObsAHfuXQY8NnCrhHz5GbkmPYsAGLsQoSZa.qm",
    "firstName": "Pushkar",
    "lastName": "Wani"
  }
]);

db.contacts.drop();
db.contacts.insertMany([
  {
    "_id": ObjectId("6759daeb097c7d69426b7641"),
    "firstName": "Pushkar",
    "lastName": "Wani",
    "mobile": "9876543243",
    "email": "pushkarwani63@gmail.com",
    "city": "Mumbai",
    "postalCode": "421201",
    "create_date": new Date()
  },
  {
    "_id": ObjectId("6759daeb097c7d69426b7650"),
    "firstName": "Sachin",
    "lastName": "Singh",
    "mobile": "9876540000",
    "email": "sachin@gmail.com",
    "city": "Pune",
    "postalCode": "421201",
    "create_date": new Date()
  },
  {
    "_id": ObjectId("6759daeb097c7d69426b7651"),
    "firstName": "Vikram",
    "lastName": "Kumar",
    "mobile": "9876541111",
    "email": "vikram@gmail.com",
    "city": "Delhi",
    "postalCode": "110001",
    "create_date": new Date()
  },
  {
    "_id": ObjectId("6759daeb097c7d69426b7652"),
    "firstName": "Priya",
    "lastName": "Sharma",
    "mobile": "9876542222",
    "email": "priya@gmail.com",
    "city": "Bangalore",
    "postalCode": "560001",
    "create_date": new Date()
  },
  {
    "_id": ObjectId("6759daeb097c7d69426b7653"),
    "firstName": "Amit",
    "lastName": "Patel",
    "mobile": "9876543333",
    "email": "amit@gmail.com",
    "city": "Ahmedabad",
    "postalCode": "380001",
    "create_date": new Date()
  }
]);

print("Database seeding completed successfully!");
print("Users created: " + db.users.countDocuments());
print("Contacts created: " + db.contacts.countDocuments());

EOF
