using Genie
using Genie.Router, Genie.Renderer, Genie.Renderer.Html, Genie.Renderer.Json, Genie.Requests
using SQLite
using JSON
using DataFrames
using JSONTables
include("bd_cadrato.jl")
include("bd_endereco.jl")
include("endereco.jl")
include("conta.jl")

route("/criarUser", method = POST) do 
    cpf = postpayload(:cpf)
    nome =postpayload(:nome)
    senha = postpayload(:senha)
    email = postpayload(:email)
    telefone = postpayload(:telefone)
    if bd_cadrato.verificar_existencia("cpf",cpf) == true
    
      return "CPF já cadrastado"

    elseif bd_cadrato.verificar_existencia("email",email) == true
      return "email já cadrastado"

    elseif bd_cadrato.verificar_existencia("telefone",telefone) == true
    
      return "telefone já cadrastado"

    else
      bd_cadrato.insert(cpf , nome , senha, email , telefone)
      dados = bd_cadrato.consultar("cpf" , cpf)
      println(dados.id_cliente)
      bd_endereco.inseir_id(dados.id_cliente)
      conta.inseir_id(dados.id_cliente)
    end
    return "POST OK"

end

route("/getusers") do
    
  return bd_cadrato.verificar_existencia()
end


up(8002, async = false)
end