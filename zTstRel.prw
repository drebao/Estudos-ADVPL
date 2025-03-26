//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"
#Include "RPTDef.ch"
#Include "FWPrintSetup.ch"
#INCLUDE"TBICONN.CH"
 
//Alinhamentos
#Define PAD_LEFT    0
#Define PAD_RIGHT   1
#Define PAD_CENTER  2
 
//Cores
#Define COR_CINZA   RGB(180, 180, 180)
#Define COR_PRETO   RGB(000, 000, 000)
 
//Colunas
#Define COL_GRUPO 0015   
#Define COL_DESCR 0095

/*/{Protheus.doc} zTstRel
Exemplos de FWMSPrinter
@author oi 
@since 27/01/2019
@version 1.0
@type function
/*/
 
User Function zTstRel()
    Local aArea := GetArea()
    if SELECT("SX2") == 0
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' USER 'Admin' PASSWORD'123456'
    end if
     
    //Se a pergunta for confirmada
    If MsgYesNo("Deseja gerar o relatório de grupos de produtos?", "Atenção")
        Processa({|| fMontaRel()}, "Processando...")
    EndIf
     
    RestArea(aArea)
    if SELECT("SX2") > 0
		RESET ENVIRONMENT
	endif
Return
 
/*---------------------------------------------------------------------*
 | Func:  fMontaRel                                                    |
 | Desc:  Função que monta o relatório                                 |
 *---------------------------------------------------------------------*/
 
Static Function fMontaRel()
    Local cCaminho    := ""
    Local cArquivo    := ""
    Local cQryAux     := ""
    Local nAtual      := 0
    Local nTotal      := 0
    //Linhas e colunas

    Private nLinAtu    := 180
    Private nTamLin    := 010
    Private nLinbox    := 500
    Private nLinFin    := 820
    Private nColIni    := 010
    Private nColFin    := 550
    Private nColMeio   := (nColFin-nColIni)/2
    //Objeto de Impressão
    Private oPrintPvt
    //Variáveis auxiliares
    Private dDataGer  := Date()
    Private cHoraGer  := Time()
    Private nPagAtu   := 1
    Private cNomeUsr  := UsrRetName(RetCodUsr())
    //Private cFileLogo := cStartPath + 'lgrl'+AllTrim(cEmpAnt)+cFilAnt + '.bmp'
    //Fontes
    Private cNomeFont := "Arial"
    Private oFontDet  := TFont():New(cNomeFont, 9, -10, .T., .F., 5, .T., 5, .T., .F.)
    Private oFontDetN := TFont():New(cNomeFont, 9, -10, .T., .T., 5, .T., 5, .T., .F.)
    Private oFontRod  := TFont():New(cNomeFont, 9, -08, .T., .F., 5, .T., 5, .T., .F.)
    Private oFontTit  := TFont():New(cNomeFont, 9, -13, .T., .T., 5, .T., 5, .T., .F.)
     
    //Definindo o diretório como a temporária do S.O. e o nome do arquivo com a data e hora (sem dois pontos)
    cCaminho  := GetTempPath()
    cArquivo  := "zTstRel_" + dToS(dDataGer) + "_" + StrTran(cHoraGer, ':', '-')
     
    //Criando o objeto do FMSPrinter
    oPrintPvt := FWMSPrinter():New(cArquivo, IMP_PDF, .F., "", .T., , @oPrintPvt, "", , , , .T.)
     
    //Setando os atributos necessários do relatório
    oPrintPvt:SetResolution(72)
    oPrintPvt:SetPortrait()
    oPrintPvt:SetPaperSize(DMPAPER_A4)
    oPrintPvt:SetMargin(60, 60, 60, 60)
     
    //Imprime o cabeçalho
    fImpCab()
    //Montando a consulta
     cQryAux := " SELECT "                                       + CRLF
    cQryAux += "     YA_CODGI, "                                + CRLF
    cQryAux += "     YA_DESCR "                                  + CRLF
    cQryAux += " FROM "                                         + CRLF
    cQryAux += "     " + RetSQLName('SYA') + " SA1 "            + CRLF
    cQryAux += " WHERE "                                        + CRLF
    cQryAux += "     YA_FILIAL = '" + FWxFilial('SYA') + "' "   + CRLF
    //cQryAux += "     AND SYA.D_E_L_E_T_ = ' ' "                 + CRLF
    cQryAux += " ORDER BY "                                     + CRLF
    cQryAux += "     YA_CODGI "                                 + CRLF
    TCQuery cQryAux New Alias "QRY_SBM"
    //Conta o total de registros, seta o tamanho da régua, e volta pro topo
    Count To nTotal
    ProcRegua(nTotal)
    QRY_SBM->(DbGoTop())
    nAtual := 0
     
    //Enquanto houver registros
    While ! QRY_SBM->(EoF())
        nAtual++
        IncProc("Imprimindo grupo " + QRY_SBM->YA_CODGI + " (" + cValToChar(nAtual) + " de " + cValToChar(nTotal) + ")...")
         
        //Se a linha atual mais o espaço que será utilizado forem maior que a linha final, imprime rodapé e cabeçalho
        If nLinAtu + nTamLin > nLinBox
            fImpRod()
            fImpCab()
        EndIf

        //Imprime o cabeçalho do grupo
        oPrintPvt:SayAlign(nLinAtu, 25, QRY_SBM->YA_CODGI, oFontDet, 0080, nTamLin, COR_PRETO, PAD_LEFT, 0)
        oPrintPvt:SayAlign(nLinAtu, 75, QRY_SBM->YA_DESCR, oFontDet, 0200, nTamLin, COR_PRETO, PAD_LEFT, 0)
        nLinAtu += nTamLin
         
        QRY_SBM->(DbSkip())
    EndDo
    QRY_SBM->(DbCloseArea())
     
    //Se ainda tiver linhas sobrando na página, imprime o rodapé final
    If nLinAtu <= nLinFin
        fImpRod()
    EndIf

    //Mostrando o relatório
    oPrintPvt:Preview()
Return
 
Static Function fImpCab()
    Local cTexto   := ""
     
    //Iniciando Página
    oPrintPvt:StartPage()
     
    //Cabeçalho
    cTexto := "Fechamento de Caixa"
    oPrintPvt:SayAlign(030, nColMeio - 120, cTexto, oFontTit, 240, 20, COR_PRETO, PAD_CENTER, 0)

    //Linha Separatória
    oPrintPvt:Line(050, nColIni, 050, nColFin, COR_PRETO)
        
    //Cabeçalho das colunas
    oPrintPvt:Box(nLinbox, 10 ,nLinBox + 35, 145, "-2")
    oPrintPvt:Box(nLinbox, 150,nLinBox + 35, 245 ,"-2")
    oPrintPvt:Box(nLinbox, 250,nLinBox + 35, 345, "-2")
    oPrintPvt:Box(nLinbox, 350,nLinBox + 35, 445, "-2")
    oPrintPvt:Box(nLinbox, 450,nLinBox + 35, 550, "-2")
    
    oPrintPvt:SayAlign(nLinBox         , 15 ,"Total Dinheiro: "  , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign(nLinBox + 10    , 15 ,"Total Outros: "    , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign(nLinBox + 20    , 15 ,"Total Cancelado: " , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign(nLinBox         , 155,"Total Cheque: "    , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign(nLinBox + 10    , 155,"Total Cheque Pré: ", oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign(nLinBox + 20    , 155,"Total Cartão CR: " , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign(nLinBox         , 255,"Total Cartão DB: " , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign(nLinBox + 10    , 255,"Total Depósito: "  , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign(nLinBox + 20    , 255,"Total Boleto: "    , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign(nLinBox         , 355,"Total Ag. Pagto: " , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign(nLinBox + 10    , 355,"Total Retirados: " , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0) 
    oPrintPvt:SayAlign(nLinBox + 20    , 355,"Total Geral: "     , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    
    oPrintPvt:SayAlign(nLinBox + 10    , 455,"Inspeções:"        , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)

    oPrintPvt:Box(135, 10,  65,  550, "-2")
    ///////////////////////////////////////
    oPrintPvt:Box(165, 10,  180, 60,  "-2")
    oPrintPvt:Box(165, 60,  180, 100, "-2")
    oPrintPvt:Box(165, 100, 180, 170, "-2")
    oPrintPvt:Box(165, 170, 180, 210, "-2")
    oPrintPvt:Box(165, 210, 180, 270, "-2")
    oPrintPvt:Box(165, 270, 180, 300, "-2")
    oPrintPvt:Box(165, 300, 180, 340, "-2")
    oPrintPvt:Box(165, 340, 180, 390, "-2")
    oPrintPvt:Box(165, 390, 180, 420, "-2") 
    oPrintPvt:Box(165, 420, 180, 500, "-2")
    oPrintPvt:Box(165, 500, 180, 550, "-2")
    ///////////////////////////////////////////////////
    oPrintPvt:SayBitMap(70,  20,"C:\Users\Andre\Downloads\download.jpg", 60, 60)
    oPrintPvt:SayAlign( 70,  95, SM0->M0_NOME                                      , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 80,  95, SM0->M0_ENDCOB                                    , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 90,  95, SM0->M0_COMPCOB                                   , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 100, 95,"CNPJ:     " + SM0->M0_CGC + "IE: " + SM0->M0_INSC , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 110, 95,"PABX/FAX: " + SM0->M0_FAX                         , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 150, 95, "Prestação de Contas no Período: 19/01/2025 a 25/01/2025 Turno MATUTINO a VESPERTINO", oFontDetN, 350 , nTamLin, COR_PRETO, PAD_CENTER, 0)
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    oPrintPvt:SayAlign( 165, 25, "DATA"                          , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 165, 75, "OS"                            , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 165, 110,"VENDEDOR"                      , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 165, 175,"VALOR"                         , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 165, 215,"FINANCEIRO"                    , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 165, 275,"NUM"                           , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 165, 310,"OBS."                          , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 165, 350,"DESC."                         , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 165, 395,"CX"                            , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 165, 430,"NOME CLIENTE"                  , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:SayAlign( 165, 510,"FONE"                          , oFontDetN, 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)

    //Atualizando a linha inicial do relatório
    nLinAtu := 180
    
Return
 
Static Function fImpRod()
    Local nLinRod   := nLinFin + nTamLin
    Local cTextoEsq := ''
    Local cTextoDir := ''

    oPrintPvt:Line( 650,30,650, 220, COR_PRETO)
    oPrintPvt:SayAlign( 660, 65, "Assinatura da Recepcionista"   , oFontDet , 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    oPrintPvt:Line( 650,290, 650,480,COR_PRETO)
    oPrintPvt:SayAlign( 660, 340, "Assinatura do Gerente"        , oFontDet , 300 , nTamLin, COR_PRETO, PAD_LEFT, 0)
    //Linha Separatória
    oPrintPvt:Line(nLinRod, nColIni, nLinRod, nColFin, COR_PRETO)
    nLinRod += 3
     
    //Dados da Esquerda e Direita
    cTextoEsq := dToC(dDataGer) + "    " + cHoraGer + "    " + FunName() + "    " + cNomeUsr
    cTextoDir := "Página " + cValToChar(nPagAtu)
     
    //Imprimindo os textos
    oPrintPvt:SayAlign(nLinRod, nColIni,    cTextoEsq, oFontRod, 200, 05, COR_PRETO, PAD_LEFT,  0)
    oPrintPvt:SayAlign(nLinRod, nColFin-40, cTextoDir, oFontRod, 040, 05, COR_PRETO, PAD_RIGHT, 0)
     
    //Finalizando a página e somando mais um
    oPrintPvt:EndPage()
    nPagAtu++
Return
