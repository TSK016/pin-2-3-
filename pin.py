import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
from mysql.connector import Error


def connect_to_database():
    """Conecta ao banco de dados MySQL."""
    try:
        connection = mysql.connector.connect(
            host='localhost',  # Altere para o seu host
            user='root',       # Altere para seu usuário
            password='',       # Altere para sua senha
            database='dbpin'   # Altere para seu banco de dados
        )
        if connection.is_connected():
            print("Conexão com o banco de dados estabelecida com sucesso.")
            return connection
    except Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None


def read_tables(connection):
    """Lê dados das tabelas RelatorioMensal e Vendas."""
    try:
        relatorio_query = "SELECT * FROM RelatorioMensal"
        relatorio_df = pd.read_sql(relatorio_query, connection)

        vendas_query = "SELECT * FROM Vendas"
        vendas_df = pd.read_sql(vendas_query, connection)

        return relatorio_df, vendas_df
    except Error as e:
        print(f"Erro ao ler as tabelas: {e}")
        return None, None


def plot_graficos(relatorio_df, vendas_df, option):
    """Gera os gráficos baseados na opção."""
    if option == 1:
        # Gráfico 1: Total de Ganhos por Mês (RelatorioMensal)
        plt.figure(figsize=(10, 6))
        relatorio_df['MesAno'] = relatorio_df['Mes'].astype(str) + '/' + relatorio_df['Ano'].astype(str)
        plt.bar(relatorio_df['MesAno'], relatorio_df['TotalGanho'], color='green')
        plt.title("Total de Ganhos por Mês", fontsize=16)
        plt.xlabel("Mês/Ano", fontsize=12)
        plt.ylabel("Total Ganho (R$)", fontsize=12)
        plt.xticks(rotation=45, ha='right')
        plt.tight_layout()
        plt.show()

    elif option == 2:
        # Gráfico 2: Vendas por Produto (Vendas)
        plt.figure(figsize=(10, 6))
        vendas_data = vendas_df.groupby('Produto')['Valor'].sum().reset_index()
        plt.bar(vendas_data['Produto'], vendas_data['Valor'], color='blue')
        plt.title("Vendas por Produto", fontsize=16)
        plt.xlabel("Produto", fontsize=12)
        plt.ylabel("Valor Total de Vendas (R$)", fontsize=12)
        plt.xticks(rotation=45, ha='right')
        plt.tight_layout()
        plt.show()

def main():
    """Função principal que apresenta um menu ao usuário para selecionar a funcionalidade desejada."""
    connection = connect_to_database()  # Conecta ao banco de dados

    if connection:
        relatorio_df, vendas_df = read_tables(connection)  # Lê tabelas inicialmente

        if relatorio_df is None or vendas_df is None:
            print("Erro ao carregar as tabelas. Verifique a conexão ou os dados do banco.")
            return

        while True:
            print("\nEscolha uma opção:")
            print("1. Exibir gráfico de ganhos por mês (RelatorioMensal)")
            print("2. Exibir gráfico de vendas por produto (Vendas)")
            print("3. Sair\n")
            choice = input("Digite o número da opção: ")

            if choice == '1':
                print("\nGerando gráfico de ganhos por mês...")
                plot_graficos(relatorio_df, vendas_df, option=1)

            elif choice == '2':
                print("\nGerando gráfico de vendas por produto...")
                plot_graficos(relatorio_df, vendas_df, option=2)

            elif choice == '3':
                print("\nSaindo...")
                break

            else:
                print("Opção inválida. Tente novamente.")

        connection.close()  # Fecha a conexão com o banco de dados


if __name__ == "__main__":
    main()
