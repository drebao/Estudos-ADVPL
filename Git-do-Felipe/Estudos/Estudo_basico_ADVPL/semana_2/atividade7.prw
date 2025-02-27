#include "totvs.ch"

/*
+===========================================+
| Programa: Tipos de Variaveis              |
| Autor : Felipe Fraga de Assis             |
| Data : 21 de setembro de 2022             |
+===========================================+
*/

user function ativid7()

	local nAltura   := nPeso := nIdade := nSexo := nImc := nBt := 0
	local lContinua := .T.
	Local cTecla    := SetKey(K_ALT_F4, {|| lContinua := .F. })

	while lContinua

		MsgAlert("Aqui vamos calcular o seu IMC e determinar aproximadamente sua gordura corporal")

		nPeso     := FWInputBox("Qual a sua altura (kg)")
		nAltura   := FWInputBox("Qual a sua altura (cm)","")

		nPeso   := VAL(nPeso)
		nAltura := VAL(nAltura)

		nImc := (nPeso * 1000) / ((175 * 175) * 0.0001)
		nImc := NOROUND(nImc,2)
		nImc := nImc * 0.001
		nImc := NOROUND(nImc,2)

		MsgAlert("Seu IMC foi de: " + CValToChar(nImc))

		if(nImc <= 18.5)
			MsgAlert("Abaixo do peso")
		elseif (nImc > 18.5 .and. nImc < 25.00)
			MsgAlert("Peso Ideal")
		elseif (nImc >= 25.00 .and. nImc < 30.00)
			MsgAlert("Levemente acima do peso")
		else
			MsgAlert("Acima do peso")
		endif

		nSexo  := FWInputBox("Qual o seu sexo: 1 - Homem // 2 - Mulher // 3 - Outros", "")
		nIdade := FWInputBox("Qual a sua idade", "")

		nSexo  := VAL(nSexo)
		nIdade := VAL(nIdade)

		if( nSexo == 1)
			nBt := (1.20 * nImc) + (0.23 * nIdade) - (10.8 * 1) - 5.4
			MsgAlert("Seu BT foi de: " + CValToChar(nBt))
		else
			nBt := (1.20 * nImc) + (0.23 * nIdade) - (10.8 * 0) - 5.4
			MsgAlert("Seu BT foi de: " + CValToChar(nBt))
		endif

		nAltura   := nPeso := nIdade := nSexo := nImc := nBt := 0

	end

return()
