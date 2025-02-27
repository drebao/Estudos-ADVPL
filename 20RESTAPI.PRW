#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'
#Include 'RestFul.CH'

WSRESTFUL CLIENTES DESCRIPTION "SERVIÇO REST CLIENTES"

WSDATA CODCLIENTE As String

WSMETHOD GET DESCRIPTION "Retorna o cliente informado na URL" WSSYNTAX "/CLIENTES || /CLIENTES/{id}"

END WSRESTFUL

WSMETHOD GET WSRECEIVE CODCLIENTE WSSERVICE CLIENTES
Local cCodCli := Self:CODCLIENTE
Local aArea := GetArea()
Local oObjCli := Nil
//Local cStatus := ""
Local cJson := ""

::SetContentType("application/json")

DbSelectArea("SZ1")
SZ1->( DbSetOrder(3) )
If SZ1->( DbSeek( xFilial("SZ1") + cCodCli ) )
alert("oi")
//cStatus := Iif( SZ1->B1_MSBLQL == "1", "Sim", "Nao" )
oObjCli := Clientes(SZ1->Z1_CODIGO, SZ1->Z1_PRNOME)
EndIf

cJson := FWJsonSerialize(oObjCli)

::SetResponse(cJson)

RestArea(aArea)
Return(.T.)
