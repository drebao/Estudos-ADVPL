#include "totvs.ch"
/*
+===========================================+
| Programa: Atribui��es a variaveis         |
| Autor : Felipe Fraga de Assis             |
| Data : 14 de setembro de 2022             |
+===========================================+
*/
User Function ativid3()

    // Tipo Array
    Local aArray := {}

    // Tipo Bloco de c�digo
    Local bBloco := {|| .T.}

    // Tipo Caractere
    Local cCaractere := "Caractere", cMensagem := ""

    // Tipo Data
    Local dData := Date()

    // Tipo L�gico
    Local lLogico := .T.

    // Tipo Num�rico
    Local nNumerico := 1024.2048

    // Tipo Objeto
    Local oObjeto := MSDialog():Create()

    // Tipo N�o definido
    Local uUndefined := Nil

    cMensagem += "[" + ValType(aArray)     + "] Array"
    cMensagem += "[" + ValType(bBloco)     + "] Bloco de c�digo"
    cMensagem += "[" + ValType(cCaractere) + "] Caractere"
    cMensagem += "[" + ValType(dData)      + "] Data"
    cMensagem += "[" + ValType(lLogico)    + "] L�gico"
    cMensagem += "[" + ValType(nNumerico)  + "] Num�rico"
    cMensagem += "[" + ValType(oObjeto)    + "] Objeto"
    cMensagem += "[" + ValType(uUndefined) + "] Undefined"

    // quando estiver debugando quando jogar a variavel cMensagem
    // mostrara os tipos de variaveis nos encontramos

Return()
