import pickle
from load_data import data
import json

with open("./kmean46.pkl", "rb") as doc:
    clf = pickle.load(doc)

group2data = {}
data2group = {}

for i, n in zip(data, clf.labels_.tolist()):
    if n in group2data:
        group2data[n].append(i["name"])
    else:
        group2data[n] = [i["name"]]
    data2group[i["name"]] = n

new_data = []

for i in data:
    i["like"] = list(filter(lambda e: e != i["name"], group2data[data2group[i["name"]]]))
    new_data.append(i)

with open("./data_with_like.json", "w+") as doc:
    json.dump(new_data, doc, indent=4)