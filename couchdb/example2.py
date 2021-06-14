import couchdb

DB = 'demo'

couch = couchdb.Server('http://persona:service@localhost:5984/')

if DB not in couch:
    db = couch.create(DB)
else:
    db = couch[DB]

for id in db:
    print(db[id])