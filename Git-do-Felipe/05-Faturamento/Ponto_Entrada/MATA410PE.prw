#INCLUDE "TOTVS.Ch"

Static cModelAct := ""

User Function MATA410()

	Local aParam     := PARAMIXB
	Local xRet       := .T.
	Local cIdPonto   := ''

	//Se tiver par�metros
	If aParam <> NIL
		ConOut("> "+aParam[2])

		//Pega informa��es dos par�metros
		cIdPonto := aParam[2]

		// //Valida a abertura da tela
		// If cIdPonto == "MODELVLDACTIVE" .And. !(cModelAct $ cIdPonto)
		// 	cModelAct += cIdPonto + '|'
		// endif

		// //Pr� configura��es do Modelo de Dados
		// If cIdPonto == "MODELPRE" .And. !(cModelAct $ cIdPonto)
		// 	cModelAct += cIdPonto + '|'
		// endif

		// //Pr� configura��es do Formul�rio de Dados
		// If cIdPonto == "FORMPRE" .And. !(cModelAct $ cIdPonto)
		// 	cModelAct += cIdPonto + '|'
		// endif

		// //Adi��o de op��es no A��es Relacionadas dentro da tela
		// If cIdPonto == 'BUTTONBAR' .And. !(cModelAct $ cIdPonto)
		// 	cModelAct += cIdPonto + '|'
		// endif

		// //P�s configura��es do Formul�rio
		// If cIdPonto == 'FORMPOS' .And. !(cModelAct $ cIdPonto)
		// 	cModelAct += cIdPonto + '|'
		// endif

		// //Pr� valida��es do Commit
		// If cIdPonto == 'FORMCOMMITTTSPRE' .And. !(cModelAct $ cIdPonto)
		// 	cModelAct += cIdPonto + '|'
		// endif

		// //P�s valida��es do Commit
		// If cIdPonto == 'FORMCOMMITTTSPOS' .And. !(cModelAct $ cIdPonto)
		// 	cModelAct += cIdPonto + '|'
		// endif

		// //Commit das opera��es (ap�s a grava��o)
		// If cIdPonto == 'MODELCOMMITNTTS' .And. !(cModelAct $ cIdPonto)

		// 	cModelAct += cIdPonto

		// 	FWLogMsg("INFO",/*cTransactionId*/, ProcName(),/*cCategory*/, /*cStep*/,;
			// 	 /*cMsgId*/, "Os pontos de entradas em MVC que foram utilizados foram: " + cModelAct , /*nMensure*/, /*nElapseTime*/, /*aMessage*/)
		// 	EndIf

		//Valida��o ao clicar no Bot�o Confirmar
		If cIdPonto == 'MODELPOS' .And. !(cModelAct $ cIdPonto)
			cModelAct += cIdPonto + '|'
			// Validar todos os campos como obrigatorios
		endif

		//Commit das opera��es (antes da grava��o)
		If cIdPonto == 'MODELCOMMITTTS' .And. !(cModelAct $ cIdPonto)
			cModelAct += cIdPonto + '|'
			// Vazer a inclusao do produto
		endif

	EndIf
Return xRet
