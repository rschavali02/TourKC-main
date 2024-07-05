with open("raw.json", "r") as indoc:
    with open("clean.json", "w+") as outdoc:
        outdoc.write(indoc.read().replace('"{', "{\n" + "            ").replace('}"', "\n        }").replace(', \\"', ',\n' + "            " + '"').replace('\\"', '"').replace("isfavorite", "isFavorite").replace("isfeatured", "isFeatured").replace("imagename", "imageName").replace(".jpeg", ""))
