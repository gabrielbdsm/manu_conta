using Genie
using Genie.Router, Genie.Renderer, Genie.Renderer.Html, Genie.Renderer.Json, Genie.Requests
using SQLite
using JSON
using DataFrames
using JSONTables

include("confir_Email.jl")

route("/c", method = POST) do 
   
    email = postpayload(:email)
   

    
    if confir_Email.enviar_email(email) != postpayload(:codigo)
      return "codigo de confirmação incorreto"
     end

    return "POST OK"

end





up(8001, async = false)
end