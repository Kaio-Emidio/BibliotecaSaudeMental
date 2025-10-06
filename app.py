from flask import Flask, render_template, request, redirect, url_for, flash, session
from utils import ConectarBD, InserirAlterarRemover, login, get_info

app = Flask(__name__)
app.secret_key = 'segredo'

# Rota principal
@app.route('/')
def index():
    return redirect(url_for('biblioteca'))

@app.route('/inicio')
def inicio():
    return render_template('inicio.html')

@app.route('/biblioteca')
def biblioteca():
    if 'id' not in session:
        flash('Você precisa fazer login primeiro.', 'error')
        return redirect(url_for('inicio'))
    id_user = session['id']
    nome_user = session['nome']


    return render_template('index.html', id=id_user, nome=nome_user)

@app.route('/login-usuario', methods=['GET','POST'])
def login_usuario():
    if request.method == 'POST':
        usuario = request.form['usuario']
        senha = request.form['senha']

        resultado = login(usuario, senha)

        if resultado:
            infos_user = get_info((resultado['id_usuario'],))

            session['id'] = infos_user['ID_Usuario']
            session['nome'] = infos_user['Nome']
            
            flash('login feito com sucesso!', 'success')
            return redirect(url_for('biblioteca'))
        else:
            flash('Usuário ou senha incorretos.', 'error')
            return redirect(url_for('login_usuario'))
    return render_template('login_usuario.html')

@app.route('/cadastro-usuario', methods=['GET','POST'])
def cadastro_usuario():
    if request.method == 'POST':
        nome = request.form['nome_user']
        usuario = request.form['Usuario']
        senha = request.form['Senha']
        email = request.form['Email_do_User']
        telefone = request.form['Número_telefone']

        if email == '':
            email = None
        if telefone == '':
            telefone = None
        
        sql = 'INSERT INTO usuario (Nome, Usuario, Senha, Email, Telefone) \
            VALUES (%s, %s, %s, %s, %s)'
        
        dados = (nome, usuario, senha, email, telefone)

        InserirAlterarRemover(sql, dados)

        return redirect(url_for('login_usuario'))
    return render_template('cadastro_usuario.html')

@app.route('/logout')
def logout():
    session.clear()
    flash('Você saiu da conta.', 'info')
    return redirect(url_for('login_usuario'))

@app.route('/cadastrar_conteudo', methods=['GET', 'POST'])
def cadastro_conteudo():
    if request.method == 'POST':
        titulo = request.form.get('Nome_do_conteudo')
        sinopse = request.form.get('descricao')
        url = request.form.get('Caminho_para_conteudo')
        capa = request.form.get('Link_para_capa') 
        autor = request.form.get('Autor')
        ano = request.form.get('Data_de_publicacao')
        tipo = request.form.get('tipo_conteudo')
        categoria_id = request.form.get('categoria')

        if capa == '':
            capa = None

        sql = 'INSERT INTO conteudo (Titulo, Sinopse, URL_Arquivo, Autor, Ano, Tipo, ID_Categoria, Capa) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)'
        dados = (titulo, sinopse, url, autor, ano, tipo, categoria_id, capa)

        InserirAlterarRemover(sql, dados)

        return render_template('cadastro_conteudo.html', sucesso=True)

    return render_template('cadastro_conteudo.html')


@app.route('/favoritos')
def favoritos():
    return render_template('favoritos.html')

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