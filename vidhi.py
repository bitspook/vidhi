import spacy as sp

nlp = sp.load("de_dep_news_trf")

def words(text):
    return [
        {
            "text": w.text,
            "lemma": w.lemma_,
            "pos": w.pos_,
            "tag": w.tag_,
            "dep": w.dep_,
            "is_alpha": w.is_alpha
        } for w in nlp(text)]
