#include "totvs.ch"

/*
+===========================================+
| Programa: Tipos de Variaveis              |
| Autor : Felipe Fraga de Assis             |
| Data : 16 de setembro de 2022             |
+===========================================+
*/

user function ativid5()
    Local cRetorno := ""

    cRetorno := FWInputBox("Linguagem de programa��o usada no Protheus?", "")

    if(UPPER(cRetorno) == "ADVPL")

        MsgInfo("Parab�ns! Voc� acertou! **" + cRetorno + "**", "CORRETO")
    Else
        MsgAlert("N�o foi desta vez :(", "SAIR")
    EndIf

return
