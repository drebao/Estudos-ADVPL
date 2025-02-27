#include "totvs.ch"
#INCLUDE "TBICONN.CH"


User Function BANCO002()
//local aArea := SB1 -> (getArea())
//local cMsg :=''
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' USER 'Admin' PASSWORD''

DBSelectArea("SB1")
SB1 -> (DBSetOrder(1)) //posiciona n indice 1
SB1 -> (DBGoTop())
//posiciona o produto de codigo 000001
if SB1-> (DBSeek(FWXFilial("SB1") + " 000001"))
FWAlertError(SB1->B1_DESC,"descricao produto")

endif

//RestArea(aArea)


reset environment
return
