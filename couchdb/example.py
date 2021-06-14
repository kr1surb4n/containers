import couchdb

DB = 'demo'

couch = couchdb.Server('http://persona:service@localhost:5984/')

if DB not in couch:
    db = couch.create(DB)
else:
    db = couch[DB]

test_doc = { 'a': 1, 'b': 2, 'c': 3}
db.save(test_doc)