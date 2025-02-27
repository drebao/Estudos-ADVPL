#INCLUDE 'Totvs.ch'
#INCLUDE 'Fwmvcdef.ch'
#INCLUDE 'FwEditPanel.ch
#INCLUDE "TopConn.ch"


User Function MVC2()

Local oBrowse

	oBrowse := FWmBrowse():New()

	oBrowse:SetDescription(" Clientes ")

	oBrowse:SetAlias("SZ2")

	oBrowse:Activate()
return


Static Function MenuDef()

	Local aRotina     := {}

	ADD OPTION aRotina    TITLE "Visualizar"      ACTION "VIEWDEF.MVC2"    OPERATION     2 ACCESS 0
	ADD OPTION aRotina    TITLE "Incluir"         ACTION "VIEWDEF.MVC2"    OPERATION     3 ACCESS 0
	ADD OPTION aRotina    TITLE "Alterar"         ACTION "VIEWDEF.MVC2"    OPERATION     4 ACCESS 0
	ADD OPTION aRotina    TITLE "Excluir"         ACTION "VIEWDEF.MVC2"    OPERATION     5 ACCESS 0

return aRotina

Return

Static Function ModelDef()

	Local oPaiSZ2     := FwFormStruct(1,"SZ2") 
	Local oFilhoSZ3    := FwFormStruct(1,"SZ3")


	Local oModel       := MPFormModel():New("MVCA2",/*bPre*/, /*bPos*/,  /*bCommit*/,/*bCancel*/)

	oModel:AddFields('SZ2MASTER', /*cOwner*/, oPaiSZ2, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )


	oModel:AddGrid("SZ3DETAIL","SZ2MASTER",oFilhoSZ3,,,,,)

	//oModel:SetRelation("SZ3DETAIL",{{"Z3_FILIAL","xFILIAL('SZ3')","Z3_IDCLI","Z2_CODIGO"}/*, {"ZA6_CDIAG", "ZA5_CDIAG"}*/},SZ3->(IndexKey(1)))

// Adiciona a chave primaria da tabela principal
	oModel:SetPrimarykey({"Z2_FILIAL","Z2_CODIGO"})



// Adiciona a descricao do Modelo de Dados
	oModel:SetDescription("CADASTRO DE CLIENTES")

// Adiciona a descri��o dos Componentes do Modelo de Dados
	oModel:GetModel("SZ2MASTER"):SetDescription("CLIENTE")

// Adiciona a descri��o dos Componentes do Modelo de Dados
	oModel:GetModel("SZ3DETAIL"):SetDescription("PRODUTO")


Return oModel

Static Function ViewDef()
	Local oView

//Invoco o Model da função que quero
	Local oModel    := FwLoadModel("MVC2")

	Local oPaiSZ2      := FwFormStruct(2,"SZ2")
	Local oFilhoSZ3    := FwFormStruct(2,"SZ3") //Detalhe
// Local oFilhoZB3    := FwFormStruct(2,"ZB3") //Detalhe


//Faço a instancia da função FwFormView para a variável oView
	oView   := FwFormView():New()

	oView:SetModel(oModel)

//Crio as views/visões/layout de cabeçalho e item, com as estruturas de dados criadas acima
	oView:AddField("VIEWSZ2",oPaiSZ2,"SZ2MASTER")
	oView:AddGrid("VIEWSZ3",oFilhoSZ3,"SZ3DETAIL")

//Faço o campo de Item ficar incremental
// oView:AddIncrementField("ZA6DETAIL","ZA6_CDIAG") //Soma 1 ao campo de Item

//Criamos os BOX horizontais para CABEÇALHO E ITENS
	oView:CreateHorizontalBox("CABEC",30) //70% do tamanho para cabeçalho
	oView:CreateHorizontalBox("GRID1",70)  //30% para itens


//Amarro as views criadas aos BOX criados
	oView:SetOwnerView("VIEWSZ2","CABEC")
	oView:SetOwnerView("VIEWSZ3","GRID1")


//Darei títulos personalizados ao cabeçalho e comentários do Pedido
	oView:EnableTitleView("VIEWSZ2","CLIENTE")
	oView:EnableTitleView("VIEWSZ3","PRODUTO")



return oView
