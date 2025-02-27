#include "totvs.ch"
/*
+===========================================+
| Programa: C�lculo do Fatorial             |
| Autor : Felipe Fraga de Assis             |
| Data : 14 de setembro de 2022             |
+===========================================+
*/
User Function ativid2()
Local nCnt
Local nResultado := 1 // Resultado do fatorial
Local nFator := 5 // N�mero para o c�lculo
// C�lculo o valor fatorial
For nCnt := nFator To 1 Step -1
nResultado *= nCnt
Next
// Exibe o resultado na tela, atrav�s da fun��o alert
MsgAlert("O fatorial de " + cValToChar(nFator) + "�" + cValToChar(nResultado))
// Termina o programa
Return( NIL )
