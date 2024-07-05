import json

doc = open("../Resources/landmarkData.json")
data = json.load(doc)
doc.close()

texts = [i["description"] for i in data]