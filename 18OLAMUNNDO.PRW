#INCLUDE "TOTVS.CH"


User Function fFWGSX5()
    Local aDadosSX5 := {}
    Local nX
    Local cFil := ""
    Local cTab := ""
    Local cChave := ""
    Local cDesc := ""
 
//Abro o ambiente
    //RpcSetType(3)
//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM"
 
//Obt�m os dados da tabela 01 na SX5
    aDadosSX5 := FWGetSX5("01")
 
    For nX:=1 To Len(aDadosSX5)
        //Obt�m a filial(X5_FILIAL)
        cFil := aDadosSX5[nX][1]
        //Obt�m a tabela(X5_TABELA)
        cTab := aDadosSX5[nX][2]
        //Obt�m a chave(X5_CHAVE)
        cChave := aDadosSX5[nX][3]
        //Obt�m a descri��o(X5_DESCRI)
        cDesc := aDadosSX5[nX][4]
 
        //Exibe no console.log
        ConOut("SX5->X5_FILIAL:'" + cFil + "', SX5->X5_TABELA:'" + cTab + "', SX5->X5_CHAVE:'" + cChave + "' , SX5->X5_DESCRI:'" + cDesc + "'")
    Next nX
 
Return




RETURN
