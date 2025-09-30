*** Variables ***
# Arquivo de variáveis para elementos da interface e dados não sensíveis
# Este arquivo pode ser commitado no repositório

# =============================================================================
# CONFIGURAÇÕES GERAIS
# =============================================================================

# Configurações de navegador
${BROWSER}           chrome
${BROWSER_HEADLESS}  headlessfirefox
${TIMEOUT}           60s
${TIMEOUT240s}       240s
${WINDOW_SIZE}       --window-size=1920,1080
${CHROME_OPTIONS}    add_argument(--headless),add_argument(--window-size=1920,1080)

# JavaScript para configurações
${cookie_script}        d4sign_ai_cofre = "1"

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
${IAmodal}           css:.modal-backdrop.in   

# =============================================================================
# ENVIO DE DOCUMENTOS (05-envio-desk.robot, 06-envio-cofre.robot)
# =============================================================================

${botaoEnvio}        //*[@id="drop-zone"]/a/p[2]
${RELATIVE_PATH}     ${EXECDIR}${/}data${/}files${/}doc-testes.pdf
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

${RELATIVE_PATH_LOTE}    ${EXECDIR}${/}data${/}files${/}planilha.xlsx
${lote}                  //*[@id="page-wrapper"]/div[2]/div[1]/div[5]/a
${btnlote}               //*[@id="btnSaveTemplate"]
${campoCofre}            //*[@id="uuid-cofre"]
${cofreOption}           //*[@id="uuid-cofre"]/option[2]
${nomeEnvio}             //*[@id="div_up"]/input
${tipoDoc}               //*[@id="div_up"]/select[4]
${tempHTML}              //*[@id="div_up"]/select[4]/option[2]
${btnSalvarPf}           //*[@id="btnSavePf"]
${btnOpcao}              //*[@id="label-opcao-cofre"]
${selecionarDoc}         //*[@id="contratos"]/tbody/tr[1]/td[6]/div/ul/li[4]/a
${sucesso}               //*[@id="sucesso"]/h4
${processamento}         //*[@id="contratos"]/tbody/tr[1]/td[6]/div/ul/li[8]/a
${campoSenha}            //*[@id="senhaConta"]
${btnFim}                //*[@id="btnSalvarDocumento"]
${tagProcessando}        //small[contains(text(), 'ENVIADO PARA PROCESSAMENTO')]
${tagProcessado}         //small[contains(text(), 'PROCESSADO')]

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


# =============================================================================
# LISTAGENS-API (API/Listagens-API.robot)
# =============================================================================

${BASE_URL}                    https://secure.d4sign.com.br/api/v1
${DOCUMENTS}                   documents
${LIST_ESPECIFIC_DOCUMENT}     897e47c8-7da2-4113-a4f6-2f2ebb9f21d0
${LIST_DOCUMENTS_PHASE}        3/status
${LIST_SAFE}                   safes
${UUID_SAFE}                   d671be3e-b1f7-42c3-bbda-15ff037c1bec/safe
${UUID_WEBHOOK}                1c42fc63-4c84-4f9e-a9ad-3052879770fb/webhooks
${CI_SESSION}                  harpa7oriaddlltqtain0bje8h3h5fqo
${UUID_SAFE1}                  27431c09-bf98-418b-8727-1abfabae28c9
${MIME_TYPE}                   application/pdf   
${NOME}                        Documento Base64 API
${NOME_HASH}                   Documento Hash API
# =============================================================================
# CONFIGURAÇÕES DE PINS PARA DOCUMENTOS
# =============================================================================
${PAGE_WIDTH}                  794
${PAGE_HEIGHT}                 1123
${PAGE}                        1

# Pin 1 - Assinatura (canto superior esquerdo)
${POS_X_0}                     100
${POS_Y_0}                     150
${TYPE_0}                      0  # 0 assinatura, 1 rubrica, 2 selo

# Pin 2 - Rubrica (centro)
${POS_X_1}                     397
${POS_Y_1}                     300
${TYPE_1}                      1

# Pin 3 - Selo (canto inferior direito)
${POS_X_2}                     600
${POS_Y_2}                     500
${TYPE_2}                      2
${UUID_PINS}                   1e9e4c4b-0b97-47d3-b7a6-59c5e587a089
# =============================================================================
# CONFIGURAÇÕES DE TEMPLATE WORD
# =============================================================================
${template_id}                   MTkxMTEz
${nome_template_word}            Template Word de Testes QA.docx
${nome_razao_social}             TechTECH Soluções em Tecnologia Ltda.
${PF_PF}                         Pessoa Jurídica
${CNPJ_CPF}                      25.999.888/0001-77
${rua_numero}                    Alameda Santos, 2250, 10º andar
${bairro}                        Cerqueira César
${cidade}                        São Paulo
${Estado_UF}                     SP
${cep}                           01419-002
${RAZAOSOCIAL_NOME}              InovaTech Soluções em Tecnologia Ltda.
${tipopjoupf}                    PJ
${nomerepresentante}             Fernanda Costa Ribeiro
${cpfrepresentante}              888.777.666-55
${veiculo1}                      Veículo Leve
${qtdveic1}                      10
${Valor_Veic1}                   320,00
${veiculo2}                      Veículo Utilitário
${qtdveic2}                      5
${Valor_Veic2}                   450,00
${veiculo3}                      Motocicleta Executiva
${qtdveic3}                      8
${Valor_Veic3}                   210,00
${datainicialcontrato}           29 de setembro de 2025
# =============================================================================
# CONFIGURAÇÕES DE TEMPLATE HTML
# =============================================================================
${TEMPLATE_ID_HTML}       NjMyMTg=
${NOME_DOC_HTML}          Relatório de QA - Temp HTML
${MARCA_VAR}              Carro
${LARANJA_VAR}            Fruta
${COR_VAR}                Azul
${TRUEFALSE_VAR}          true
${RUA_VAR}                Avenida Paulista
${LUGARES_VAR}            Parque Ibirapuera
${RESTAURANT_VAR}         Restaurante Fictício
# =============================================================================
# CONFIGURAÇÕES DE SIGNATÁRIOS
# =============================================================================
${EMAIL_INICIAL}     primeiro.email.teste@robot.com
${EMAIL_ALTERADO}    signatario.alterado@teste.com
${WHATSAPP_TESTE}    5511954976905
# ==============================================================================
# DADOS DE TESTE PARA O WEBHOOK
# ==============================================================================
${UUID_DOC_WEBHOOK}      0eeb2925-382e-4e64-a072-8be770f786d3
${URL_WEBHOOK}           https://superteste.requestcatcher.com