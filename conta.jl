module conta
using SQLite
using DataFrames


#conectar/criar banco de dados
db = SQLite.DB("client.db")

# criar TABLE
SQLite.execute(db,"CREATE TABLE IF NOT EXISTS conta(
    id_cliente INTEGER REFERENCES dados (id_cliente) ON DELETE CASCADE
                                                     ON UPDATE CASCADE
                       UNIQUE,
    n_conta    INTEGER PRIMARY KEY AUTOINCREMENT
                       UNIQUE,
    saldo      REAL    DEFAULT (0),
    agencia    TEXT
)")




function inseir_id(id_cliente)
    SQLite.execute(db,"INSERT INTO conta(id_cliente) VALUES ($id_cliente)")
end


end