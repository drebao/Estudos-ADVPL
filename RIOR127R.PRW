#INCLUDE "rwmake.ch"
#Include "TopConn.ch"
#Include "Colors.CH"
#Include "Protheus.CH"
#INCLUDE "FWPrintSetup.ch" 
  
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ RIOR127R ณ Autor ณ Paulo C้sar P. Schwind ณ Data ณ 29.02.20 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Rela็ใo de Notas Fiscais por Fornecedor                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ Lista as NFs por Fornecedor                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณAltera็๕esณ                                                             ณฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function RIOR127R()
Private _lEnd		 := .F.,;
         _nRegs      := 0  ,;
		 _lMostrJan  := .f.,;
		 _nColFim          ,;
		 _aArea 	 := GetArea()

Private cPerg	:= "RIOR127R2"

		ValidPerg()
		
		Pergunte( cPerg, .T. )

		Processa({ |_lEnd| fExecRel(),OemToAnsi('Imprimindo o relat๓rio')}, OemToAnsi('Aguarde...'))

		RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ xExecRel บ Autor ณ                            ณ            บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo que imprime os DOCUMENTOS                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Funcao Principal                                           บฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ MOTIVO                                          บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fExecRel() 
Local 	_cQuery	:= '',;
        nQtdReg    := 0 
        
Private   oPrint,;  
          oBrush		:= TBrush():New(,4),;
		  oFont07		:= TFont():New('Courier New',07,07,,.F.,,,,.T.,.F.),;
		  oFont08		:= TFont():New('Courier New',08,08,,.F.,,,,.T.,.F.),;
		  oFont08n		:= TFont():New('Courier New',08,08,,.T.,,,,.T.,.F.),;
		  oFont09		:= TFont():New('Tahoma',09,09,,.F.,,,,.T.,.F.),;
		  oFont10		:= TFont():New('Tahoma',10,10,,.F.,,,,.T.,.F.),;
		  oFont10n	    := TFont():New('Courier New',10,10,,.T.,,,,.T.,.F.),;
		  oFont11		:= TFont():New('Tahoma',11,11,,.F.,,,,.T.,.F.),;
		  oFont11Lc	    := TFont():New('Lucida Console',11,11,,.F.,,,,.T.,.F.),;
		  oFont12		:= TFont():New('Tahoma',12,12,,.T.,,,,.T.,.F.),;
		  oFont14		:= TFont():New('Tahoma',14,14,,.T.,,,,.T.,.F.),;
		  oFont15		:= TFont():New('Courier New',15,15,,.T.,,,,.T.,.F.),;
		  oFont18		:= TFont():New('Arial',18,18,,.T.,,,,.T.,.T.),;
		  oFont16		:= TFont():New('Arial',16,16,,.T.,,,,.T.,.F.),;
		  oFont22		:= TFont():New('Arial',22,22,,.T.,,,,.T.,.F.),;
		  oFont24		:= TFont():New('Arial',24,24,,.T.,,,,.T.,.F.),;
		  oFont26		:= TFont():New('Arial',26,26,,.T.,,,,.T.,.F.)
		  
          oPrint		:= TMSPrinter():New(OemToAnsi('Documentos'))
          oPrint:Setup()          

Private  _oDlg,;
		 _lInverte	 := .T.,;
		 _cMarca     := GetMark(),;
		 _nCol		 := 40,;
		 _nContar	 := 0,;
		 _nAddLin	 := 0,;
		 _nOpcion	 := 1,;
		 _nRegs      := 0,;
		 _nItem      := 0,;
		 _lMarcado	 := .F.,;
		 cStartPath  := GetSrvProfString('Startpath',''),;
	 	 cFileLogo	 := 'lgrl'+AllTrim(cEmpAnt)+cFilAnt+ '.bmp' ,;
		 cTitulo     := "Rela็ใo de Notas Fiscais por Fornecedor "

Private  _nTOTFIL := 0,;
         _nTOTFOR := 0,;  
		 _nTOTGER := 0

         IF Select("SD1TMP")
         	DbSelectArea("SD1TMP")
         	DbCloseArea()
         ENDIF

         BeginSQL Alias 'SD1TMP'

         	COLUMN D1_EMISSAO AS DATE
         	COLUMN D1_DTDIGIT AS DATE
         	COLUMN E2_VENCREA AS DATE         	

         	SELECT SD1.D1_FILIAL, SD1.D1_FORNECE, SD1.D1_LOJA, SD1.D1_EMISSAO, SD1.D1_DTDIGIT, SD1.D1_DOC, SD1.D1_SERIE, SD1.D1_ITEM, SD1.D1_COD, SD1.D1_UM, SD1.D1_LOCAL, SD1.D1_QUANT, SD1.D1_VUNIT, SD1.D1_TOTAL,
               SE2.E2_FILIAL, SE2.E2_FORNECE, SE2.E2_LOJA, SE2.E2_NUM, SE2.E2_PREFIXO, SE2.E2_NATUREZ, SE2.E2_VALOR, SE2.E2_VENCREA
            FROM %Table:SD1% SD1
               LEFT JOIN %Table:SE2% SE2 ON  SE2.E2_FORNECE = SD1.D1_FORNECE AND SE2.E2_LOJA = SD1.D1_LOJA  AND SE2.E2_NUM = SD1.D1_DOC AND SE2.E2_PREFIXO = SD1.D1_SERIE
            WHERE SD1.%NOTDEL% AND
               SE2.%NOTDEL% AND
		       SD1.D1_FILIAL  >= %Exp:MV_PAR01% AND
		       SD1.D1_FILIAL  <= %Exp:MV_PAR02% AND
		       SD1.D1_EMISSAO >= %Exp:MV_PAR03% AND
		       SD1.D1_EMISSAO <= %Exp:MV_PAR04% AND 
		       SD1.D1_DTDIGIT >= %Exp:MV_PAR05% AND
		       SD1.D1_DTDIGIT <= %Exp:MV_PAR06% AND 
               SE2.E2_NATUREZ >= %Exp:MV_PAR07% AND
               SE2.E2_NATUREZ <= %Exp:MV_PAR08% 
               ORDER BY SD1.D1_FILIAL, SD1.D1_FORNECE, SD1.D1_LOJA, SD1.D1_DTDIGIT, SD1.D1_DOC, SD1.D1_SERIE, SD1.D1_ITEM
               
         EndSql
         //memoWrite('C:\TEMP\RIOR126R.txt', GetLastQuery()[2])
    
         SD1TMP->(DbGoTop())
         SD1TMP->(DbEval({|| _nRegs++}))
         SD1TMP->(DbGoTop())

		_nLin   := 3000
		_nPag   := 0

        fPrintREL1()
		oPrint:Preview()
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica se a impressora esta ativa.ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If	! ( oPrint:IsPrinterActive() )
			Aviso('Impressora',OemToAnsi('As configura็๕es da Impressora nใo foram encontradas. Por favor, verifique as configura็๕es para utilizar este relat๓rio.'),{'OK'})
			oPrint:Setup()
			Return .f.
		EndIf		
		SD1TMP->(DbCloseArea())

Return


Static Function fPrintREL1()
Local _cCodFil := ''  
Local _cCodFor := ''
Local _cNomFor := ''

        oPrint:SetLandScape()

		While SD1TMP->( ! Eof() )
            fChkPag()

            IF SD1TMP->D1_FILIAL <> _cCodFil 
               oPrint:Say(_nLin,0000 , 'Filial : ['+SD1TMP->D1_FILIAL+'] '+FWFilialName(cEmpAnt,SD1TMP->D1_FILIAL), oFont10n ) 
		       _nLin += 40
		       oPrint:Line(_nLin,000,_nLin, _nColFim)
		       _nLin += 80
            Endif
            
            _cCodFil := SD1TMP->D1_FILIAL  
		    While SD1TMP->( ! EOF() ).AND. SD1TMP->D1_FILIAL == _cCodFil    

		    	IF SD1TMP->D1_FORNECE+SD1TMP->D1_LOJA <> _cCodFor 
		    	    _cNomFor := POSICIONE("SA2",1,xFilial("SA2")+SD1TMP->D1_FORNECE + SD1TMP->D1_LOJA,"A2_NOME")
		    		oPrint:Say(_nLin,0000 , 'Fornecedor : ['+SD1TMP->D1_FORNECE +' '+SD1TMP->D1_LOJA+'] '+ _cNomFor , oFont10n ) 
		            _nLin += 40
		            oPrint:Line(_nLin,000,_nLin, _nColFim)
		            _nLin += 80
		    	Endif
            
		    	fChkPag()
		    	
		    	_cCodFor := SD1TMP->D1_FORNECE+SD1TMP->D1_LOJA
		    	While SD1TMP->( ! EOF() ).AND. SD1TMP->D1_FORNECE+SD1TMP->D1_LOJA == _cCodFor   

		    		oPrint:Say(_nLin,0000, SD1TMP->D1_DOC     , oFont08 )
		    		oPrint:Say(_nLin,0160, DTOC(SD1TMP->D1_EMISSAO) , oFont08 )
		    		oPrint:Say(_nLin,0320, DTOC(SD1TMP->D1_DTDIGIT) , oFont08 )
		    		oPrint:Say(_nLin,0470, POSICIONE("SB1",1,xFilial("SB1")+SD1TMP->D1_COD,"B1_DESC") , oFont07 )
		    		oPrint:Say(_nLin,0930, TRANSFORM(SD1TMP->D1_QUANT   , '@E 999,999.99' )       , oFont08 )
		    		oPrint:Say(_nLin,1130, TRANSFORM(SD1TMP->D1_VUNIT   , '@E 9,999,999,999.99' ) , oFont08 )
		    		oPrint:Say(_nLin,1330, TRANSFORM(SD1TMP->D1_TOTAL   , '@E 9,999,999,999.99' ) , oFont08 )
		    		oPrint:Say(_nLin,1630, DTOC(SD1TMP->E2_VENCREA) , oFont08 )
		    		oPrint:Say(_nLin,1830, ALLTrim(SD1TMP->E2_NATUREZ)+' '+POSICIONE("SED",1,xFilial("SED")+SD1TMP->E2_NATUREZ,"ED_DESCRIC") , oFont07 )
                
		    		_nTOTFIL += SD1TMP->D1_TOTAL
		    		_nTOTFOR += SD1TMP->D1_TOTAL  
		    		_nTOTGER += SD1TMP->D1_TOTAL
 
		    		IncProc()
		    		fChkPag()

		    		SD1TMP->(DbSkip())
		    		_nLin += 40
		        
		    		_nItem++
		        
		    	End
		    	
		    	//_nLin += 40
		    	IF SD1TMP->D1_FORNECE+SD1TMP->D1_LOJA <> _cCodFor

		    		oPrint:Line(_nLin,000,_nLin, _nColFim) 
		    		_nLin += 40
		    		fChkPag()
		    		oPrint:Say(_nLin,0000 , 'Total Fornecedor ---> [ '+_cNomFor+' ]' , oFont08n )
		    		oPrint:Say(_nLin,1330 , TRANSFORM( _nTOTFOR , '@E 9,999,999,999.99' ) , oFont08n )

		    		_nTOTFOR := 0 		    		
		        
		    		_nLin += 40
		    		oPrint:Line(_nLin,000,_nLin, _nColFim)
		    		_nLin += 40 
		    		fChkPag()
		    		
		    	ENDIF  
		    	
		    End	
 
			//_nLin += 40
	        IF SD1TMP->D1_FILIAL <> _cCodFil

			   oPrint:Line(_nLin,000,_nLin, _nColFim) 
		       _nLin += 40
		       fChkPag()
               oPrint:Say(_nLin,0000 , 'Total Filial ------> [ '+FWFilialName(cEmpAnt,SD1TMP->D1_FILIAL)+' ]' , oFont08n )
               oPrint:Say(_nLin,1330 , TRANSFORM( _nTOTFIL , '@E 9,999,999,999.99' ) , oFont08n )

               _nTOTFIL := 0 
               
			   _nLin += 40
			   oPrint:Line(_nLin,000,_nLin, _nColFim) 
			   _nLin += 40
			   fChkPag()
		        
		    ENDIF  
              
		End		

        //IMPRIME O TOTAL GERAL DO RELATำRIO 
		oPrint:Line(_nLin,000,_nLin, _nColFim) 
		_nLin += 40
		fChkPag()
        oPrint:Say(_nLin,0000 , 'Total Geral ------> ' , oFont08n )
        oPrint:Say(_nLin,1330 , TRANSFORM(_nTOTGER  , '@E 9,999,999,999.99')  , oFont08n )
		_nLin += 40
		oPrint:Line(_nLin,000,_nLin, _nColFim) 
        
		_nTOTFIL := 0
		_nTOTFOR := 0  
		_nTOTGER := 0

		fChkPag()

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fChkPag() บAutor ณ                     บ Data ณ  02/03/2020บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica a linha, para imnprimir cabecalho.                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Funcao Principal                                           บฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fChkPag()

	IF _nLin >= 2300 
	    IF _nPag > 0
	       oPrint:EndPage()
	    Endif
		oPrint:StartPage()  
		fCabecRel()	           
	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fCabecRel  บAutor ณ                    บ Data ณ            บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime o Cabecalho.                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Funcao Principal                                           บฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fCabecRel()

   _nColFim := 2330
   
   _nLin := 0
   _nPag++

   //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   //ณImprime o cabecalho da empresa. !
   //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู 
   oPrint:Line(_nLin,000,_nLin,_nColFim)
   _nLin += 40       
   oPrint:SayBitmap(000,000,cStartPath+cFileLogo,220,120) 
   oPrint:Say(_nLin,400,AllTrim(SM0->M0_NOME),oFont10n)
   oPrint:Say(_nLin,_nColFim-250,"Pแg  "+StrZero(_nPag,),oFont08)
   oPrint:Say(_nLin,1000,cTitulo,oFont10n)  
   _nLin += 40
   oPrint:Say(_nLin,1050,'Digita็ใo : '+DTOC(MV_PAR05)+' a '+DTOC(MV_PAR06),oFont10n)  
   _nLin += 40
   
   oPrint:Say(_nLin,400,Transform(SM0->M0_CGC,'@R 99.999.999/9999-99'),oFont08)
   oPrint:Say(_nLin,_nColFim-250,"Data "+DtoC(dDataBase) ,oFont08)

   _nLin += 40
   oPrint:Line(_nLin,000,_nLin,_nColFim) 
   _nLin += 40
		    
   fCabCpos()
      
Return


Static Function fCabCpos()
   _nLin += 40
   fChkPag()
   
   oPrint:Say(_nLin,0000, "Documento"     , oFont08 )
   oPrint:Say(_nLin,0160, "Emissใo"       , oFont08 )
   oPrint:Say(_nLin,0320, "Digita็ใo"     , oFont08 )
   oPrint:Say(_nLin,0470, "Produto/Descri็ใo" , oFont08 )
   oPrint:Say(_nLin,1000, "Quant"         , oFont08 )
   oPrint:Say(_nLin,1230, "Vl.Unitario"   , oFont08 )
   oPrint:Say(_nLin,1430, "Total"         , oFont08 )
   oPrint:Say(_nLin,1630, "Venc. Real"    , oFont08 )
   oPrint:Say(_nLin,1830, "Natureza"      , oFont08 )
  
   _nLin += 40
   oPrint:Line(_nLin,000,_nLin,_nColFim) 

  _nLin += 40
   fChkPag()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บAutor  ณPaulo Schwind       บ Data ณ  29/02/2020 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidPerg()
	Local _aArea := GetArea()
	Local _cPerg := Padr(cPerg,10)

	Local _aRegs:={}
	Local _nI := 0
	Local _nJ := 0

	dbSelectArea('SX1')
	dbSetOrder(1)

	Aadd(_aRegs,{_cPerg,"01","Filial De                     ","                              ","                              ","mv_ch1","C",06,0,0,"G","                                                            ","mv_par01       ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","          ","                                                            ","SM0","S","   ","          "})
	Aadd(_aRegs,{_cPerg,"02","Filial At้                    ","                              ","                              ","mv_ch2","C",06,0,0,"G","                                                            ","mv_par02       ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","          ","                                                            ","SM0","S","   ","          "})
	Aadd(_aRegs,{_cPerg,"03","Emissใo De                    ","                              ","                              ","mv_ch3","D",08,0,0,"G","                                                            ","mv_par03       ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","          ","                                                            ","   ","S","   ","          "})
	Aadd(_aRegs,{_cPerg,"04","Emissao At้                   ","                              ","                              ","mv_ch4","D",08,0,0,"G","                                                            ","mv_par04       ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","          ","                                                            ","   ","S","   ","          "})
	Aadd(_aRegs,{_cPerg,"05","Digita็ใo De                  ","                              ","                              ","mv_ch5","D",08,0,0,"G","                                                            ","mv_par05       ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","          ","                                                            ","   ","S","   ","          "})
	Aadd(_aRegs,{_cPerg,"06","Digita็ใo At้                 ","                              ","                              ","mv_ch6","D",08,0,0,"G","                                                            ","mv_par06       ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","          ","                                                            ","   ","S","   ","          "})
	Aadd(_aRegs,{_cPerg,"07","Natureza De                   ","                              ","                              ","mv_ch7","C",10,0,0,"G","                                                            ","mv_par07       ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","          ","                                                            ","SED","S","   ","          "})
	Aadd(_aRegs,{_cPerg,"08","Natureza At้                  ","                              ","                              ","mv_ch8","C",10,0,0,"G","                                                            ","mv_par08       ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","               ","                                                            ","               ","               ","               ","          ","                                                            ","SED","S","   ","          "})

	For _nI:=1 to Len(_aRegs)
		If ! DbSeek(_cPerg+_aRegs[_nI,2])
			RecLock('SX1',.T.)
			For _nJ:=1 to FCount()
				If _nJ <= Len(_aRegs[_nI])
					FieldPut(_nJ,_aRegs[_nI,_nJ])
				Endif
			Next _nJ
			MsUnlock()
		Endif
	Next _nI
	RestArea(_aArea)
Return
