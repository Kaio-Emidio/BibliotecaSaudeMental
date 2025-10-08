from flask import Flask, render_template, request, redirect, url_for, flash, session
from utils import ConectarBD, InserirAlterarRemover, login, get_info, cad_cont_id, busca_cards, ajeitar_capa, buscar_conteudos
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

    podcasts = busca_cards(4, 4)
    livros = busca_cards(3, 4)
    videos = busca_cards(2, 4)
    artigos = busca_cards(1, 4)

    ajeitar_capa(livros)
    ajeitar_capa(videos)
    ajeitar_capa(podcasts)
    ajeitar_capa(artigos)


    conexao = ConectarBD()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute("SELECT ID_Conteudo FROM favorito WHERE ID_Usuario = %s", (id_user,))
    favoritos = cursor.fetchall()

    favoritos_ids = [int(f['ID_Conteudo']) for f in favoritos]

    cursor.close()
    conexao.close()

    return render_template(
        'index.html',
        id=id_user,
        nome=nome_user,
        livros=livros,
        videos=videos,
        artigos=artigos,
        podcasts=podcasts,
        favoritos_ids=favoritos_ids  
    )


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
                caminho_capa = os.path.join('static', novo_nome_capa)
                capa_file.save(caminho_capa)
                tem_capa = 1
            
            upload_arquivos = os.path.join('static', 'assets', 'capas')

            if arquivo_file and arquivo_file.filename:
                    nome, ext = os.path.splitext(arquivo_file.filename)
                    novo_nome_arquivo = f"{id_conteudo}{ext}"
                    caminho_arquivo = os.path.join(upload_arquivos, novo_nome_arquivo)
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


# -------- Favoritar um conteúdo --------
@app.route('/favoritar/<int:conteudo_id>', methods=['POST'])
def favoritar(conteudo_id):
    if 'id' not in session:
        flash('Você precisa fazer login primeiro.', 'error')
        return redirect(url_for('login_usuario'))

    id_user = session['id']

    conexao = ConectarBD()
    cursor = conexao.cursor()

    cursor.execute(
        "INSERT IGNORE INTO favorito (ID_Usuario, ID_Conteudo) VALUES (%s, %s)",
        (id_user, conteudo_id)
    )
    conexao.commit()

    cursor.close()
    conexao.close()

    return redirect(url_for('biblioteca'))  # volta para a página da biblioteca

@app.route('/desfavoritar/<int:conteudo_id>', methods=['POST'])
def desfavoritar(conteudo_id):
    if 'id' not in session:
        flash('Você precisa fazer login primeiro.', 'error')
        return redirect(url_for('login_usuario'))

    id_user = session['id']

    conexao = ConectarBD()
    cursor = conexao.cursor()

    cursor.execute(
        "DELETE FROM favorito WHERE ID_Usuario = %s AND ID_Conteudo = %s;",
        (id_user, conteudo_id)
    )
    conexao.commit()

    cursor.close()
    conexao.close()

    return redirect(url_for('biblioteca'))  # volta para a página da biblioteca


# -------- Página de favoritos --------
@app.route('/favoritos')
def pagina_favoritos():
    if 'id' not in session:
        flash('Você precisa fazer login primeiro.', 'error')
        return redirect(url_for('login_simples'))

    id_user = session['id']
    nome_user = session['nome']

    conexao = ConectarBD()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute("""
        SELECT c.ID_Conteudo, c.Titulo, c.Sinopse, c.URL_Arquivo, c.ID_Categoria, c.Capa
        FROM conteudo c
        INNER JOIN favorito f ON c.ID_Conteudo = f.ID_Conteudo
        WHERE f.ID_Usuario = %s
    """, (id_user,))
    favoritos = cursor.fetchall()
    cursor.close()
    conexao.close()

    ajeitar_capa(favoritos)

    return render_template('favoritos.html', favoritos=favoritos, nome=nome_user)


@app.route('/conteudos')
def pag_conteudos():
    tipo = request.args.get('tipo', 'podcast')  # padrão: podcast

    if tipo == 'podcast':
        conteudos = busca_cards(4, None)
    elif tipo == 'livro':
        conteudos = busca_cards(3, None)
    elif tipo == 'video':
        conteudos = busca_cards(2, None)
    elif tipo == 'artigo':
        conteudos = busca_cards(1, None)
    else:
        conteudos = []

    ajeitar_capa(conteudos)
    return render_template('conteudos.html', tipo=tipo, conteudos=conteudos)

@app.route('/pesquisa')
def pesquisa():
    nome_user = session['nome']
    termo = request.args.get('q', '').strip()

    resultados = []
    if termo:
        resultados = buscar_conteudos(termo)
        ajeitar_capa(resultados)

    return render_template('pesquisa.html', termo=termo, resultados=resultados, nome=nome_user)

@app.route('/arquivo/<int:idconteudo>')
def arquivo(idconteudo):
    cnx = ConectarBD()
    cursor = cnx.cursor(dictionary=True)
    cursor.execute("SELECT * FROM conteudo WHERE ID_Conteudo = %s", (idconteudo,))
    conteudo = cursor.fetchone()
    cnx.close()

    if not conteudo:
        return "Conteúdo não encontrado.", 404

    url_arquivo = conteudo.get("URL_Arquivo")

    if not url_arquivo:
        return "Arquivo não encontrado.", 404

    # 🧠 Corrige caminho (troca \ por /)
    url_arquivo = url_arquivo.replace("\\", "/")

    # Detecta extensão
    extensao = os.path.splitext(url_arquivo)[1].lower()

    if extensao in [".mp4", ".webm", ".ogg"]:
        tipo = "video"
    elif extensao in [".mp3", ".wav", ".aac"]:
        tipo = "audio"
    elif extensao in [".pdf"]:
        tipo = "pdf"
    elif extensao in [".jpg", ".jpeg", ".png", ".gif", ".webp"]:
        tipo = "imagem"
    else:
        tipo = "outro"

    return render_template("arquivo.html", conteudo=conteudo, tipo=tipo, url_arquivo=url_arquivo)


if __name__ == '__main__':
    app.run(debug=True)