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

@app.route('/login-concluido', methods=['POST'])
def conf_login():
    # Adicionar a verificação de usuário
    return render_template('index.html')

@app.route('/cadastro-usuario')
def cadastro_usuario():
    return render_template('cadastro_usuario.html')

@app.route('/cadastro-de-usuario-concluido', methods=['POST'])
def conf_cad_user():
    return render_template('login_usuario.html')

@app.route('/cadastro-de-conteudo')
def cadastro_conteudo():
    return render_template('cadastro_conteudo.html')

@app.route('/podcasts')
def pag_podcast():
    return render_template('podcast.html')

@app.route('/livros')
def pag_livros():
    return render_template('livros.html')

@app.route('/video')
def pag_videos():
    return render_template('video.html')

@app.route('/artigo')
def pag_artigos():
    return render_template('artigo.html')

if __name__ == '__main__':
    app.run(debug=True)