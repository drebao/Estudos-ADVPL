#INCLUDE "TOTVS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "PARMTYPE.CH"	

User Function Modelo1()
Local cAlias := "SB1"
Local cTitulo := "Cadastro - AXCadastro"
Local cVLdExc := .T.
Local CVLDalt := .T.
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' USER 'Admin' PASSWORD''

AxCadastro(cAlias,cTitulo,cVLdExc,CVLDalt)

reset environment
Return NIL

