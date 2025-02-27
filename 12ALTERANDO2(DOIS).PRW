#INCLUDE "TOTVS.CH"
#INCLUDE "TBICONN.CH"

                                 

User Function nome98()

local aarea := fwgetArea()
local adados := {}
local aDadosOrde := {}
private lMSEerrorAuto := .f.
 
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' USER 'Admin' PASSWORD''


adados := {;
    {"B1_COD",   "111111",  nil},;
    {"B1_DESC",     "PRODUTO TESTE",  nil},;
    {"B1_TIPO",       "GG",  nil},;
    {"B1_UM",    "PC",  nil},;
    {"B1_LOCPAD",  "01",  nil},;
    {"B1_PICM",  0,  nil},;
    {"B1_IPI",  0,  nil},;
    {"B1_CONTRAT",  "N",  nil},;
    {"B1_LOCALIZ",  "N",  nil},;
    {"B1_GARANT",  "2",  nil},;
}
    aDadosOrde := FWVetByDic(adados, "SB1")

//INICIO DO CONTROLE DE TRANSAÇÃO
 Begin Transaction
 //chama cadastro de produto
 MsExecAuto({|x,y|Mata010(x,y)},aDados,3)
 //caso ocorra algum erro
 if lMSEerrorAuto
 alert("deu erro")
 MostraErro()

 DisarmTransaction()
 else
    MsgInfo("operaçao finalizada")
    endif

end Transaction

fwrestarea(aarea)

reset environment
Return

//3 inclusao
//4 alteraçao
//5 exclusão
