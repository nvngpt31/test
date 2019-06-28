
import json
itema = 'foo'
itemb = 'bar'
dicta = {"dataseta": {"name":itema}}
dictb = {"datasetb": {"state":itemb}}

# user = {'name': "Trey", 'website': "http://treyhunner.com"}
# defaults = {'name': "Anonymous User", 'page_name': "Profile Page"}

defaults = dicta 
user     = dictb

context = defaults.copy()
context.update(user)

print context
json.dumps(context)
