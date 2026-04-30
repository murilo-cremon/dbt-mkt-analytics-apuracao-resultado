import pandas as pd
from pandas import DataFrame
import numpy as np
from datetime import datetime, timedelta
import os
import random

# Parâmetros de copnfigurações
QTD_LEADS = 50000
TAXA_CONVERSAO = 0.22
DATA_INICIO = datetime(2024, 1, 1)
DATA_FIM = datetime(2024, 3, 31)
SEED = 42
DIRETORIO_SAIDA = "../seeds/raw"

np.random.seed(SEED)
random.seed(SEED)

os.makedirs(DIRETORIO_SAIDA, exist_ok=True)

# Escreve o csv
def escrever_csv(df: DataFrame, nome_arquivo: str) -> None:
    df.to_csv(f"{DIRETORIO_SAIDA}/{nome_arquivo}.csv", index=False)

# Gerador de campanhas
def gerar_campanhas() -> DataFrame:
    campanhas = pd.DataFrame([
        {"campaign_id": 1, "canal": "google", "nome_campanha": "search_brand", "orcamento": 20000},
        {"campaign_id": 2, "canal": "meta", "nome_campanha": "paid_social", "orcamento": 15000},
        {"campaign_id": 3, "canal": "linkedin", "nome_campanha": "b2b_ads", "orcamento": 25000},
    ])

    escrever_csv(campanhas, 'campaigns')
    return campanhas

# Gerador de Leads
def gerar_leads(campanha: DataFrame) -> DataFrame:
    dias_intervalo = (DATA_FIM - DATA_INICIO).days
    campaign_ids = campanha["campaign_id"].values

    leads = pd.DataFrame({
        "lead_id": np.arange(1, QTD_LEADS + 1),
        "user_id": np.arange(100000, 100000 + QTD_LEADS),
        "campaign_id": np.random.choice(campaign_ids, QTD_LEADS),
        "created_at": [
            (DATA_INICIO + timedelta(days=int(x))).date()
            for x in np.random.randint(0, dias_intervalo, QTD_LEADS)
        ]
    })

    leads = leads.merge(campanha[["campaign_id", "canal"]], on="campaign_id", how="left")
    escrever_csv(leads, 'leads')
    
    return leads

# Gerador de Conversões
def gerar_conversao(leads: DataFrame) -> None:
    qtd_convertidos = int(QTD_LEADS * TAXA_CONVERSAO)
    leads_convertidos = leads.sample(n=qtd_convertidos, random_state=SEED)
    dias_para_converter = np.random.randint(1, 15, qtd_convertidos)

    conversions = pd.DataFrame({
        "conversion_id": np.arange(1, qtd_convertidos + 1),
        "lead_id": leads_convertidos["lead_id"].values,
        "converted_at": [
            (data + timedelta(days=int(delta)))
            for data, delta in zip(leads_convertidos["created_at"], dias_para_converter)
        ],
        "revenue": np.round(np.random.uniform(80, 1500, qtd_convertidos), 2)
    })

    escrever_csv(conversions, 'conversions')

# Gerador de AD Spend
def gerar_ad_spend(campanha: DataFrame) -> None:
    datas = pd.date_range(DATA_INICIO, DATA_FIM)
    canais = campanha["canal"].unique()

    linhas_spend = []

    for data in datas:
        for canal in canais:
            multiplicador = {
                "google": 1.2,
                "meta": 1.0,
                "linkedin": 1.5
            }[canal]

            valor = np.random.uniform(200, 800) * multiplicador

            linhas_spend.append({
                "date": data.date(),
                "canal": canal,
                "spend": round(valor, 2)
            })

    ad_spend = pd.DataFrame(linhas_spend)
    escrever_csv(ad_spend, 'ad_spend')

def main():
    campanhas = gerar_campanhas()
    leads = gerar_leads(campanhas)
    gerar_conversao(leads)
    gerar_ad_spend(campanhas)

    print("====================================")
    print("Dados gerados com sucesso!")
    print("====================================")

main()