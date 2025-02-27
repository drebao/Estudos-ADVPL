#INCLUDE "TOTVS.CH"
#INCLUDE"TBICONN.CH"

/*/{Protheus.doc} U_FENVREL
Envia um emial para o usuario detereminado no parametro
Informando quantos usuarios estao com o controle de penhor irao vencer
@type function
@version 12.1.33
@author Felipe Fraga
@since 31/03/2023
/*/
 User Function EMAILTXT()

	Local aCliente 	  := {}
	Local cAssunto    := ""
	Local cQuery   	  := ""
	Local cFROM       := ""
	Local cPara       := ""
	Local cSMTPPass   := ""
	Local cSMTPServer := ""
	Local cSMTPUser   := ""
	Local cAlias	  := ""
	Local cTexto      := ''
	Local lOk         := .T.
	Local lSSl        := .F.
	Local lTls        := .F.
	Local nErro       := 0
	Local nPort       := 0
	Local nX 		  := 0 
	Local oMail
	Local oMessage
	Local oQuerySA1
	Local cAnexo      :=  "\system\expsa1.txt"

	// Adicionando o assunto do envio de email
	cAssunto := "INFORMAÇÕES DE CLIENTES"

	if SELECT("SX2") == 0 //Para ser executado pelo usuario
		PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' USER 'Admin' PASSWORD''
	endif

	// Consuilta que verifica se algum contrato de penhor determinado na tabela ZZ1 está faltando 3 dias
	cAlias := GetNextAlias()
	cQuery := " SELECT * FROM " +RetSqlName("SA1") + " WHERE A1_COD != ''" 

	cQuery := ChangeQuery(cQuery)
	oQuerySA1 := FWPreparedStatement():New(cQuery)
	cQuery := oQuerySA1:GetFixQuery()

	cAlias := MPSYSOpenQuery(cQuery)

	while(cAlias)->(!EOF())
		// Pegar a data dia menos a data de vencimento, caso seja igual 3 entra na cond
			Aadd(aCliente,{;
			(cAlias)->A1_COD,;
			(cAlias)->A1_NOME,;
            (cAlias)->A1_NREDUZ,;
			(cAlias)->A1_CGC,;
			(cAlias)->A1_LOJA,;
            (cAlias)->A1_END,;
            (cAlias)->A1_EST,;
			(cAlias)->A1_MUN;
			})
		//endif 
		(cAlias)->(DbSkip())
	End

	if(Len(aCliente) <> 0)
		// Parametros que serao usados
		cFROM       := GetMV("MV_RELFROM")      //email do remetente
		cPara       := GetMV("FS_EMAILEN")      //email do destinatario
		cSMTPPass   := GetMV("MV_RELPSW")       //senha
		cSMTPServer := GetMV("MV_RELSERV")      //servidor
		cSMTPUser   := GetMV("MV_RELACNT")      //conta
		lSSl        := GetMV("MV_RELSSL",,.F.)  //segurança
		lTls        := GetMV("MV_RELTLS",,.F.)  //segurança // Deve ser como .T.
		nPort       := GetMV("MV_GCPPORT",,587) //porta

		cTexto := "Segue e-mail automático referente ao cadastro de clientes"
		cTexto += "<br/>"
		cTexto += "<br/>"
		// Falar quantos contratos de penhor esto pendentes
		cTexto += "<table border='1' style='width: 80%; table-layout: fixed; border-collapse: collapse;'>"
		cTexto += "<tr rowspan='2'>"
		cTexto += "<th>Código</th>"
        cTexto += "<th>Cliente</th>"
		cTexto += "<th>Reduzido</th>"
		cTexto += "<th>CNPJ</th>"
		cTexto += "<th>Loja</th>"
		cTexto += "<th>Endereço</th>"
		cTexto += "<th>Estado</th>"
		cTexto += "<th>Municipio</th>"
		cTexto += "</tr>"
		cTexto += "</table>"
		cTexto += "<tr>"


		
		for nX := 1 to Len(aCliente)
            cTexto += "<table border='1' style='width: 80%; table-layout: fixed; border-collapse: collapse;'>"
			cTexto += "<tr colspan='2'>"
			
			cTexto += "<td>" + aCliente[nX][1] + "</td>"
			cTexto += "<td>" + aCliente[nX][2] + "</td>"
			cTexto += "<td>" + aCliente[nX][3] + "</td>"	
			cTexto += "<td>" + aCliente[nX][4] + "</td>"
			cTexto += "<td>" + aCliente[nX][5] + "</td>"
			cTexto += "<td>" + aCliente[nX][6] + "</td>"
			cTexto += "<td>" + aCliente[nX][7] + "</td>"	
			cTexto += "<td>" + aCliente[nX][8] + "</td>"	
			cTexto += "</tr>"
			cTexto += "</table>"
			next
		
			cTexto += "<br/>"
	        nX := 0

		cTexto += "<br/>"
		cTexto += "<br/>"
		cTexto += "<br/>"
		cTexto += "Menssagem gerada automaticamente pelo ERP PROTHEUS"
		cTexto += "<br/>"
		cTexto += "Dia: " + StrZero(Day(dDataBase),2) + " de " + MesExtenso(Month(DATE())) + " de " + Str(Year(DATE()),4) + " as " + TIME()
		cTexto += "<br/>"
		cTexto += "Não responder este email!"
		oMail := TMailManager():New()

		If At(":",cSMTPServer) > 0
			//-- Retira a porta pois deve pegar pelo parametro MV_GCPPORT
			cSMTPServer := SubStr(cSMTPServer , 01 , At(":",cSMTPServer) - 1 )
		EndIf

		oMail:SetUseSSL(lSSl)
		oMail:SetUseTLS(lTls)
		oMail:Init( '', cSMTPServer , cSMTPUser, cSMTPPass, 0, nPort  )

		oMail:SetSmtpTimeOut( 120 )

		nErro := oMail:SmtpConnect()

		If nErro == 0 //-- Conseguiu Conectar.
			nErro := oMail:SmtpAuth(cSMTPUser ,cSMTPPass) //-- Autenticação do usuário
			If nErro == 0 //-- Autenticação correta
				oMessage := TMailMessage():New()
				oMessage:Clear()
				oMessage:cFrom	:= cFROM
				oMessage:cTo	:= cPara

				oMessage:cSubject	:= cAssunto
				oMessage:cBody		:= cTexto
				oMessage:AttachFile(cAnexo) 

				nErro := oMessage:Send( oMail )
				If nErro == 0
					Alert("Email enviado com sucesso!","Envia")
					DBSelectArea("SA1")
					lOk := .T.
				Else
					cMAilError := oMail:GetErrorString(nErro)
					Alert(cMAilError+CRLF+cValToChar(nErro)+CRLF+"3","Envia")
					lOk := .F.
					oMail:SMTPDisconnect()
				Endif
			Else //-- Não Autenticou
				cMAilError := oMail:GetErrorString(nErro)
				Alert(cMAilError+CRLF+cValToChar(nErro)+CRLF+"2","Autenticacao")
				lOk := .F.
				oMail:SMTPDisconnect()
			EndIf
		Else //-- Não Conseguiu Conectar.
			cMAilError := oMail:GetErrorString(nErro)
			Alert(cMAilError+CRLF+cValToChar(nErro)+CRLF+"1","Connexao")
			lOk := .F.
			oMail:SMTPDisconnect()
		EndIf
	endif

	if SELECT("SX2") > 0
		RESET ENVIRONMENT
	endif

Return(lOk)

// senha do PROTHEUS para o Email sem oAuth2 
// qeup uqqa vhun rjcg

