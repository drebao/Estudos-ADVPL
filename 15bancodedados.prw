#INCLUDE "TOTVs.CH"
#INCLUDE "TBICONN.CH"

USER FUNCTION BANCO001()
 //local aarea := SB1 -> (getarea())
local cmsg :=''
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' USER 'Admin' PASSWORD''


DBSelectArea("SB1")
SB1 -> (DBSetOrder(1))
SB1 -> (DBGoTop())

cMsg := posicione(  'SB1',;                  // Tabela chamada
                    1,;                      // Indice da Tabela (SIX --> Tabela de indices)
            FWXFilial('SB1')+ ' 000001',;    // Dados para posicionamento do registro
                             'B1_DESC')      // Retorno da conuslta
    FWAlertError("descricao produto:"+ cMsg,"produto 000001")
     //RestArea(aarea)                         

RESET ENVIRONMENT
RETURN



