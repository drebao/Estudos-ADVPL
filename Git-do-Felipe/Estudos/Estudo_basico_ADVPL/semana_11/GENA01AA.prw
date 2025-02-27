#INCLUDE "TOTVS.CH"
#INCLUDE"TBICONN.CH"

/*/{Protheus.doc} u_GENA01AA
Envio de email
@type function
@version 33
@author felip
@since 21/11/2022
/*/
Function u_GENA01AA()

	Local cMensagem    := ""                            as Character
	// Local cPara      := "felipefraga.assis@gmail.com" as Character
	// Local cPara      := "vitor.rosa@j2aconsultoria.com.br" as Character
	Local cPara      := "felipefragaassisifmt@gmail.com" as Character
	Local oRules_Email := Nil                           as Object
	Local cMsg         := "ola"                         as Character

	if SELECT("SX2") == 0 //Para ser executado pelo usuario
		PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
	endif

	cMensagem := " -------------------- ESTUDO DO FELIPE --------------------<BR> " + chr(13)+chr(10)
	cMensagem += ' Data de Importa��o - ' + DToC(dDataBase) + chr(13)+chr(10)
	cMensagem += ' Hora : ' + Time()      + ' <BR> '        + chr(13)+chr(10)

	/*
	Voce pode colocar o que quiser
	*/

	cMensagem += ' ---------------------------------------------------------------------------<BR> '
	cMensagem += ' E-mail gerado de forma Autom�tica! Em: ' + DToC(dDataBase) + '  <BR> ' + chr(13)+chr(10)
	cMensagem += ' Favor n�o responder este e-mail! <BR> '  + chr(13)+chr(10)
	cMensagem += ' ---------------------------------------------------------------------------<BR> '
	cMensagem += ' </html> '

	cAssunto := "ESTUDO DO FELIPE"

	// Classe
	oRules_Email := oEmail():New() //construtor
	oRules_Email:EnvEmail(cAssunto,cMsg,cPara) //envia o email
	// oRules_Email:Destroy()//Limpa as variaveis da classe
	if SELECT("SX2") > 0
		RESET ENVIRONMENT
	endif

Return

	CLASS oEmail FROM ENVEMAIL

		METHOD new() CONSTRUCTOR
		METHOD EnvEmail()
		// METHOD Destroy()

	ENDCLASS

METHOD new() CLASS oEmail
Return

METHOD EnvEmail(cAssunto,cMsg,cPara) CLASS oEmail

	Local oServer       := NIL as Object
	Local oMessage      := Nil as Object
	Local xRet
	Local nPorta        := 465 as Numeric
	Private cMailConta  := NIL as Character
	Private cMailServer := NIL as Character
	Private cMailSenha  := NIL as Character


	cMailConta  := If(cMailConta == NIL,GETMV("MV_RELACNT"),cMailConta)
	cMailSenha  := If(cMailSenha == NIL,GETMV("MV_RELPSW"),cMailSenha)
	cMailServer := If(cMailServer == NIL,GETMV("MV_RELSERV"),cMailServer)
	cMailServer := SubStr(cMailServer,1,At(":",cMailServer)-1)

	//Apos a conex�o, cria o objeto da mensagem
	oMessage:= TMailMessage():New()

	//Limpa o objeto
	oMessage:Clear()

	//Popula com os dados de envio
	oMessage:cDate    := cValToChar(Date())
	oMessage:cFrom    := cMailConta
	oMessage:cTo      := cPara
	oMessage:cSubject := cAssunto
	oMessage:cBody    := cMsg

	//Cria uma nova conex�o
	oServer := tMailManager():New()
	oServer:SetUseSSL( .T. ) //Indica se ser� utilizar� a comunica��o segura atrav�s de SSL/TLS (.T.) ou n�o (.F.)

	// Define as configura��es da classe TMailManager para realizar uma conex�o com o servidor de e-mail.
	xRet := oServer:Init( "", cMailServer, cMailConta, cMailSenha, 0, nPorta ) //inicilizar o servidor
	if xRet != 0
		alert("O servidor SMTP n�o foi inicializado: " + oServer:GetErrorString( xRet ) )
		return
	endif
	// Define o tempo de espera para uma conex�o estabelecida com o servidor SMTP - Simple Mail Transfer Protocol.
	xRet := oServer:SetSMTPTimeout( 120 )
	if xRet != 0
		alert("N�o foi poss�vel definir " + cProtocol + " tempo limite para " + cValToChar( nTimeout ))
	endif

	// Conecta com o servidor SMTP - Simple Mail Transfer Protocol
	xRet := oServer:SMTPConnect()
	if xRet <> 0
		conout("N�o foi poss�vel conectar ao servidor SMTP: " + oServer:GetErrorString( xRet ))
	endif

	// Envia um e-mail, de acordo com os dados passados pelo objeto da classe TMailManager por par�metro, para a fun��o.
	xRet := oMessage:Send( oServer )
	if xRet <> 0
		conout("N�o foi poss�vel enviar mensagem: " + oServer:GetErrorString( xRet ))
	endif

	// inaliza a conex�o entre a aplica��o e o servidor SMTP - Simple Mail Transfer Protocol.
	xRet := oServer:SMTPDisconnect()
	if xRet <> 0
		alert("N�o foi poss�vel desconectar o servidor SMTP: " + oServer:GetErrorString( xRet ))
	endif

RETURN

//https://userfunction.com.br/infraestrutura/sigacfg/relatorios-por-e-mail-no-protheus/
