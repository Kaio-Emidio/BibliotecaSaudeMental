from flask import Flask, render_template, request
from utils import ConectarBD, InserirAlterarRemover

app = Flask(__name__)

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
    nome = request.form.get('nome_user')
    usuario = request.form.get('Usuario')
    senha = request.form.get('Senha')
    email = request.form.get('Email_do_User')
    telefone = request.form.get('Número_telefone')

    if email == '':
        email = None
    if telefone == '':
        telefone = None

    sql = 'INSERT INTO usuario (Nome, Usuario, Senha, Email, Telefone) \
        VALUES (%s, %s, %s, %s, %s)'
    
    dados = (nome, usuario, senha, email, telefone)

    InserirAlterarRemover(sql, dados)

    return render_template('login_usuario.html')

@app.route('/cadastrar_conteudo', methods=['GET', 'POST'])
def conf_cad_cont():
    if request.method == 'POST':
        nome = request.form.get('Nome_do_conteudo')
        sinopse = request.form.get('descricao')
        url = request.form.get('Caminho_para_conteudo')
        capa = request.form.get('Link_para_capa') or None
        autor = request.form.get('Autor')
        data = request.form.get('Data_de_publicacao')
        categoria = request.form.get('tipo_conteudo')

        sql = 'INSERT INTO conteudo (Nome, sinopse, url, capa, autor, data, categoria) VALUES (%s, %s, %s, %s, %s, %s, %s)'
        dados = (nome, sinopse, url, capa, autor, data, categoria)
        InserirAlterarRemover(sql, dados)

        return render_template('cadastro_conteudo.html', sucesso=True)

    return render_template('cadastro_conteudo.html')

@app.route('/favoritos')
def favoritos():
    return render_template('favoritos.html')

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