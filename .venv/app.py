from flask import Flask, render_template
import mysql.connector

app = Flask(__name__)

# Configuração do banco de dados
db_config = {
    'host': 'localhost',
    'user': 'root',        # altere se necessário
    'password': 'labinfo',  # coloque sua senha do MySQL
    'database': 'VideosSite'
}

# Rota principal
@app.route('/')
def index():
    try:
        conexao = mysql.connector.connect(**db_config)
        cursor = conexao.cursor(dictionary=True)

        # Pegando o primeiro vídeo do banco
        cursor.execute("SELECT * FROM Video LIMIT 1;")
        video = cursor.fetchone()

        cursor.close()
        conexao.close()

        return render_template('index.html', video=video)

    except Exception as e:
        return f"Erro ao conectar ao banco de dados: {e}"

if __name__ == '__main__':
    app.run(debug=True)
