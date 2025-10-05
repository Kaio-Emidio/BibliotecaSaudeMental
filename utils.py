from mysql.connector import (connection)
from dotenv import load_dotenv
import os

load_dotenv()

def ConectarBD():
    cnx = connection.MySQLConnection(
        user=os.getenv('USERDB'), 
        password=os.getenv('PASSDB'), 
        host='127.0.0.1', 
        database=os.getenv('NAMEDB')
        )
    
    return cnx

def InserirAlterarRemover(sql, dados):
    cnx = ConectarBD()

    cursor = cnx.cursor()

    cursor.execute(sql, dados)
    cnx.commit()

    cnx.close()

def login(usuario, senha):
    cnx = ConectarBD()

    cursor = cnx.cursor(dictionary=True)

    cursor.execute('select id_usuario from usuario where usuario = %s and senha = %s', (usuario, senha))

    resultado = cursor.fetchone()

    cnx.close()

    return resultado