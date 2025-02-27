#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"   // com issa include comseguiremos criar uma API simples


WSRESTFUL VILSZ1 DESCRIPTION "A Classe WS para testes" FORMAT APPLICATION_JSON

	WSMETHOD GET DESCRIPTION "Consulta de todos os cliente" WSSYNTAX "/visualiza/clientes"
	WSMETHOD POST DESCRIPTION "Adiciona um novo cliente" WSSYNTAX "/adiciona/cliente"
	
	// Passando o PATH como um parametro que quando for inserido a rota precisa ser informado o valor

END WSRESTFUL

 //WSMETHOD GET PATHPARAM ID WSSERVICE VILSZ1
WSMETHOD GET  WSSERVICE VILSZ1

	Local cAlias   := GetNextAlias()                          as Character //Pega o próximo alias disponível
	Local cJson    := self:GetContent()                       as Character // Pega a string do JSON
	Local aClient  := {}                                      as Array
	Local oJson    := Nil                                     as Object
	Local lRet     := .T.                                     as Logical
	Local cError   := ""                                      as Character
	local nLoop    := 0                                       as Numeric
	local cArquivo := "\temp\json.txt"                        as Character // Somente inseri os dados quando estiver na pasta protheus_data

	self:SetContentType("application/json") // Pega o conteudo JSON da transação Rest
	oJson := JsonObject():New()          // Monta Objeto JSON de retorno
	cError  := oJson:FromJson(cJson)

	BeginSQL Alias cAlias
		SELECT
			Z1_FILIAL,
			Z1_CODIGO,
			Z1_PRNOME,
			Z1_UTNOM,
			CONVERT(varchar(5000), Z1_EMAIL) Z1_EMAIL,
			Z1_GENERO,
			Z1_PAIS,
			Z1_IPREDE
		FROM
			%Table:SZ1%
		WHERE
			%notdel%
	ENDSQL

	while !(cAlias)->(Eof())

		nLoop++

		aAdd(aClient,JsonObject():New())

		// Os valores que serão apresentado no JSON
		aClient[nLoop]["FILIAL"]    := AllTrim((cAlias)->Z1_FILIAL)
		aClient[nLoop]["ID"]        := AllTrim((cAlias)->Z1_CODIGO)
		aClient[nLoop]["NOME"]      := AllTrim((cAlias)->Z1_PRNOME)
		aClient[nLoop]["SOBRONOME"] := AllTrim((cAlias)->Z1_UTNOM)
		aClient[nLoop]["EMAIL"]     := AllTrim((cAlias)->Z1_EMAIL )
		aClient[nLoop]["GENERO"]    := AllTrim((cAlias)->Z1_GENERO)
		aClient[nLoop]["PAIS"]      := AllTrim((cAlias)->Z1_PAIS  )
		aClient[nLoop]["IPREDE"]    := AllTrim((cAlias)->Z1_IPREDE)

		(cAlias)->(dbSkip())
	end
	oJson['CLIENTES'] := aClient
	If MEMOWRITE(cArquivo, oJson:toJson())
		ConOut("Gravou")
	EndIf
	//oJson:set(aClient) // seta o valor ao objeto
	self:SetResponse(oJson:toJson()) // retorno de um objeto JSON

	Return lRet

            //////////////////////////////////////////////////////////////////////	
            //////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////


WSMETHOD POST WSSERVICE VILSZ1

	Local cJson    := self:GetContent() as Character
	local lRet     := .T.            as Logical
	local oJson    := Nil            as Object
	local cError   := ""             as Character
	local nX       := 0              as Numeric
	local aClient  := {}             as Array
	Local nOpcAuto := 3              as Numeric //MODEL_OPERATION_INSERT
	//Local cLoja    := PadR("01",TamSx3('A1_LOJA')[1])
	Private lMsErroAuto := .F.
	Private lMSHelpAuto     := .T.
	Private lAutoErrNoFile := .T.

	self:SetContentType("application/json") // Pega o conteudo JSON da transação Rest
	oJson := JsonObject():New()          // Monta Objeto JSON de retorno
	cError  := oJson:FromJson(cJson)

	DbSelectArea("SZ1") // selecionando qual a tabela nos iremos usar

	if Empty(cError)

		for nX := 1 to Len(oJson:GetJsonObject('CLIENTES'))

			if !SA1->(MsSeek( PadR(xFilial("SA1",oJson:GetJsonObject( 'CLIENTES' )[nX][ 'FILIAL' ]),TamSx3('A1_FILIAL')[1]);
					+ PadL(oJson:GetJsonObject( 'CLIENTES' )[nX][ 'ID' ],TamSx3('A1_COD')[1],'0')   ;
					+  cLoja))
				aClient := {}
				aadd(aClient, {"Z1_FILIAL" , xFilial("SA1",oJson:GetJsonObject( 'CLIENTES' )[nX][ 'FILIAL' ])                                            , NIL})
				aadd(aClient, {"Z1_CODIGO"    , PadL(oJson:GetJsonObject( 'CLIENTES' )[nX][ 'ID' ],TamSx3( 'A1_COD' )[1], '0' )                             , NIL})
				//aadd(aClient, {"A1_LOJA"   , cLoja                                                                                                       , NIL})
				aadd(aClient, {"Z1_PRNOME"   , oJson:GetJsonObject( 'CLIENTES' )[nX][ 'NOME' ] + ' ' + oJson:GetJsonObject( 'CLIENTES' )[nX][ 'SOBRONOME' ], NIL})
				aadd(aClient, {"Z1_EMAIL"  , oJson:GetJsonObject( 'CLIENTES' )[nX][ 'EMAIL' ]                                                            , NIL})
				aadd(aClient, {"Z1_PAIS"   , "1554"                                                                                                       , NIL})
				aadd(aClient, {"Z1_IPREDE", oJson:GetJsonObject( 'CLIENTES' )[nX][ 'IPREDE' ]                                                           , NIL})
				aadd(aClient, {"Z1_GENERO", oJson:GetJsonObject( 'CLIENTES' )[nX][ 'GENERO' ]                                                           , NIL})
				//aadd(aClient, {"A1_END"    , "Av. do CPA"                                                                                                , Nil})
				//aadd(aClient, {"A1_NREDUZ" , oJson:GetJsonObject( 'CLIENTES' )[nX][ 'NOME' ]                                                             , Nil})
				//aadd(aClient, {"A1_TIPO"   , "F"                                                                                                         , Nil})
				//aadd(aClient, {"A1_PESSOA" , "F"                                                                                                         , Nil})
				//aadd(aClient, {"A1_EST"    , "MT"                                                                                                        , Nil})
				//aadd(aClient, {"A1_MUN"    , "Cuiaba"                                                                                                    , NIL})
				aClient := FwVetByDic(aClient)
				MSExecAuto({|a,b| CRMA980(a,b)}, aClient, nOpcAuto)

				If lMsErroAuto
					lRet := !lMsErroAuto
					SetRestFault(400,VarInfo('',GetAutoGrLog()))
					Exit
				Else
					Conout("Cliente incluído com sucesso!")
				EndIf
			endif
		next
	else
		lRet := .F.
	endif

RETURN lRet

 

 Return
