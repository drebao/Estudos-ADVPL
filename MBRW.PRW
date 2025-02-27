#INCLUDE "TOTVS.CH"

User Function MBRW()

Local cAlias := "SZ4"
Private cCadastro := "Cadastro de Produtos"

Private aRotina := {}

AADD(aRotina,{"Incluir" ,"AxInclui",0,3})
AADD(aRotina,{"Alterar" ,"AxAltera",0,4})
AADD(aRotina,{"Excluir" ,"AxDeleta",0,5})



dbSelectArea(cAlias)
dbSetOrder(1)
mBrowse(,,,,cAlias)


Return
