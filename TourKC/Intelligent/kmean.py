from vectorize_text import vec
import pickle

CONSTRAINED = False

class KM(object):
    def __init__(self, model, counts):
        self.model = model
        self.counts = counts

if CONSTRAINED:
    def get_kmean():
        from k_means_constrained import KMeansConstrained

        clf = KMeansConstrained(
            n_clusters=10,
            size_min=5,
            size_max=5
        )

        clf.fit_predict(vec)
        #print(clf.cluster_centers_)
        #print(clf.labels_)
        la = clf.labels_.tolist()
        cts = [la.count(i) for i in range(10)]
        return KM(clf, cts)
else:
    def get_kmean():
        from sklearn.cluster import KMeans
        
        clf = KMeans(n_clusters=10)

        clf.fit_predict(vec)
        #print(clf.cluster_centers_)
        #print(clf.labels_)
        la = clf.labels_.tolist()
        cts = [la.count(i) for i in range(15)]
        return KM(clf, cts)

if __name__ == "__main__":
    km = KM(None, [0])
    i = 0
    while not (max(km.counts) in [3, 4, 5] and min(km.counts) in [5, 6, 7]):
        i += 1
        print("Iteration:", i, end="\r")
        km = get_kmean()
    print(km.model.labels_, km.counts)
    with open("kmean46.pkl", "wb") as doc:
        pickle.dump(km.model, doc)
    