#INCLUDE "TOTVS.CH"

User Function RLTR()
   
	Local oRelato
	Private cAlias1 := GetNextAlias()
	Private cAlias2 := GetNextAlias()
	Private oSection1
	Private oSection2

	// Interface de impressão
    oRelato := ReportDef(cAlias1)

	// Tela de impressão do relatorio
	oRelato:PrintDialog()

	if(SELECT(cAlias1) > 0)
		(cAlias1)->(dbCloseArea())
	Endif

Return

Static Function ReportDef(cAlias1)
        
	Local oReport

	oReport := TReport():New("Exemplo","Relatorio de Clientes e Produtos",/*cPerg*/,{|oReport| ReportPrint(oReport,cAlias1)})

	// Define orientação de página do relatório como retrato
	oReport:SetPortrait()

	// Define se os totalizadores serão impressos em linha ou coluna
	oReport:SetTotalInLine(.F.)
	oReport:oPage:SetPaperSize(9)

	// Criando um cabaeçalho de como o relatorio será gerado
	oSection1 := TRSection():New(oReport, "Clientes", {cAlias1})

	// Contato
	oSection1:SetTotalInLine(.F.)
	TRCell():New(oSection1,"Z2_CGC"    ,cAlias1,"CPF/CNPJ"    ,"@R 99.999.999/9999-99",18,.F.)
	TRCell():New(oSection1,"Z2_DATEMI" ,cAlias1,"Data Inicio" ,"@!"                   ,8 ,.F.)
	TRCell():New(oSection1,"Z2_CODIGO",cAlias1,"Client "      ,"@!"                    ,6 ,.F.)
	TRCell():New(oSection1,"Z2_LOJA"   ,cAlias1,"Loja "       ,"@!"                   ,2 ,.F.)
	TRCell():New(oSection1,"Z2_NOME"   ,cAlias1,"Nome Cliente","@!"                   ,50,.F.)
	TRCell():New(oSection1,"Z2_TIP0"   ,cAlias1,"TIPO"        ,"@!"                   ,1 ,.F.)

	// Produto relacionados ao contrato
	oSection2 := TRSection():New(oReport, "Produtos", {cAlias2})
	oSection2:SetTotalInLine(.F.)
	TRCell():New(oSection2, "Z3_PROD"   , cAlias2, "Cod Produto"   ,"@!"             ,15,.F.)
	TRCell():New(oSection2, "Z3_DESC"   , cAlias2, "Nome produto"  ,"@!"             ,50,.F.)
	TRCell():New(oSection2, "Z3_IDCLI"  , cAlias2, "Cod do Cliente","@!"             ,6 ,.F.)
	TRCell():New(oSection2, "Z3_VALOR"  , cAlias2, "Valor"         ,"@E 9,999,999.99",11,.F.)
	TRCell():New(oSection2, "Z3_FORNEC" , cAlias2, "Fornecedor"    ,"@!"             ,6 ,.F.)
	TRCell():New(oSection2, "Z3_LOJAFOR", cAlias2, "Loja"          ,"@!"             ,2 ,.F.)
	TRCell():New(oSection2, "Z3_NOME"   , cAlias2, "Nome For."     ,"@!"             ,2 ,.F.)
	
	TRFunction():New(oSection2:Cell("Z3_VALOR"), "", "SUM",, "Total dos valores dos produtos", "@E 999,999.99",, .T., .T.)

Return oReport

Static Function ReportPrint(oReport,cAlias1)


	BeginSql Alias cAlias1

        SELECT
            Z2_FILIAL,
            Z2_CODIGO,
            Z2_LOJA,
			Z2_NOME,
			Z2_TIP0,
			Z2_CGC,
			Z2_DATEMI
        FROM
            %Table:SZ2% SZ2
		WHERE
		SZ2.%NotDel%
        ORDER BY
            Z2_CODIGO
	EndSql

	While (cAlias1)->(!Eof())

		if(oReport:Cancel())
			MsgInfo("Operação cancelada pelo o usuário.","ATENÇÃO!")
			Exit
		endif

			oSection1:init()
			oSection2:init()
			oSection1:Cell("Z2_CODIGO"):SetHeaderAlign("left")
			oSection1:Cell("Z2_CODIGO"):SetAlign("right")
			oSection1:Cell("Z2_CODIGO"):SetValue((cAlias1)->Z2_CODIGO)

			oSection1:Cell("Z2_LOJA"):SetHeaderAlign("left")
			oSection1:Cell("Z2_LOJA"):SetAlign("right")
			oSection1:Cell("Z2_LOJA"):SetValue((cAlias1)->Z2_LOJA)

			oSection1:Cell("Z2_NOME"):SetHeaderAlign("left")
			oSection1:Cell("Z2_NOME"):SetAlign("right")
			oSection1:Cell("Z2_NOME"):SetValue((cAlias1)->Z2_NOME)
		
			oSection1:Cell("Z2_TIP0"):SetHeaderAlign("left")
			oSection1:Cell("Z2_TIP0"):SetAlign("right")
			oSection1:Cell("Z2_TIP0"):SetValue((cAlias1)->Z2_TIP0)

			oSection1:Cell("Z2_CGC"):SetHeaderAlign("left")
			oSection1:Cell("Z2_CGC"):SetAlign("right")
			oSection1:Cell("Z2_CGC"):SetValue((cAlias1)->Z2_CGC)

			oSection1:Cell("Z2_DATEMI"):SetHeaderAlign("left")
			oSection1:Cell("Z2_DATEMI"):SetAlign("right")
			oSection1:Cell("Z2_DATEMI"):SetValue((cAlias1)->Z2_DATEMI)

		oSection1:PrintLine()
		oSection1:Finish()

		if(SELECT(cAlias2) > 0)
			(cAlias2)->(dbCloseArea())
		Endif


		BeginSql Alias cAlias2
			SELECT
				Z3_IDCLI,
				Z3_PROD,
				Z3_DESC,
				Z3_VALOR,
				Z3_FORNEC,
				Z3_LOJAFOR,
				Z3_NOME
			FROM
				%Table:SZ2% SZ2
		
				LEFT JOIN %Table:SZ3% SZ3 ON Z2_FILIAL = Z3_FILIAL
				AND Z2_CODIGO = Z3_IDCLI
				WHERE
				SZ2.%NotDel% 
				AND
				SZ3.%NotDel%
				AND 
				Z3_IDCLI = %exp:(cAlias1)->Z2_CODIGO%
			ORDER BY
				Z3_PROD
		EndSql

		While (cAlias2)->(!Eof())
			// Produto(s)
			oSection2:Cell("Z3_PROD"):SetHeaderAlign("RIGHT")
			oSection2:Cell("Z3_PROD"):SetAlign("RIGHT")
			oSection2:Cell("Z3_PROD"):SetValue((cAlias2)->Z3_PROD)

			oSection2:Cell("Z3_DESC"):SetHeaderAlign("RIGHT")
			oSection2:Cell("Z3_DESC"):SetAlign("RIGHT")
			oSection2:Cell("Z3_DESC"):SetValue((cAlias2)->Z3_DESC)

			oSection2:Cell("Z3_IDCLI"):SetHeaderAlign("RIGHT")
			oSection2:Cell("Z3_IDCLI"):SetAlign("RIGHT")
			oSection2:Cell("Z3_IDCLI"):SetValue((cAlias2)->Z3_IDCLI)

			oSection2:Cell("Z3_VALOR"):SetHeaderAlign("RIGHT")
			oSection2:Cell("Z3_VALOR"):SetAlign("RIGHT")
			oSection2:Cell("Z3_VALOR"):SetValue((cAlias2)->Z3_VALOR)

			oSection2:Cell("Z3_FORNEC"):SetHeaderAlign("RIGHT")
			oSection2:Cell("Z3_FORNEC"):SetAlign("RIGHT")
			oSection2:Cell("Z3_FORNEC"):SetValue((cAlias2)->Z3_FORNEC)

			oSection2:Cell("Z3_LOJAFOR"):SetHeaderAlign("RIGHT")
			oSection2:Cell("Z3_LOJAFOR"):SetAlign("RIGHT")			
			oSection2:Cell("Z3_LOJAFOR"):SetValue((cAlias2)->Z3_LOJAFOR)

			oSection2:Cell("Z3_NOME"):SetHeaderAlign("RIGHT")
			oSection2:Cell("Z3_NOME"):SetAlign("RIGHT")
			oSection2:Cell("Z3_NOME"):SetValue((cAlias2)->Z3_NOME)
			oSection2:PrintLine()
			(cAlias2)->(DbSkip())
		Enddo
		oSection2:Finish()
		(cAlias1)->(DbSkip())
	Enddo
	oSection1:Finish()
Return
