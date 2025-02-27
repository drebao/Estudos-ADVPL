#include "totvs.ch"
#include "tbiconn.ch"
#include "protheus.ch"
#include "parmtype.ch"

User Function modelo2()
local calias := "SB1"
Private ctitulo := "cadastro de produtos MBROWSE"
Private arotina := {}
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' USER 'Admin' PASSWORD''


AAdd(arotina,{"pesquisar",   "axpesqui"   ,0,1})
AAdd(arotina,{"visualizar",  "axvisual"  ,0,2})
AAdd(arotina,{"incluir",     "axinclui"     ,0,3})
AAdd(arotina,{"alterar",     "axaltera"     ,0,4})
AAdd(arotina,{"excluir",     "axdeleta"     ,0,5}) 
AAdd(AROTINA,{"ola mundo",   "U_OLAMUNDO"  ,0,6})

DBSelectArea(cAlias)
DBSetOrder(1)
mBrowse(,,,,cAlias)


reset environment

RETURN NIL
