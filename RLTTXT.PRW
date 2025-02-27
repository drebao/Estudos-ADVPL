#include "TOTVS.CH"

User Function RLTTXT()
//+--------------------------------+
//| Declaração de Variáveis |
//+--------------------------------+
Local oGeraTxt
Private cPerg := "SA1PERG"
Private cAlias:= "SA1"
//CriaSx1(cPerg)
Pergunte(cPerg,.F.)
dbSelectArea(cAlias)
dbSetOrder(1)

 

//+-----------------------------------+
//| Montagem da tela de processamento.|
//+-----------------------------------+
DEFINE MSDIALOG oGeraTxt TITLE OemToAnsi("Geração de Arquivo Texto") ;
FROM 000,000 TO 200,400 PIXEL
@ 005,005 TO 095,195 OF oGeraTxt PIXEL
@ 010,020 Say " Este programa ira gerar um arquivo texto, conforme os ;parame- " OF oGeraTxt PIXEL
@ 018,020 Say " tros definidos pelo usuário, com os registros do ; arquivo de "OF oGeraTxt PIXEL
@ 026,020 Say " SA1 " OF oGeraTxt PIXEL
DEFINE SBUTTON FROM 070, 030 TYPE 1 ;
ACTION (OkGeraTxt(),oGeraTxt:End()) ENABLE OF oGeraTxt
DEFINE SBUTTON FROM 070, 070 TYPE 2 ;
ACTION (oGeraTxt:End()) ENABLE OF oGeraTxt
DEFINE SBUTTON FROM 070, 110 TYPE 5 ;
ACTION (Pergunte(cPerg,.T.)) ENABLE OF oGeraTxt
ACTIVATE DIALOG oGeraTxt CENTERED
Return Nil


/*/
+------------------------------------------------------------------
| Função | OKGERATXT | Autor | SERGIO FUZINAKA | Data |
+------------------------------------------------------------------
| Descrição | Função chamada pelo botão OK na tela inicial de
|processamento.
| Executa a geração do arquivo texto.
+-----------------------------------------------------------------
/*/
Static Function OkGeraTxt

//+-----------------------------------------------------------------------//|Cria o arquivo texto
//+-----------------------------------------------------------------------

Private cArqTxt := "\SYSTEM\EXPSA1.TXT"
Private nHdl := fCreate(cArqTxt)
Private cEOL    := "CHR(13)+CHR(10)"

If Empty(cEOL)  
    cEOL := CHR(13)+CHR(10)
Else
    cEOL := Trim(cEOL)
    cEOL := &cEOL
Endif
If nHdl == -1
 MsgAlert("O arquivo de nome "+cArqTxt+" não pode ser executado! Verifique osparâmetros.","Atenção!")
 Return
Endif
// Inicializa a régua de processamento
Processa({|| RunCont() },"Processando...")
Return Nil
//------------------------------------------------------------------
Static Function RunCont

    Local cAliasSA1 := ""
    Local cQuerySA1 := ""
    Local oQuerySA1 := Nil
    Private nTamLin, cLin, cCpo

    // dbSelectArea(cAlias)
    // dbGoTop()
    // ProcRegua(RecCount()) // Numero de registros a processar

    cQuerySA1 := " SELECT * FROM " +RetSqlName("SA1")+ " SA1 "
    cQuerySA1 += " WHERE 1=1 "
    cQuerySA1 += " AND A1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "

    cQuerySA1 := ChangeQuery(cQuerySA1)
    oQuerySA1 := FWPreparedStatement():New(cQuerySA1)
    cQuerySA1 := oQuerySA1:GetFixQUery()

    cAliasSA1 := MPSYSOpenQuery(cQuerySA1)

    (cAliasSA1)->(DbGotop())

    While (cAliasSA1)->(!EOF())
        //Incrementa a régua
        IncProc()
    nTamLin := 165
    cLin    := Space(nTamLin)+cEOL

        cCpo := PADR(Space(5),5)      
        cLin := Stuff(cLin,01,05,cCpo)


        cLin += AllTrim((cAliasSA1)->A1_COD)    +   ";"
        cLin += AllTrim((cAliasSA1)->A1_LOJA)   +   ";"
        cLin += AllTrim((cAliasSA1)->A1_NREDUZ) +   ";"
        cLin += AllTrim((cAliasSA1)->A1_NOME)   +   ";"
        cLin += AllTrim((cAliasSA1)->A1_MUN)    +   ";"
        cLin += AllTrim((cAliasSA1)->A1_CGC)    +   ";"
        cLin += AllTrim((cAliasSA1)->A1_EST)    +   ";"
        cLin += AllTrim((cAliasSA1)->A1_END)    +   ";"
        //cLin += cEOL


        //+-------------------------------------------------------------------+
        //| Gravação no arquivo texto. Testa por erros durante a gravação da |
        //| linha montada. |
        //+-------------------------------------------------------------------+
        If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
            If !MsgAlert("Ocorreu um erro na gravação do arquivo."+;
            "Continua?","Atenção!")
                Exit
            Endif
        Endif
        (cAliasSA1)->(dbSkip())
    EndDo
    // O arquivo texto deve ser fechado, bem como o dialogo criado na função anterior
    fClose(nHdl)


return
/*Static Function SchedDef()

    Local aParam as array
    Local aOrd as array
 
    aParam := {}
    aOrd := {OemToAnsi(" Por Codigo "),OemToAnsi(" Alfabetica ")}
 
    Aadd(aParam, "R"            ) // 01 - Tipo R para relatorio P para processo
    Aadd(aParam, "SA1PERG"      ) // 02 - Pergunte do relatorio, caso nao use passar ParamDef
    Aadd(aParam, "SA1"          ) // 03 - Alias
    Aadd(aParam, aOrd           ) // 04 - Array de ordens
    Aadd(aParam, "Titulo teste" ) // 05 - Titulo
    Aadd(aParam, "report01"     ) // 06 - Nome do relatório (parametro 1 do metodo new da classe TReport)
 
Return aParam


