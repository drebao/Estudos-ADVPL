#INCLUDE "TBICONN.CH"
#INCLUDE "TOTVS.CH"

User Function RELT()

    
	Local oRelato
	Private aPerg := "ZZTST"
    
	//Retorna um alias para ser utilizado no record set definido em PadR()
	Private cAlias := ""
	Private oSection1
     
    IF SELECT('SX2') == 0
        PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' USER 'Admin' PASSWORD''
    Endif

     cAlias := GetNextAlias()

	oRelato := ReportDef()

	// Tela de impressão do relatório
	oRelato:PrintDialog()

    if SELECT('SX2') == 0
        reset environment
    endif    

Return

Static Function ReportDef()

	Local oReport
    

	// Primeiros abriremos um browse para fazer as perguntas
	Pergunte(aPerg, .T.)
    
	oReport := TReport():New("relatorio",'Relação de clientes',aPerg,{||ReportPrint()},,.T.)

	// Define a orientação de página do relatório como Paisagem
	oReport:SetLandScape(.T.)

	// Define se será permitida a alteração dos parâmetros do relatório
	oReport:HideParamPage()

	oSection1 := TRSection():New(oReport,"????? ??? ???? ??? ???? ?????", {cAlias})
	IF(MV_PAR05 == 1)
    //trcell é em planilha
		TRCell():New(oSection1, 'Z1_FILIAL', cAlias)
		TRCell():New(oSection1, 'Z1_CODIGO' , cAlias)
		TRCell():New(oSection1, 'Z1_EMAIL' , cAlias)
		TRCell():New(oSection1, 'Z1_PRNOME', cAlias)
		TRCell():New(oSection1, 'Z1_UTNOM', cAlias)
		TRCell():New(oSection1, 'Z1_PAIS'  , cAlias)
		TRCell():New(oSection1, 'Z1_GENERO', cAlias)
		TRCell():New(oSection1, 'Z1_IPREDE', cAlias)
	ELSE
		TRCell():New(oSection1, 'Z1_FILIAL', cAlias)
		TRCell():New(oSection1, 'Z1_CODIGO' , cAlias)
		TRCell():New(oSection1, 'Z1_PAIS'  , cAlias)
	ENDIF

Return oReport


static function ReportPrint()

	// 1- primeiro valida como vai ser inprimido os dados
	IF(MV_PAR05 == 1)

		BeginSql Alias cAlias
                SELECT
                    Z1_FILIAL,
                    Z1_CODIGO,
                    CONVERT(varchar(5000),Z1_EMAIL) Z1_EMAIL,
                    Z1_PRNOME,
                    Z1_UTNOM,
                    Z1_PAIS,
                    Z1_GENERO,
                    Z1_IPREDE
                FROM
                    %Table:SZ1% SZ1
                WHERE Z1_CODIGO BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
                AND   Z1_PAIS BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
                AND SZ1.%NotDel%

		ENDSQL

	ELSE

		BeginSql Alias cAlias
                SELECT
                    Z1_FILIAL,
                    COUNT(Z1_CODIGO) Z1_CODIGO,
                    Z1_PAIS
                FROM
                    %Table:SZ1% SZ1
                WHERE Z1_CODIGO BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
                AND   Z1_PAIS BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
                AND SZ1.%NotDel%
                GROUP BY Z1_FILIAL,
                        Z1_PAIS
                ORDER BY Z1_PAIS

		ENDSQL

	ENDIF


	// 2 - impressão do relatório
	oSection1:Print()
return
