import streamlit as st
import requests
import pandas as pd
from io import BytesIO

st.set_page_config(page_title="Collezione Magic", layout="wide")

DATA_FILE = "collezione.csv"

# -------------------------------
# Funzioni di supporto
# -------------------------------

def cerca_carte(query, max_pagine=2):
    """Cerca carte su Scryfall in base a una query (es: type:dragon)"""
    url = f"https://api.scryfall.com/cards/search?q={query}"
    tutte = []
    pagina = 1

    while url and pagina <= max_pagine:
        r = requests.get(url)
        data = r.json()
        tutte.extend(data["data"])
        url = data.get("next_page")
        pagina += 1

    risultati = []
    for c in tutte:
        img = c.get("image_uris", {}).get("normal") if c.get("image_uris") else None
        risultati.append({
            "Nome": c.get("name"),
            "Rarità": c.get("rarity"),
            "Edizione": c.get("set_name"),
            "Immagine": img,
            "ID": c.get("id")
        })
    return risultati


def carica_collezione():
    try:
        return pd.read_csv(DATA_FILE)
    except FileNotFoundError:
        return pd.DataFrame(columns=["ID", "Nome", "Rarità", "Edizione", "Immagine", "Posseduta"])


def salva_collezione(df):
    df.to_csv(DATA_FILE, index=False)


# -------------------------------
# UI Streamlit
# -------------------------------

st.title("🧙‍♂️ Gestore Collezione Magic: The Gathering")

query = st.text_input("Cerca carte (es: type:dragon, name:elf, set:cmr):", "type:dragon")
if st.button("Cerca su Scryfall"):
    with st.spinner("Cerco carte..."):
        carte = cerca_carte(query)
        st.session_state["carte_trovate"] = carte

# Mostra risultati
if "carte_trovate" in st.session_state:
    carte = st.session_state["carte_trovate"]

    st.subheader(f"Risultati trovati: {len(carte)}")

    collezione = carica_collezione()

    for carta in carte:
        col1, col2, col3 = st.columns([1, 3, 1])

        with col1:
            if carta["Immagine"]:
                st.image(carta["Immagine"], width=120)
            else:
                st.write("❌ Nessuna immagine")

        with col2:
            st.markdown(f"**{carta['Nome']}**")
            st.write(f"Rarità: {carta['Rarità'].capitalize()}")
            st.write(f"Edizione: {carta['Edizione']}")

        with col3:
            posseduta = bool(
                (collezione["ID"] == carta["ID"]).any() and
                collezione.loc[collezione["ID"] == carta["ID"], "Posseduta"].iloc[0]
            )
            nuova_val = st.checkbox("Posseduta", value=posseduta, key=carta["ID"])

            # aggiorna CSV in tempo reale
            if nuova_val and not posseduta:
                collezione = pd.concat([collezione, pd.DataFrame([{
                    "ID": carta["ID"],
                    "Nome": carta["Nome"],
                    "Rarità": carta["Rarità"],
                    "Edizione": carta["Edizione"],
                    "Immagine": carta["Immagine"],
                    "Posseduta": True
                }])], ignore_index=True)
                salva_collezione(collezione)

            elif not nuova_val and posseduta:
                collezione = collezione[collezione["ID"] != carta["ID"]]
                salva_collezione(collezione)

    st.success("✅ Collezione aggiornata!")


# -------------------------------
# Visualizza collezione
# -------------------------------

st.divider()
st.subheader("📜 La tua collezione")

df = carica_collezione()
if df.empty:
    st.info("Nessuna carta ancora nella collezione.")
else:
    for _, row in df.iterrows():
        col1, col2 = st.columns([1, 4])
        with col1:
            if row["Immagine"]:
                st.image(row["Immagine"], width=100)
        with col2:
            st.markdown(f"**{row['Nome']}** ({row['Edizione']}) - {row['Rarità'].capitalize()}")
