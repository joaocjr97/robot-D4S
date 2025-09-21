*** Variables ***
# Arquivo de variáveis para elementos da interface e dados não sensíveis
# Este arquivo pode ser commitado no repositório

# =============================================================================
# CONFIGURAÇÕES GERAIS
# =============================================================================

# Configurações de navegador
${BROWSER}           chrome
${TIMEOUT}           10s

# JavaScript para configurações
${setcookie}         document.cookie = "contratoazul_language=pt"

# =============================================================================
# ELEMENTOS DE LOGIN
# =============================================================================

${Email}             id=Email
${Passwd}            id=Passwd
${logar}             id=logar
${logoD4S}           //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img

# =============================================================================
# ELEMENTOS DE COFRE
# =============================================================================

${nomecofre}                id=nomeCofre
${btnSalvarCofre}           id=btnSalvarCofre
${CreateNewVault}           //*[@id="div-menu-desk"]/span[1]/a
${cofreEnvioLote}           //*[@id="uuid-cofre"]/option[2]

# =============================================================================
# BUSCA DE SIGNATÁRIO (01-busca-signatario.robot)
# =============================================================================

${buscaSignatario}           //*[@id="page-wrapper"]/div[2]/div[2]/div[1]/div/div/div/small/a[2]
${campoBuscaSignatario}      //*[@id="q"]
${resultadoBusca}            //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div[1]/div[2]/div/span/b
${linkDocumento}             //*[@id="contratos"]/tbody/tr[1]/td[3]/a
${novaViewblob}              //*[@id="viewblobdiv"]/div[2]/div[1]
${btnViewblob}               //*[@id="btn-viewblob-completa"]
${signatario}                //*[@id="lista-assinatura"]/table/tbody/tr/td[2]/div/b

# =============================================================================
# BUSCA DE TAGS (02-busca-tags.robot)
# =============================================================================

${buscaTags}         //*[@id="page-wrapper"]/div[2]/div[2]/div[1]/div/div/div/small/a[1]
${campoBusca}        //*[@id="form-cofre"]/div/ul/li/input
${btnBusca}          //*[@id="btnS"]
${viewblob}          //*[@id="btnNovoDoc"]
${tagViewblob}       //*[@id="btnshowdiv-tags-635fbe6a-53bc-4bab-b569-da512c267bd8"]/a
${urgenteTag}        //*[@id="div-tags-635fbe6a-53bc-4bab-b569-da512c267bd8"]/div/ul/li[1]/span

# =============================================================================
# LISTAR FASES (03-listar-fases.robot)
# =============================================================================
${cofre12}           //*[@id="liCofre_1414985"]/a
${btnFase}           //*[@id="divBtnMoveFase"]/button
${fase1}             //*[@id="divBtnMoveFase"]/ul/li[3]/a
${signatarios}       //span[contains(normalize-space(text()), 'AGUARDANDO SIGNATÁRIOS')]
${fase2}             //*[@id="divBtnMoveFase"]/ul/li[4]/a
${assinaturas}       //span[contains(normalize-space(text()), 'AGUARDANDO ASSINATURAS')]
${finalizado}        //span[contains(normalize-space(text()), 'FINALIZADO')]
${fase3}             //*[@id="divBtnMoveFase"]/ul/li[5]/a
${btnInicio}         //*[@id="page-wrapper"]/div[2]/div[1]/div[1]/a

# =============================================================================
# ENVIO DE DOCUMENTOS (05-envio-desk.robot, 06-envio-cofre.robot)
# =============================================================================

${botaoEnvio}        //*[@id="drop-zone"]/a/p[2]
${RELATIVE_PATH}     ${CURDIR}/../files/doc-testes.pdf
${Aguardandoenvio}   //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/span[1]
${selectCofre}       name=uuid-cofre
${selecionarCofre}   //*[@id="formUpload"]/select/option[157]
${fileupload}        id=fileupload
${novoArquivo}       id=label-new-file
${newfile}           //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div/div[1]/div[2]/ul/li[1]/a

# =============================================================================
# ASSINATURA (07-envio-assinatura.robot, 08-envio-grupo-assinatura.robot)
# =============================================================================

${incluirEmail}          //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/div[4]/div/div[2]/div[1]/span[1]/a
${botaoAssinatura}       //*[@id="enviar-para-assinatura"]
${botaoEnvio2}           //*[@id="btnSalvarDocumento"]
${faseEnviado}           //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/span[1]
${assinar}               //*[@id="adicionar-assinatura"]
${senhaConta}            id=senhaConta
${salvarAssinatura}      //*[@id="btnSalvarAssinatura"]
${verificaAssinatura}    //*[@id="viewblobdiv"]/div[2]/div[1]

# Elementos específicos para grupo de assinatura
${grupo}             //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/div[4]/div/div[2]/div[1]/span[3]/a
${filtroGrupo}       //*[@id="filtro-grupos"]
${selecionarGrupo}   //*[@id="tabela-grupos"]/tbody/tr[29]/td[2]/a

# =============================================================================
# TEMPLATE HTML (09-envio-template-html.robot)
# =============================================================================

${templateHTML}      //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div/div[1]/div[2]/ul/li[4]/a
${campoMarca}       //*[@id="keyt_marca"]
${campoLaranja}      //*[@id="keyt_laranja"]
${campoCor}          //*[@id="keyt_cor"]
${campoTrueFALSE}    //*[@id="keyt_trueFALSE"]
${campoRua}          //*[@id="keyt_rua"]
${campoLugares}      //*[@id="keyt_lugares"]
${campoRestaurant}   //*[@id="keyt_restaurant"]
${salvarTemplate}    //*[@id="btnSaveTemplate"]
${verificaEnvio}     //*[@id="email-assinatura"]

# =============================================================================
# TEMPLATE WORD (10-envio-template-word.robot)
# =============================================================================

${templateWORD}      //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div/div[1]/div[2]/ul/li[144]/a
${campoCodigo}       //*[@id="form_clientecodigo"]
${campoData}         //*[@id="form_data"]
${campoNomeFantasia}    //*[@id="form_clientenomefantasia"]
${campoCidade}       //*[@id="form_clientecidade"]
${campoEndereco}     //*[@id="form_clienteendereco"]
${campoBairro}       //*[@id="form_clientebairro"]
${campoCep}          //*[@id="form_clientecep"]

# =============================================================================
# ENVIO EM LOTE (11-envio-lote.robot)
# =============================================================================

${RELATIVE_PATH_LOTE}    ${CURDIR}/../files/planilha.xlsx
${lote}              //*[@id="page-wrapper"]/div[2]/div[1]/div[5]/a
${btnlote}           //*[@id="btnSaveTemplate"]
${campoCofre}        //*[@id="uuid-cofre"]
${cofreOption}       //*[@id="uuid-cofre"]/option[2]
${nomeEnvio}         //*[@id="div_up"]/input
${tipoDoc}           //*[@id="div_up"]/select[4]
${tempHTML}          //*[@id="div_up"]/select[4]/option[2]
${btnSalvarPf}       //*[@id="btnSavePf"]
${btnOpcao}          //*[@id="label-opcao-cofre"]
${selecionarDoc}     //*[@id="contratos"]/tbody/tr[1]/td[6]/div/ul/li[4]/a
${sucesso}           //*[@id="sucesso"]/h4
${processamento}     //*[@id="contratos"]/tbody/tr[1]/td[6]/div/ul/li[8]/a
${campoSenha}        //*[@id="senhaConta"]
${btnFim}            //*[@id="btnSalvarDocumento"]
${tagProcessando}    //small[contains(text(), 'ENVIADO PARA PROCESSAMENTO')]
${tagProcessado}     //small[contains(text(), 'PROCESSADO')]

# =============================================================================
# POWERFORM (12-envio-powerform.robot)
# =============================================================================

${CLM}                   //*[@id="page-wrapper"]/div[2]/div[1]/div[3]/div/a
${PowerForm}             //*[@id="page-wrapper"]/div[2]/div[1]/div[3]/div/ul/li[5]/a
${criarPowerForm}        //*[@id="btnSaveTemplate"]
${campoCofrePF}          //*[@id="uuid_cofre"]
${selecionarCofrePF}     //*[@id="uuid_cofre"]/option[2]
${campoTemplate}         //*[@id="uuid-template"]
${selecionarTemplate}    //*[@id="meus-templates"]/option[338]
${nomeDocumento}         //*[@id="nome_documento"]
${botaoContinuar}        //*[@id="docButton"]
${btntoken}              //*[@id="tokenCount"]/button
${campoEmail}            //*[@id="email_be7b9c59-e046-4f7f-999f-19f91b57c346"]
${btnEmail}              //*[@id="fillerButton"]
${btnsend}               //*[@id="pfv2-result"]/button
${btnSalvarPower}        //*[@id="btnSalvarPower"]
${modalPowerForm}        //*[@id="formPowerForm"]


# =============================================================================
# ASSINATURA EM LOTE (13-assinatura-lote.robot)
# =============================================================================

${botaoLote}         //*[@id="div-menu-desk"]/ul[1]/li[2]/a
${paginaLote}        //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div/div[3]
${botaoPagina5}      //*[@id="editable_paginate"]/ul/li[6]/a
${botaoPagina9}      //*[@id="editable_paginate"]/ul/li[10]/a
${botaoPagina13}     //*[@id="editable_paginate"]/ul/li[11]/a
${checkbox}          //*[@id="select_all"]
${botaoAssinarLote}  //a[contains(., 'Assinar em lote')]
${modal}             //*[@id="form-assinaturaend"]
${senhaContaLote}    //*[@id="senhaConta"]