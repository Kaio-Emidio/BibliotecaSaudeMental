from flask import Flask, render_template
# import mysql.connector

app = Flask(__name__)

# Configuração do banco de dados
# db_config = {
#     'host': 'localhost',
#     'user': 'root',
#     'password': 'labinfo',
#     'database': 'VideosSite'
# }

# Rota principal
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/login-usuario')
def login_usuario():
    return render_template('login_usuario.html')

@app.route('/cadastro-usuario')
def cadastro_usuario():
    return render_template('cadastro.html')

@app.route('/cadastro-de-conteudo')
def cadastro_conteudo():
    return render_template('cadastro_conteudo.html')

if __name__ == '__main__':
    app.run(debug=True)