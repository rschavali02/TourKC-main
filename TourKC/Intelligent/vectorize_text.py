from sklearn.feature_extraction.text import TfidfVectorizer
from load_data import texts
import re
import string

def preprocessing(line):
    line = line.lower()
    line = re.sub(r"[{}]".format(string.punctuation), " ", line)
    return line

izer = TfidfVectorizer(preprocessor=preprocessing)
vec = izer.fit_transform(texts)