from flask import Flask, render_template, request, redirect, url_for, flash, session
from utils import ConectarBD, InserirAlterarRemover, login, get_info, cad_cont_id
import os

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
        titulo = request.form['titulo']
        sinopse = request.form['sinopse']
        ano = request.form['ano']
        autor = request.form['autor']
        categoria = request.form['categoria']

        id_categoria = {
            'Outro': 0,
            'Artigo': 1,
            'Vídeo': 2,
            'Livro': 3,
            'Podcast': 4
            }.get(categoria, 0)
        
        capa_file = request.files.get('capa')
        arquivo_file = request.files.get('arquivo')

        if ano == '':
            ano = None

        try: 
            sql = 'INSERT INTO conteudo (Titulo, Sinopse, Ano, Capa, URL_Arquivo, ID_Categoria, Autor) \
                VALUES (%s, %s, %s, %s, %s, %s, %s)'
            
            dados = (titulo, sinopse, ano, 0, None, id_categoria, autor)

            id_conteudo = cad_cont_id(sql, dados)
            
            tem_capa = 0
            url_arquivo = None

            if capa_file and capa_file.filename:
                nome, ext = os.path.splitext(capa_file.filename)
                novo_nome_capa = f"{id_conteudo}{ext}"
                caminho_capa = os.path.join('static/assets/capas', novo_nome_capa)
                capa_file.save(caminho_capa)
                tem_capa = 1
            
            if arquivo_file and arquivo_file.filename:
                    nome, ext = os.path.splitext(arquivo_file.filename)
                    novo_nome_arquivo = f"{id_conteudo}{ext}"
                    caminho_arquivo = os.path.join('static/assets/arquivos', novo_nome_arquivo)
                    arquivo_file.save(caminho_arquivo)
                    url_arquivo = caminho_arquivo


            sql = "UPDATE conteudo SET Capa = %s, URL_Arquivo = %s WHERE ID_Conteudo = %s"
            InserirAlterarRemover(sql, (tem_capa, url_arquivo, id_conteudo))

            flash("Conteúdo cadastrado com sucesso!", "success")
        except Exception as e:
            flash(f"Erro ao cadastrar: {e}", "danger")
        return redirect(url_for('cadastro_conteudo'))
    nome_user = session['nome']
    return render_template('cadastro_conteudo.html', nome = nome_user)


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